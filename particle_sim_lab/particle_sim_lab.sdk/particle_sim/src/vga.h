/*
 * vga.h
 *
 *  Created on: 3 May 2018
 *      Author: ms1516
 */

#include "simulation.h"

#ifndef SRC_VGA_H_
#define SRC_VGA_H_

void setupVGA();

void updateFrame(struct Particle *particles, struct Attractor *attractors,
		int num_particles, int num_attractors);

#endif /* SRC_VGA_H_ */
