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

void populateSimulationFromNetworkArray(int newRam[60000], int newNumParticles, int newNumAttractors);

#endif /* SRC_MAIN_H_ */
