#include "toplevel.h"

//Input data storage
#define RAM_SIZE 60000

#define PARTICLE_END 52000 //must be > 48000 for 12k particles.
#define PARTICLE_SIZE 4
#define ATTRACTOR_END 54000 //particles end + 2000 for 500 attractors (g stored as two ints).
#define ATTRACTOR_SIZE 3
#define FLOAT_ACCURACY 1000.0 //used to store floats in int array

uint32 data[RAM_SIZE];

void toplevel(uint32 *ram, uint32 *numP, uint32 *numA) {
#pragma HLS INTERFACE m_axi port=ram offset=slave bundle=MAXI
#pragma HLS INTERFACE s_axilite port=numP bundle=AXILiteS register
#pragma HLS INTERFACE s_axilite port=numA bundle=AXILiteS register

	readloop: for (int i = 0; i < RAM_SIZE; i++) {
		data[i] = ram[i];
	}

	updateParticlePositions: for (int i = 0; i < (*numP) * PARTICLE_SIZE; i +=
			PARTICLE_SIZE) {
		int *px = &ram[i];
		int *py = &ram[i + 1];
		int *pvx = &ram[i + 2];
		int *pvy = &ram[i + 3];

		*px = *px + *pvx;
		*py = *py + *pvy;

		if (*px <= 5) {
			*px = 5;
			*pvx = 0;
		}
		if (*py <= 5) {
			*py = 5;
			*pvy = 0;
		}
		if (*px >= 1435) {
			*px = 1435;
			*pvx = 0;
		}
		if (*py >= 895) {
			*py = 895;
			*pvy = 0;
		}
	}
}
