/*
 * main.c
 *
 *  Created on: 4 May 2018
 *      Author: Matthew
 */

#include <stdio.h>
#include "xparameters.h"
#include "platform.h"
#include "xil_printf.h"
#include "xil_cache.h"

void udp_numparts_get_handler(void *arg, struct udp_pcb *pcb, struct pbuf *p, struct ip_addr *addr, u16_t port) {
    if(p) { //Must check that a valid protocol control block was received
        printf("Message: %s\n", (char *)p->payload);

        //Send a reply to the address which messaged us on port 7000
        //udp_sendto(pcb, p, addr, 7000);

        //Don't forget to free the protocol control block
        pbuf_free(p);
    }
}

int main() {
    unsigned char ms1516_mac_address[] = {0x00, 0x11, 0x22, 0x33, 0x00, 0x26}; // Put your own MAC address here!
    init_ethernet_platform(ms1516_mac_address, NULL, NULL);

    struct udp_pcb *recv_pcb = udp_new();
    if(!recv_pcb) {
        printf("Error creating PCB\n");
    }

    //Listen on port 51000
    udp_bind(recv_pcb, IP_ADDR_ANY, 51000);
    //Set up the receive handler
    udp_recv(recv_pcb, udp_numparts_get_handler, NULL);

    char *message = "Ethernet test msg.";
    //Send an initial message
    //Create a protocol control block (PCB)
    struct udp_pcb *send_pcb = udp_new();
    //Create a packet buffer
    struct pbuf * reply = pbuf_alloc(PBUF_TRANSPORT, strlen(message), PBUF_REF);
    reply->payload = message;
    reply->len = strlen(message);
    //Send it and clean up
    ip_addr_t ip;
    IP4_ADDR(&ip, 192, 168, 10, 1);
    udp_sendto(send_pcb, reply, &ip, 51000);
    pbuf_free(reply);
    udp_remove(send_pcb);

    //Now enter the handling loop
    while(1) {
        handle_ethernet();
    }
    return 0;
}
