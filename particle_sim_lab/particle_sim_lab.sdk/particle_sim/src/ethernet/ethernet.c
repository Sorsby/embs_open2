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

#define TIMER_START 500000000

unsigned char ms1516_mac_address[] = { 0x00, 0x11, 0x22, 0x33, 0x00, 0x26 };
ip_addr_t serverIP;
int serverPort;

int scenarioId;
int numParts = 0;
int* parts;
int nextPart = 0;
int hasAllData = FALSE;

XScuTimer timer;
XScuTimer_Config *timercfg;

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

void requestScenario(int id) {
	hasAllData = FALSE;
	scenarioId = id;
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
	puts(message);
	sendMessage(message);
}

void udp_numparts_get_handler(void *arg, struct udp_pcb *pcb, struct pbuf *p,
		struct ip_addr *addr, u16_t port) {
	if (p) {
		printf("Message: %s\n", (char *) p->payload);

		numParts = strToInt(getNumParts((char *) p->payload));

		udp_remove(pcb);
		pbuf_free(p);

		requestPart(0);
	}
}

int getNext(cur) {
	return cur + 1;
}

void udp_part_get_handler(void *arg, struct udp_pcb *pcb, struct pbuf *p,
		struct ip_addr *addr, u16_t port) {
	if (p) {
//		printf("Message: %s\n", (char *) p->payload);

////		splitData(payload);
//		char **data;
//		int k = 0;
//		int count = 0;
//
////		remove_all_chars(payload, '.');
//		char* particle = "...........";
//		char* attractor = "......";
//
//		char* result = NULL;
//		result = replaceString(payload, particle, ",");
//		result = replaceString(result, attractor, ",");
//
//		char *payload_cpy, *tofree;
//		tofree = payload_cpy = strdup(result);
//
//		split(payload_cpy, ',', &data, &count);
//		for (k = 0; k < count; k++) {
//			printf("%s\n", data[k]);
//		}
//
//		free(result);
//		free(tofree);
		nextPart = getNext(nextPart);

		udp_remove(pcb);
		pbuf_free(p);

		puts("cleared blocks n buffers");
		if (nextPart == numParts) {
			hasAllData = TRUE;
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
	udp_sendto(send_pcb, reply, &serverIP, serverPort);

	pbuf_free(reply);
	udp_remove(send_pcb);

	int count = 0;
	int elapsed = 0;
	while(!hasAllData) {
		startTimer();
		printf("timer: %d\n", elapsed);
		if (elapsed > 2000) {
			puts("timeout");
			udp_remove(recv_pcb);
			break;
		}
		handle_ethernet();
		count = stopTimer();
		elapsed += (TIMER_START - count)/XPAR_CPU_CORTEXA9_0_CPU_CLK_FREQ_HZ;
	}

//	while(!hasAllData) {
//		startTimer();
//		if (elapsed > 100) {
//			puts("timeout");
//			udp_remove(recv_pcb);
//			sendMessage(message);
//			handle_ethernet();
//			break;
//		} else {
//			handle_ethernet();
//			elapsed += (TIMER_START - stopTimer()) / XPAR_CPU_CORTEXA9_0_CPU_CLK_FREQ_HZ;
//		}
//	}
}

void setupEthernet() {
	init_ethernet_platform(ms1516_mac_address, NULL, NULL);
	IP4_ADDR(&serverIP, 192, 168, 10, 1);
	serverPort = 51200;
}
