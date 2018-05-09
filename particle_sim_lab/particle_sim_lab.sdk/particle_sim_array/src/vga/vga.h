#include "../simulation/simulation.h"

#ifndef SRC_VGA_H_
#define SRC_VGA_H_

void setupVGA();

//void updateFrame(struct Particle *particles, struct Attractor *attractors,
//		int num_particles, int num_attractors);
void updateFrameFromArray(float* ram, int num_particles, int num_attractors);

#endif /* SRC_VGA_H_ */
