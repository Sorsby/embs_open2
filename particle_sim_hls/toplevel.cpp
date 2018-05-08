#include "toplevel.h"

uint32 data[RAM_SIZE];
uint32 numberParticles;
uint32 numberAttractors;

void updateParticlePositions();

void toplevel(uint32 *ram, uint32 *numP, uint32 *numA) {
#pragma HLS INTERFACE m_axi port=ram offset=slave bundle=MAXI
#pragma HLS INTERFACE s_axilite port=numP bundle=AXILiteS register
#pragma HLS INTERFACE s_axilite port=numA bundle=AXILiteS register
#pragma HLS INTERFACE s_axilite port=return bundle=AXILiteS register

	readloop: for (int i = 0; i < RAM_SIZE; i++) {
		data[i] = ram[i];
	}

	numberParticles = *numP;
	numberAttractors = *numA;

	updateParticlePositions();

	return ram;
}

void updateParticlePositions() {
	updatePosLoop: for (int i = 0; i < (numberParticles) * PARTICLE_SIZE; i +=
			PARTICLE_SIZE) {
		uint32 *px = &data[i];
		uint32 *py = &data[i + 1];
		uint32 *pvx = &data[i + 2];
		uint32 *pvy = &data[i + 3];

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
