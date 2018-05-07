/*
 * ethernet.c
 *
 *  Created on: 4 May 2018
 *      Author: Matthew
 */

#include <stdio.h>
#include "xparameters.h"
#include "xil_printf.h"
#include "xil_cache.h"
#include "ethernet_platform.h"
#include "../util/util.h"
#include <xscutimer.h>
#include "../simulation/simulation.h"
#include "../main.h"

#define TIMER_START 500000000
#define PARTICLE_ARRAY_SIZE 20000
#define ATTRACTOR_ARRAY_SIZE 500

#define DATA_OBJECT_LENGTH 22

unsigned char ms1516_mac_address[] = { 0x00, 0x11, 0x22, 0x33, 0x00, 0x26 };
ip_addr_t serverIP;
int serverPort;

int scenarioId;
int numParts = 0;
int nextPart = 0;

XScuTimer timer;
XScuTimer_Config *timercfg;

int numParticles = 0;
int numAttractors = 0;
struct Particle *particles;
struct Attractor *attractors;

void sendMessage(char *message);

void startTimer() {
	timercfg = XScuTimer_LookupConfig(XPAR_SCUTIMER_DEVICE_ID);
	XScuTimer_CfgInitialize(&timer, timercfg, timercfg->BaseAddr);

	XScuTimer_LoadTimer(&timer, TIMER_START);
	XScuTimer_Start(&timer);
}

int stopTimer() {
	XScuTimer_Stop(&timer);
	return XScuTimer_GetCounterValue(&timer);
}

void freeEthernetMemory() {
	free(particles);
	free(attractors);
}

void requestScenario(int id) {
	scenarioId = id;
	nextPart = 0;
	freeEthernetMemory();

	printf("Get ScenarioID: %d, from the server.\n", id);
	char buffer[5];
	char *message = NULL;
	snprintf(buffer, 5, "%04d", id);
	sprintf(message, "NUMPARTS,%s", buffer);
	sendMessage(message);
}

void requestPart(int partId) {
	printf("Getting part: %d\n", partId);
	char buffera[5];
	char bufferb[5];
	snprintf(buffera, 5, "%04d", scenarioId);
	snprintf(bufferb, 5, "%04d", partId);
	char *message = NULL;
	sprintf(message, "GETPART,%s,%s", buffera, bufferb);
	sendMessage(message);
}

void udp_numparts_get_handler(void *arg, struct udp_pcb *pcb, struct pbuf *p,
		struct ip_addr *addr, u16_t port) {
	if (p) {
		printf("Message: %s\n", (char *) p->payload);

		numParts = strToInt(getNumParts((char *) p->payload));
		particles = malloc(PARTICLE_ARRAY_SIZE * sizeof(struct Particle));
		attractors = malloc(ATTRACTOR_ARRAY_SIZE * sizeof(struct Attractor));

		udp_remove(pcb);
		pbuf_free(p);

		requestPart(0);
	}
}

int getNext( cur) {
	return cur + 1;
}

void udp_part_get_handler(void *arg, struct udp_pcb *pcb, struct pbuf *p,
		struct ip_addr *addr, u16_t port) {
	if (p) {
//		printf("Message: %s\n", (char *) p->payload);
		char response[2000];
		strcpy(response, (char *) p->payload);

		char* pResponseParser;
		pResponseParser = response;
		pResponseParser += 15; //move pointer to first data

		char lenStr[5];
		strncpy(lenStr, pResponseParser, 5);
		lenStr[4] = '\0';
		int dataLength = atoi(lenStr);

		pResponseParser += 5; //move to first object

		//loop length of data
		int objectCount = 0;
		while (objectCount < (dataLength / DATA_OBJECT_LENGTH)) {
			char particle[12];
			char attractor[17];

			char *px;
			char *py;
			char *pg;

			char x[5];
			char y[5];
			char g[5];
			switch (*pResponseParser) {

			case 'P':
				strncpy(particle, pResponseParser, 12);
				particle[11] = '\0';

				px = &particle[2];
				strncpy(x, px, 5);
				x[4] = '\0';

				py = &particle[7];
				strncpy(y, py, 5);
				y[4] = '\0';

				struct Particle particle = { .x = atoi(x), .y = atoi(y),
						.vx = 0, .vy = 0 };
				particles[numParticles] = particle;
				numParticles += 1;
				break;
			case 'A':
				strncpy(attractor, pResponseParser, 17);
				attractor[16] = '\0';

				px = &attractor[2];
				strncpy(x, px, 5);
				x[4] = '\0';

				py = &attractor[7];
				strncpy(y, py, 5);
				y[4] = '\0';

				pg = &attractor[12];
				strncpy(g, pg, 5);
				g[4] = '\0';

				struct Attractor attractor = { .x = atof(x), .y = atoi(y), .g =
						atoi(g) };
				attractors[numAttractors] = attractor;
				numAttractors += 1;
				break;
			}
			objectCount += 1;
			pResponseParser += 22;
		}

		nextPart = getNext(nextPart);
		udp_remove(pcb);
		pbuf_free(p);

		if (nextPart == numParts) {
			printf("num particles: %d\n", numParticles);
			printf("num attractor: %d\n", numAttractors);
			populateSimulationFromNetwork(numParticles, numAttractors, particles, attractors);
			return;
			//all parts received
			//populate simulation
		} else {
			requestPart(nextPart);
		}
	}
}

void sendMessage(char *message) {

	struct udp_pcb *recv_pcb = udp_new();
	if (!recv_pcb) {
		printf("Error creating PCB\n");
	}

	//Listen on port serverPort
	udp_bind(recv_pcb, IP_ADDR_ANY, serverPort);

	//Set up the receive handler
	char* type = getRequestType(message);
	if (strcmp(type, "GETPART") == 0) {
		udp_recv(recv_pcb, udp_part_get_handler, NULL);
	} else {
		udp_recv(recv_pcb, udp_numparts_get_handler, NULL);
	}

	//Create a protocol control block (PCB)
	struct udp_pcb *send_pcb = udp_new();
	//Create a packet buffer
	struct pbuf * reply = pbuf_alloc(PBUF_TRANSPORT, strlen(message), PBUF_REF);
	reply->payload = message;
	reply->len = strlen(message);

	//Send it and clean up
	err_t er;
	er = udp_sendto(send_pcb, reply, &serverIP, serverPort);
//	printf("error: %d\n", er);

	pbuf_free(reply);
	udp_remove(send_pcb);
}

void setupEthernet() {
	init_ethernet_platform(ms1516_mac_address, NULL, NULL);
	IP4_ADDR(&serverIP, 192, 168, 10, 1);
	serverPort = 51200;
}
