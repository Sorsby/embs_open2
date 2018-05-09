#include <string.h>
#include <xil_cache.h>
#include <xil_types.h>
#include <xparameters.h>

#include "../def.h"
#include "../zybo_vga/display_ctrl.h"
#include "../zybo_vga/vga_modes.h"

#define RED 0x00FF0000
#define GREEN 0x000000FF
#define BLUE 0x0000FF00

// Frame size (based on 1440x900 resolution, 32 bits per pixel)
#define MAX_FRAME (1440*900)
#define FRAME_STRIDE (1440*4)

DisplayCtrl dispCtrl; // Display driver struct
u32 frameBuf[DISPLAY_NUM_FRAMES][MAX_FRAME]; // Frame buffers for video data
void *pFrames[DISPLAY_NUM_FRAMES]; // Array of pointers to the frame buffers

int x, y, i, count;
u32 stride;
u32 width;
u32 height;

u32 *frame;
u32 buff;

// stores relative positions around pixel required to draw a circle
int circle[21] = { -2881, -2880, -2879, -1442, -1441, -1440, -1439, -1438, -2,
		-1, 0, 1, 2, 1438, 1439, 1440, 1441, 1442, 2879, 2880, 2881 };

void drawCircle(int startx, int starty, int colour) {
	for (x = 0; x < 21; x++) {
		int circlePixel = circle[x] + (starty * stride + startx);
		if (circlePixel <= 0 || circlePixel >= MAX_FRAME) {
			continue;
		}
		frame[circlePixel] = colour;
	}
}

void setupVGA() {
	// Initialise an array of pointers to the 2 frame buffers
	int i;
	for (i = 0; i < DISPLAY_NUM_FRAMES; i++)
		pFrames[i] = frameBuf[i];

	// Initialise the display controller
	DisplayInitialize(&dispCtrl, XPAR_AXIVDMA_0_DEVICE_ID, XPAR_VTC_0_DEVICE_ID,
	XPAR_VGA_AXI_DYNCLK_0_BASEADDR, pFrames, FRAME_STRIDE);

	// Start with the first frame buffer (of two)
	DisplayChangeFrame(&dispCtrl, 0);

	// Set the display resolution
	DisplaySetMode(&dispCtrl, &VMODE_1440x900);

	// Enable video output
	DisplayStart(&dispCtrl);

	stride = dispCtrl.stride / 4;
	width = dispCtrl.vMode.width;
	height = dispCtrl.vMode.height;

	buff = dispCtrl.curFrame;
}

void updateFrameFromArray(float* ram, int num_particles, int num_attractors) {
	// Switch the frame we're modifying to be back buffer (1 to 0, or 0 to 1)
	buff = !buff;
	frame = dispCtrl.framePtr[buff];

	// Clear the frame to white
	memset(frame, 0xFF, MAX_FRAME * 4);

	for (i = 0; i < num_particles * PARTICLE_SIZE; i += PARTICLE_SIZE) {
		drawCircle(ram[i], ram[i + 1], BLUE);
	}
	for (i = PARTICLE_END; i < PARTICLE_END + (num_attractors * ATTRACTOR_SIZE); i += ATTRACTOR_SIZE) {
		int colour = ram[i + 3] > 0.0 ? GREEN : RED;
		drawCircle(ram[i + 1], ram[i + 2], colour);
	}

	// Flush everything out to DDR
	Xil_DCacheFlush();

	// Switch active frame to the back buffer
	DisplayChangeFrame(&dispCtrl, buff);

	// Wait for the f0x00FF0000rame to switch (after active frame is drawn) before continuing
	DisplayWaitForSync(&dispCtrl);
}

//void updateFrame(struct Particle *particles, struct Attractor *attractors,
//		int num_particles, int num_attractors) {
//	// Switch the frame we're modifying to be back buffer (1 to 0, or 0 to 1)
//	buff = !buff;
//	frame = dispCtrl.framePtr[buff];
//
//	// Clear the frame to white
//	memset(frame, 0xFF, MAX_FRAME * 4);
//
//	int i;
//	for (i = 0; i < num_particles; i++) {
//		drawCircle(particles[i].x, particles[i].y, BLUE);
//	}
//	for (i = 0; i < num_attractors; i++) {
//		int colour = attractors[i].g > 0 ? GREEN : RED;
//		drawCircle(attractors[i].x, attractors[i].y, colour);
//	}
//
//	// Flush everything out to DDR
//	Xil_DCacheFlush();
//
//	// Switch active frame to the back buffer
//	DisplayChangeFrame(&dispCtrl, buff);
//
//	// Wait for the f0x00FF0000rame to switch (after active frame is drawn) before continuing
//	DisplayWaitForSync(&dispCtrl);
//}

void drawSquare(int startx, int starty, int size, int colour) {
	for (x = startx; x < startx + size; x++) {
		for (y = starty; y < starty + size; y++) {
			frame[y * stride + x] = colour;
		}
	}
}
