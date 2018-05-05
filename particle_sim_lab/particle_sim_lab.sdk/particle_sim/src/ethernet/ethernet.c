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

void udp_numparts_get_handler(void *arg, struct udp_pcb *pcb, struct pbuf *p,
		struct ip_addr *addr, u16_t port) {
	if (p) { //Must check that a valid protocol control block was received
		char* payload = (char *) p->payload;
		printf("Message: %s\n", payload);

		numParts = strToInt(getNumParts(payload));
		curPart = 0;

		udp_remove(pcb);
		requestPart(curPart);
		pbuf_free(p);
	}
}

void udp_part_get_handler(void *arg, struct udp_pcb *pcb, struct pbuf *p,
		struct ip_addr *addr, u16_t port) {
	if (p) { //Must check that a valid protocol control block was received
		char* payload = (char *) p->payload;
		printf("Message: %s\n", payload);

		//process part
//		splitData(payload);
		char **data;
		int k = 0;
		int count = 0;

//		remove_all_chars(payload, '.');
		char* particle = "...........";
		char* attractor = "......";

		char* result = NULL;
		result = replaceString(payload, particle, ",");
		result = replaceString(result, attractor, ",");

		char *payload_cpy, *tofree;
		tofree = payload_cpy = strdup(result);

		split(payload_cpy, ',', &data, &count);
		for (k = 0; k < count; k++) {
			printf("%s\n", data[k]);
		}

		free(result);
		free(tofree);

//		curPart += 1;
//		if (curPart > numParts - 1) {
//			//all parts received
//			//populate simulation
//			udp_remove(pcb);
//			pbuf_free(p);
//		} else {
//			udp_remove(pcb);
//			requestPart(curPart);
//			pbuf_free(p);
//		}

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
}

void setupEthernet() {
	init_ethernet_platform(ms1516_mac_address, NULL, NULL);
	IP4_ADDR(&serverIP, 192, 168, 10, 1);
	serverPort = 51200;
}
