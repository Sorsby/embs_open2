#include "toplevel.h"

//float data[RAM_SIZE/2];
uint32 numberParticles;
uint32 numberAttractors;

float Q_rsqrt( float number );

void toplevel(float *ram, uint32 *numP, uint32 *numA) {
#pragma HLS INTERFACE m_axi port=ram offset=slave bundle=MAXI
#pragma HLS INTERFACE s_axilite port=numP bundle=AXILiteS register
#pragma HLS INTERFACE s_axilite port=numA bundle=AXILiteS register
#pragma HLS INTERFACE s_axilite port=return bundle=AXILiteS register

//	readloop: for (uint32 i = 0; i < RAM_SIZE; i++) {
//		data[i] = ram[i];
//	}

	numberParticles = *numP;
	numberAttractors = *numA;

	int loopend = numberParticles * PARTICLE_SIZE;
	updateParticleLoop: for (uint32 i = 0; i < loopend; i +=PARTICLE_SIZE) {
#pragma HLS LOOP_TRIPCOUNT min=0 max=12000 avg=12000

		float* px = &ram[i];
		float* py = &ram[i + 1];
		float* pvx = &ram[i + 2];
		float* pvy = &ram[i + 3];

		*px += *pvx;
		*py += *pvy;

		if (*px <= 0) {
			*px = 0;
			*pvx = 0;
		}
		if (*py <= 0) {
			*py = 0;
			*pvy = 0;
		}
		if (*px >= 1440) {
			*px = 1440;
			*pvx = 0;
		}
		if (*py >= 900) {
			*py = 900;
			*pvy = 0;
		}

		int loopend = PARTICLE_END + (numberAttractors * ATTRACTOR_SIZE);
		calculateVelocityLoop: for (int j = PARTICLE_END;
				j < loopend; j +=
				ATTRACTOR_SIZE) {
#pragma HLS LOOP_TRIPCOUNT min=0 max=104 avg=104

			float ax = ram[j + 1];
			float ay = ram[j + 2];
			float g = ram[j + 3];

			float exp1 = (ax - *px);
			float exp2 = (ay - *py);
			float exp = exp1 * exp1 + exp2 * exp2;
//			float inv_sqrt = Q_rsqrt(exp);
//			float d = 1/inv_sqrt;
			float d = sqrt(exp);

			float x_norm;
			float y_norm;
			if (d < 500) {
				x_norm = (ax - *px) / d;
				y_norm = (ay - *py) / d;

				if (d < 1.0) {
					x_norm = x_norm * g;
					y_norm = y_norm * g;
				} else {
					x_norm = x_norm * (1 / d) * g;
					y_norm = y_norm * (1 / d) * g;
				}

				*pvx += x_norm;
				*pvy += y_norm;
			}
		}
	}
}

//float Q_rsqrt( float number )
//{
//#pragma HLS INLINE
//	long i;
//	float x2, y;
//	const float threehalfs = 1.5F;
//
//	x2 = number * 0.5F;
//	y  = number;
//	i  = * ( long * ) &y;                       // evil floating point bit level hacking
//	i  = 0x5f3759df - ( i >> 1 );               // what the fuck?
//	y  = * ( float * ) &i;
//	y  = y * ( threehalfs - ( x2 * y * y ) );   // 1st iteration
////	y  = y * ( threehalfs - ( x2 * y * y ) );   // 2nd iteration, this can be removed
//
//	return y;
//}
