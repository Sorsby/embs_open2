/*
 * simulation.h
 *
 *  Created on: 3 May 2018
 *      Author: Matthew
 */

#ifndef SRC_SIMULATION_H_
#define SRC_SIMULATION_H_

struct Particle {
	float x;
	float y;
	float vx;
	float vy;
};

struct Attractor {
	float x;
	float y;
	float g;
};

void updateSimulation(struct Particle *particles, struct Attractor *attractors,
		int num_particles, int num_attractors);

#endif /* SRC_SIMULATION_H_ */
