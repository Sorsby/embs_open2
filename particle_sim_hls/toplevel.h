#ifndef __TOPLEVEL_H_
#define __TOPLEVEL_H_

#include <stdio.h>
#include <stdlib.h>
#include <ap_int.h>

#define RAM_SIZE 48324
#define PARTICLE_ARRAY_SIZE 20000
#define ATTRACTOR_ARRAY_SIZE 500

#define PARTICLE_END 48000 //must be > 48000 for 12k particles.
#define PARTICLE_SIZE 4
#define ATTRACTOR_END 48324 //particles end + 2000 for 500 attractors (g stored as two ints).
#define ATTRACTOR_SIZE 3
#define FLOAT_ACCURACY 1000.0 //used to store floats in int array

//Typedefs
typedef unsigned int uint32;
typedef int int32;

void toplevel(uint32 *ram, uint32 *numP, uint32 *numA);

#endif
