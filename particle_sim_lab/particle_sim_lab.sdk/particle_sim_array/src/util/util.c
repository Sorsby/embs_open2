/*
 * util.c
 *
 *  Created on: 4 May 2018
 *      Author: Matthew
 */
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define NUMPARTS_AND_PART_ID_POSITION 3

// Returns uniformly distributed random numbers from [0.0, 1.0].
float uniform0to1Random() {
    float r = rand();
    return r / ((float)RAND_MAX + 1);
}

// Returns uniformly distributed random numbers from [-10.0, 10.0].
float myRandom(float min, float max) {
  return (max - min) * uniform0to1Random() - max;
}

int strToInt(char* str) {
	return (int) strtol(str, (char **) NULL, 10);
}

char* getRequestType(char* response) {
	char *token, *str, *tofree;
	tofree = str = strdup(response);
	token = strsep(&str, ",");
	free(tofree);
	return token;
}

char* getNumParts(char* response) {
	char *token, *tofree, *str;
	int pos;
	tofree = str = strdup(response);
	for (pos = 0; pos < NUMPARTS_AND_PART_ID_POSITION; pos++) {
		token = strsep(&str, ",");
	}
	free(tofree);
	return token;
}

int getNextPart(char* response) {
	char *token, *tofree, *str;
	int pos;
	tofree = str = strdup(response);
	for (pos = 0; pos < NUMPARTS_AND_PART_ID_POSITION; pos++) {
		token = strsep(&str, ",");
	}
	int nextPart = strToInt(token) + 1;
	free(tofree);
	return nextPart;
}
