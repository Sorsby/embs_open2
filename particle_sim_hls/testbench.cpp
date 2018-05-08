#include "toplevel.h"

uint32 ram[1000];
uint32 testRam[1000];

int main() {

    //Set up the slave inputs to the hardware
    uint32 arg1 = 100;
    uint32 arg2 = 10;

	for (int i = 0; i < arg1 * PARTICLE_SIZE; i += PARTICLE_SIZE) {
		int random_x = rand() % 1440 + 1;
		int random_y = rand() % 900 + 1;

		ram[i] = random_x;
		ram[i + 1] = random_y;
		ram[i + 2] = 1;
		ram[i + 3] = 1;

		testRam[i] = random_x;
		testRam[i + 1] = random_y;
		testRam[i + 2] = 1;
		testRam[i + 3] = 1;
	}

    //Run the hardware
    toplevel(ram, &arg1, &arg2);

    printf("ram x: %d, testRam x: %d\n", ram[0], testRam[0]);
    printf("ram y: %d, testRam y: %d\n", ram[1], testRam[1]);

	for (int i = 0; i < arg1 * PARTICLE_SIZE; i += PARTICLE_SIZE) {
		if (testRam[i] == ram[i] + 1 && testRam[i + 1] == ram[i + 1] + 1) {
			continue;
		} else {
			return 1;
		}
	}
	return 0;
}
