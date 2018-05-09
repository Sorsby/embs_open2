#include <stdio.h>
#include <stdlib.h>
#include "xil_types.h"
#include "xil_cache.h"
#include "xparameters.h"
#include "zybo_vga/display_ctrl.h"
#include "xuartps_hw.h"

#include "fps/fps.h"
#include "simulation/simulation.h"
#include "uart/input.h"
#include "vga/vga.h"
#include "ethernet/ethernet.h"
#include "ethernet/ethernet_platform.h"
#include "def.h"
#include "util/util.h"

#include "xtoplevel.h"
#include "xil_cache.h"

float ram[RAM_SIZE];
XToplevel hls;

char input_byte;
int printFPS = FALSE;
int readyToSimulate = TRUE;

int i;
int num_particles = 2000;
int num_attractors = 10;

void populateSimulation();
void populateSimulationArray();

/*
 * Read input params from uart and populate the simulation with those values
 */
void getParams() {
	num_particles = readInput("Enter a number of particles:");
	num_attractors = readInput("Enter a number of attractors:");
	readyToSimulate = FALSE;
	populateSimulationArray();
	readyToSimulate = TRUE;
}

/*
 * Populate simulation with random data
 */
void populateSimulationArray() {
	for (i = 0; i < num_particles * PARTICLE_SIZE; i += PARTICLE_SIZE) {
		float random_x = rand() % 1440;
		float random_y = rand() % 900;

		ram[i] = random_x;
		ram[i + 1] = random_y;
		ram[i + 2] = 0;
		ram[i + 3] = 0;
	}

	for (i = PARTICLE_END; i < PARTICLE_END + (num_attractors * ATTRACTOR_SIZE); i += ATTRACTOR_SIZE) {
		float random_x = rand() % 1440;
		float random_y = rand() % 900;

		//generate some pseudo random floats between range given
		float random_g;
		if (i > (PARTICLE_END + (num_attractors * ATTRACTOR_SIZE)) / 2) {
			random_g = ((rand() % (2000+1-1000)) + 1000)/1000.0;
		} else {
			random_g = ((rand() % (5000+1-10000)) - 10000)/10000.0;
		}

		ram[i + 1] = random_x;
		ram[i + 2] = random_y;
		ram[i + 3] = random_g;
	}
}

/*
 * Use networked data to populate the scenario
 */
void populateSimulationFromNetworkArray(float* newRam, int newNumParticles,
		int newNumAttractors) {
	num_particles = newNumParticles;
	num_attractors = newNumAttractors;
	memcpy(ram, newRam, RAM_SIZE);
	resetEthernet();
	readyToSimulate = TRUE;
}

/*
 * Handles the different input shortcut keys
 */
void handleInput() {
	if (XUartPs_IsReceiveData(STDIN_BASEADDRESS)) {
		char byte = XUartPs_RecvByte(STDIN_BASEADDRESS);

		switch (byte) {
		//networked init
		case 'e':
			readyToSimulate = FALSE;
			requestScenario(
					readInput("Enter the ScenarioID you wish to request:"));
			break;
			//toggle fps
		case 'f':
			printFPS = !printFPS;
			break;
			//random init
		case 'r':
			getParams();
			break;
		case 'x':
			puts("User interrupt request");
			resetEthernet();
			readyToSimulate = TRUE;
			break;
		}
	}
}

/*
 * Main program loop
 */
int main(void) {
	puts("\n\n\n");

	setupVGA();
	setupEthernet();
	populateSimulationArray();
//    XToplevel_Initialize(&hls, XPAR_TOPLEVEL_0_DEVICE_ID);
//    XToplevel_Set_ram(&hls, &ram);

	while (1) {
		handleInput();
		handleEthernet();

		if (readyToSimulate == TRUE) {
//		    XToplevel_Set_numP(&hls, num_particles);
//		    XToplevel_Set_numA(&hls, num_attractors);
//
//		    XToplevel_Start(&hls);
//		    while(!XToplevel_IsDone(&hls));
//			Xil_DCacheFlush();
//My HLS implementation was slower than in software ????!!!! I lost time due to using structs so didn't manage to fix

			updateSimulationArray(ram, num_particles, num_attractors);
			updateFrameFromArray(ram, num_particles, num_attractors);
			frame_timer();
		}

		if (printFPS) {
			printf("FPS: %f\n", get_fps());
		}
	}

	cleanup_ethernet_platform();
	return 0;
}
