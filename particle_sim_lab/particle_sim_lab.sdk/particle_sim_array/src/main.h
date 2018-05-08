/*
 * main.h
 *
 *  Created on: 7 May 2018
 *      Author: Matthew
 */

#ifndef SRC_MAIN_H_
#define SRC_MAIN_H_

void populateSimulationFromNetwork(int newNumParticles, int newNumAttractors,
		struct Particle *newParticles, struct Attractor *newAttractors);

void populateSimulationFromNetworkArray(float* newRam, int newNumParticles, int newNumAttractors);

#endif /* SRC_MAIN_H_ */
