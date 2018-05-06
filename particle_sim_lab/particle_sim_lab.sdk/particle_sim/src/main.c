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

#define TRUE 1
#define FALSE 0

char input_byte;
int printFPS = FALSE;

int i;
int num_particles = 2000;
int num_attractors = 10;

struct Particle *particles;
struct Attractor *attractors;

void populateSimulation();

void freeMemory() {
	free(particles);
	free(attractors);
}

void getParams() {
	num_particles = readInput("Enter a number of particles:");
	num_attractors = readInput("Enter a number of attractors:");
	freeMemory();
	populateSimulation();
}

void populateSimulation() {
//	puts("populate sim");
//	printf("p %d", num_particles);
//	printf("a %d", num_attractors);
	particles = malloc(num_particles * sizeof(struct Particle));
	attractors = malloc(num_attractors * sizeof(struct Attractor));

	for (i = 0; i < num_particles; i++) {
		int random_x = rand() % 1440;
		int random_y = rand() % 900;
		struct Particle particle = { .x = random_x, .y = random_y, .vx = 0,
				.vy = 0 };
		particles[i] = particle;
	}
//	puts("make particles");

	for (i = 0; i < num_attractors; i++) {
		int random_x = rand() % 1440;
		int random_y = rand() % 900;
		float random_g;
		if (i >= num_attractors / 2) {
			random_g = (rand() % 1) + 1;
		} else {
			random_g = (rand() % 1) - 1.5;
		}
		struct Attractor attractor = { .x = random_x, .y = random_y, .g =
				random_g };
		attractors[i] = attractor;
	}
//	puts("make attractors");
}

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
	populateSimulation();

	while (1) {

		handleInput();
		handle_ethernet();

		updateSimulation(&particles[0], &attractors[0], num_particles,
				num_attractors);
		updateFrame(&particles[0], &attractors[0], num_particles,
				num_attractors);
		frame_timer();

		if (printFPS) {
			printf("FPS: %f\n", get_fps());
		}
	}

//	cleanup_platform();
	cleanup_ethernet_platform();
	freeMemory();
	return 0;
}
