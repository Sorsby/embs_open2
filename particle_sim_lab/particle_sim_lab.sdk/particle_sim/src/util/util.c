/*
 * util.c
 *
 *  Created on: 4 May 2018
 *      Author: Matthew
 */
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define NUMPARTS_POSITION 3

int responseStringToInt(char* response) {
	return (int) strtol(response, (char **)NULL, 10);
}

char* getNumParts(char *response) {
	char *token;
	int pos;
	for (pos = 0; pos < NUMPARTS_POSITION; pos++) {
		token = strsep(&response, ",");
	}
	return token;
}
