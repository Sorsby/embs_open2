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

unsigned char ms1516_mac_address[] = { 0x00, 0x11, 0x22, 0x33, 0x00, 0x26 };
ip_addr_t serverIP;
int serverPort;

int scenarioId;
int numParts;
int curPart;

void sendMessage(char *message);

void requestScenario(int id) {
	scenarioId = id;
	printf("Get ScenarioID: %d, from the server.\n", scenarioId);
	char buffer[5];
	char message[14];
	snprintf(buffer, 5, "%04d", scenarioId);
	sprintf(message, "NUMPARTS,%s", buffer);
	sendMessage(message);
}

void requestPart(int partId) {
	printf("Getting part: %d\n", partId);
	char buffera[5];
	char bufferb[5];
	snprintf(buffera, 5, "%04d", scenarioId);
	snprintf(bufferb, 5, "%04d", partId);
	char message[18];
	sprintf(message, "GETPART,%s,%s", buffera, bufferb);
	puts(message);
	sendMessage(message);
}

void udp_get_handler(void *arg, struct udp_pcb *pcb, struct pbuf *p,
		struct ip_addr *addr, u16_t port) {
	if (p) { //Must check that a valid protocol control block was received
		char* payload = (char *) p->payload;
		printf("Message: %s\n", payload);

		char* type = getRequestType(payload);
		puts(type);
		if (strcmp(type, "NUMP") == 0) {
			numParts = strToInt(getNumParts(payload));

			curPart = 0;
			udp_remove(pcb);
			requestPart(curPart);
			pbuf_free(p);
		} else if (strcmp(type, "PART") == 0) {
			//process part
			curPart += 1;
			if (curPart > numParts - 1) {
				//all parts received
				//populate simulation
			} else {
				udp_remove(pcb);
				requestPart(curPart);
				pbuf_free(p);
			}

		}
	} else {
		puts("invalid pcb recv");
	}
}

void sendMessage(char *message) {

	struct udp_pcb *recv_pcb = udp_new();
	if (!recv_pcb) {
		printf("Error creating PCB\n");
	}

	//Listen on port serverPort
	udp_bind(recv_pcb, IP_ADDR_ANY, serverPort);
	puts("bound recv pcb");
	//Set up the receive handler
	udp_recv(recv_pcb, udp_get_handler, NULL);
	puts("set handler");
	//Create a protocol control block (PCB)
	struct udp_pcb *send_pcb = udp_new();
	//Create a packet buffer
	struct pbuf * reply = pbuf_alloc(PBUF_TRANSPORT, strlen(message), PBUF_REF);
	reply->payload = message;
	reply->len = strlen(message);
	puts("constructed request");
	//Send it and clean up
	udp_sendto(send_pcb, reply, &serverIP, serverPort);
	puts("sent request");

	pbuf_free(reply);
	udp_remove(send_pcb);
}

void setupEthernet() {
	init_ethernet_platform(ms1516_mac_address, NULL, NULL);
	IP4_ADDR(&serverIP, 192, 168, 10, 1);
	serverPort = 51200;
}
