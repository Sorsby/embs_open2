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

unsigned char ms1516_mac_address[] = {0x00, 0x11, 0x22, 0x33, 0x00, 0x26};

void sendMessage(char *message);

void udp_get_handler(void *arg, struct udp_pcb *pcb, struct pbuf *p, struct ip_addr *addr, u16_t port) {
    if(p) { //Must check that a valid protocol control block was received
        printf("Message: %s\n", (char *)p->payload);

        //Send a reply to the address which messaged us on port 7000
//        udp_sendto(pcb, p, addr, port);

        printf("%s\n",getNumParts((char *)p->payload));

//        sendMessage((char *)p->payload);

        //Don't forget to free the protocol control block
        pbuf_free(p);
        udp_remove(pcb);
    }
}

void sendMessage(char *message) {
	ip_addr_t serverIP;
	int serverPort = 51200;
    IP4_ADDR(&serverIP, 192, 168, 10, 1);

    struct udp_pcb *recv_pcb = udp_new();
    if(!recv_pcb) {
        printf("Error creating PCB\n");
    }

    //Listen on port serverPort
    udp_bind(recv_pcb, IP_ADDR_ANY, serverPort);
    //Set up the receive handler
    udp_recv(recv_pcb, udp_get_handler, NULL);
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

void requestScenario(int scenarioId) {
	printf("Get ScenarioID: %d, from the server.\n", scenarioId);
	char buffer[5];
	char message[14];
	snprintf(buffer, 5, "%04d", scenarioId);
	sprintf(message, "NUMPARTS,%s", buffer);
	sendMessage(message);
}

void setupEthernet() {
    init_ethernet_platform(ms1516_mac_address, NULL, NULL);
}
