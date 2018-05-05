#ifndef __PLATFORM_H_
#define __PLATFORM_H_

#define PLATFORM_EMAC_BASEADDR XPAR_XEMACPS_0_BASEADDR

#include <lwip/ip_addr.h>
#include "lwip/tcp.h"
#include "netif/xadapter.h"
#include <lwip/ip_addr.h>
#include <lwip/udp.h>

int init_ethernet_platform(unsigned char *mac_ethernet_address, struct ip_addr *ipaddr, struct ip_addr *netmask);
void handle_ethernet();

#endif
