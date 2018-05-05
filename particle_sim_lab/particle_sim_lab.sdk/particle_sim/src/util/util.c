/*
 * util.c
 *
 *  Created on: 4 May 2018
 *      Author: Matthew
 */
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define NUMPARTS_LENGTH 14
#define NUMPARTS_POSITION 3
#define NETWORK_NUMBER_STR_SIZE 5
#define GETPART_LENGTH 19

char* getRequestType(char* response) {
	char *token, *str, *tofree;
	tofree = str = strdup(response);
	token = strsep(&str, ",");
	free(tofree);
	return token;
}

int strToInt(char* str) {
	return (int) strtol(str, (char **) NULL, 10);
}

char* getNumParts(char *response) {
	char *token, *tofree, *str;
	int pos;
	tofree = str = strdup(response);
	for (pos = 0; pos < NUMPARTS_POSITION; pos++) {
		token = strsep(&str, ",");
	}
	free(tofree);
	return token;
}
