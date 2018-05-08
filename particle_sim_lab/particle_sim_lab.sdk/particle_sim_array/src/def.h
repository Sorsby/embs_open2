/*
 * def.h
 *
 *  Created on: 8 May 2018
 *      Author: Matthew
 */

#ifndef SRC_DEF_H_
#define SRC_DEF_H_

#define RAM_SIZE 50000
#define PARTICLE_ARRAY_SIZE 20000
#define ATTRACTOR_ARRAY_SIZE 500

#define PARTICLE_END 48000 //must be > 48000 for 12k particles.
#define PARTICLE_SIZE 4
#define ATTRACTOR_END 49000 //particles end + 2000 for 500 attractors (g stored as two ints).
#define ATTRACTOR_SIZE 3
#define FLOAT_ACCURACY 1000.0 //used to store floats in int array

#endif /* SRC_DEF_H_ */
