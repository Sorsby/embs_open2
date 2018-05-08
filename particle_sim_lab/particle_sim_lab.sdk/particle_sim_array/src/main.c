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

int ram[RAM_SIZE];

char input_byte;
int printFPS = FALSE;

int i;
int num_particles = 2000;
int num_attractors = 10;

//struct Particle *particles;
//struct Attractor *attractors;

void populateSimulation();
void populateSimulationArray();

//void freeMemory() {
//	free(particles);
//	free(attractors);
//}

void getParams() {
	num_particles = readInput("Enter a number of particles:");
	num_attractors = readInput("Enter a number of attractors:");
//	freeMemory();
//	populateSimulation();
	populateSimulationArray();
}

void populateSimulationArray() {
	for (i = 0; i < num_particles * PARTICLE_SIZE; i += PARTICLE_SIZE) {
		int random_x = rand() % 1440 + 1;
		int random_y = rand() % 900 + 1;

		ram[i] = random_x;
		ram[i + 1] = random_y;
		ram[i + 2] = 0;
		ram[i + 3] = 0;
	}

	for (i = 0; i < num_attractors * ATTRACTOR_SIZE; i += ATTRACTOR_SIZE) {
		int random_x = rand() % 1440 + 1;
		int random_y = rand() % 900 + 1;

		int random_g;
		if (i >= num_attractors / 2) {
			random_g = (rand() % (10 * (int) FLOAT_ACCURACY + 1))
					+ 10 * FLOAT_ACCURACY;
		} else {
			random_g = (rand() % (5 * (int) FLOAT_ACCURACY + 1))
					- 10 * FLOAT_ACCURACY;
		}

		ram[PARTICLE_END + i + 1] = random_x;
		ram[PARTICLE_END + i + 2] = random_y;
		ram[PARTICLE_END + i + 3] = random_g;
	}
}

void populateSimulationFromNetworkArray(int* newRam, int newNumParticles,
		int newNumAttractors) {
	num_particles = newNumParticles;
	num_attractors = newNumAttractors;
	memcpy(ram, newRam, RAM_SIZE);
	resetEthernet();
}

//void populateSimulationFromNetwork(int newNumParticles, int newNumAttractors,
//		struct Particle *newParticles, struct Attractor *newAttractors) {
//	num_particles = newNumParticles;
//	num_attractors = newNumAttractors;
//
//	memcpy(particles, newParticles, PARTICLE_ARRAY_SIZE);
//	memcpy(attractors, newAttractors, ATTRACTOR_ARRAY_SIZE);
//	resetEthernet();
//}

//void populateSimulation() {
//	particles = malloc(PARTICLE_ARRAY_SIZE * sizeof(struct Particle));
//	attractors = malloc(ATTRACTOR_ARRAY_SIZE * sizeof(struct Attractor));
//
//	for (i = 0; i < num_particles; i++) {
//		int random_x = rand() % 1440;
//		int random_y = rand() % 900;
//		struct Particle particle = { .x = random_x, .y = random_y, .vx = 0,
//				.vy = 0 };
//		particles[i] = particle;
//	}
//
//	for (i = 0; i < num_attractors; i++) {
//		int random_x = rand() % 1440;
//		int random_y = rand() % 900;
//		float random_g;
//		if (i >= num_attractors / 2) {
//			random_g = (rand() % 1) + 1;
//		} else {
//			random_g = (rand() % 1) - 1.5;
//		}
//		struct Attractor attractor = { .x = random_x, .y = random_y, .g =
//				random_g };
//		attractors[i] = attractor;
//	}
//}

void handleInput() {
	if (XUartPs_IsReceiveData(STDIN_BASEADDRESS)) {
		char byte = XUartPs_RecvByte(STDIN_BASEADDRESS);

		switch (byte) {
		//networked init
		case 'e':
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
		}
	}
}

int main(void) {
//	init_platform();

	puts("\n\n\n");

	setupVGA();
	setupEthernet();
//	populateSimulation();
	populateSimulationArray();

	while (1) {

		handleInput();
		handleEthernet();

//		updateSimulation(&particles[0], &attractors[0], num_particles,
//				num_attractors);
		puts("start sim");
		updateSimulationArray(&ram[0], num_particles, num_attractors);
//		updateFrame(&particles[0], &attractors[0], num_particles,
//				num_attractors);
		puts("start draw");
		updateFrameFromArray(&ram[0], num_particles, num_attractors);
		frame_timer();

		if (printFPS) {
			printf("FPS: %f\n", get_fps());
		}
	}

//	cleanup_platform();
	cleanup_ethernet_platform();
//	freeMemory();
	return 0;
}
