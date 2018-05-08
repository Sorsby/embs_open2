/*
 * simulation.c
 *
 *  Created on: 3 May 2018
 *      Author: Matthew
 */
#include "simulation.h"

#include "stdio.h"
#include "math.h"
#include "../def.h"

#define ABS(X)  ((X>=0)? X : -(x) )
#define ROUND(X)  (X>=0)? (int) (X + 0.5) : (int)-(ABS(X) +0.5)

int i, j;

void updateSimulationArray(int* ram, int num_particles,
		int num_attractors) {
	puts("simulating...");
	for (i = 0; i < num_particles * PARTICLE_SIZE; i += PARTICLE_SIZE) {
		int *px = &ram[i];
		int *py = &ram[i + 1];
		int *pvx = &ram[i + 2];
		int *pvy = &ram[i + 3];

		*px = *px + *pvx;
		*py = *py + *pvy;

		printf("pos x: %d, y: %d\n", *px, *py);

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

		for (j = 0; j < num_attractors * ATTRACTOR_SIZE; j += ATTRACTOR_SIZE) {
			int *ax = &ram[PARTICLE_END + j + 1];
			int *ay = &ram[PARTICLE_END + j + 2];
			int *g = &ram[PARTICLE_END + j + 3];

			float exp1 = (*ax - *px);
			float exp2 = (*ax - *py);
			float exp = exp1 * exp1 + exp2 * exp2;
			float d = sqrt(exp);

			float x_norm;
			float y_norm;
			if (d < 500) {
				x_norm = (*ax - *ax) / d;
				y_norm = (*ay - *ay) / d;

				if (d < 1.0) {
					x_norm = x_norm * (*g) / FLOAT_ACCURACY;
					y_norm = y_norm * (*g) / FLOAT_ACCURACY;
				} else {
					x_norm = x_norm * (1 / d) * ((*g) / FLOAT_ACCURACY);
					y_norm = y_norm * (1 / d) * ((*g) / FLOAT_ACCURACY);
				}

				*pvx = *pvx + round(x_norm);
				*pvy = *pvy + round(y_norm);
				printf("velocity x: %d, y: %d\n", *pvx, *pvy);
			}
		}
	}
}

//void updateSimulation(struct Particle *particles, struct Attractor *attractors,
//		int num_particles, int num_attractors) {
//
//	for (i = 0; i < num_particles; i++) {
//		struct Particle *p = &particles[i];
//
//		p->x = p->x + p->vx;
//		p->y = p->y + p->vy;
//
//		if (p->x <= 5) {
//			p->x = 5;
//			p->vx = 0;
//		}
//
//		if (p->y <= 5) {
//			p->y = 5;
//			p->vy = 0;
//		}
//
//		if (p->x >= 1435) {
//			p->x = 1435;
//			p->vx = 0;
//		}
//
//		if (p->y >= 895) {
//			p->y = 895;
//			p->vy = 0;
//		}
//
//		for (j = 0; j < num_attractors; j++) {
//			struct Attractor a = attractors[j];
//
//			float exp1 = (a.x - p->x);
//			float exp2 = (a.y - p->y);
//			float exp = exp1 * exp1 + exp2 * exp2;
//			float d = sqrt(exp);
//
//			float x_norm;
//			float y_norm;
//			if (d < 500) {
//				x_norm = (a.x - p->x) / d;
//				y_norm = (a.y - p->y) / d;
//
//				if (d < 1.0) {
//					x_norm = x_norm * a.g;
//					y_norm = y_norm * a.g;
//				} else {
//					x_norm = x_norm * (1 / d) * a.g;
//					y_norm = y_norm * (1 / d) * a.g;
//				}
//
//				particles[i].vx = particles[i].vx + x_norm;
//				particles[i].vy = particles[i].vy + y_norm;
//
//			}
//		}
//	}
//}
