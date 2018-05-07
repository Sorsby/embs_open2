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
