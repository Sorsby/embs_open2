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

#define PART_LENGTH_POSITION 4
#define PART_DATA_POSITION 5
#define PART_DATA_LENGTH_MAX 1100
#define PART_DATA_OBJECT_LENGTH 22

int dataLength;

int strToInt(char* str) {
	return (int) strtol(str, (char **) NULL, 10);
}

void splitData(char* data) {

	char *token, *str, *tofree;
	tofree = str = strdup(data);
	int i = 1;
	while ((token = strsep(&str, ","))) {
		if (i == PART_LENGTH_POSITION) {
			dataLength = strToInt(token);
		}
		i++;
	}
	free(tofree);
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

int split(char * str, char delim, char ***array, int *length) {
	char *p;
	char **res;
	int count = 0;
	int k = 0;

	p = str;
	// Count occurance of delim in string
	while ((p = strchr(p, delim)) != NULL) {
		*p = 0; // Null terminate the deliminator.
		p++; // Skip past our new null
		count++;
	}

	// allocate dynamic array
	res = calloc(1, count * sizeof(char *));
	if (!res)
		return -1;

	p = str;
	for (k = 0; k < count; k++) {
		if (*p)
			res[k] = p;  // Copy start of string
		p = strchr(p, 0);    // Look for next null
		p++; // Start of next string
	}

	*array = res;
	*length = count;

	return 0;
}

void remove_all_chars(char* str, char c) {
	char *pr = str, *pw = str;
	while (*pr) {
		*pw = *pr++;
		pw += (*pw != c) - 1;
		*pw = ',';
	}
	*pw = '\0';
}

char* replaceString(const char *s, const char *oldW, const char *newW)
{
    char *result;
    int i, cnt = 0;
    int newWlen = strlen(newW);
    int oldWlen = strlen(oldW);

    // Counting the number of times old word
    // occur in the string
    for (i = 0; s[i] != '\0'; i++)
    {
        if (strstr(&s[i], oldW) == &s[i])
        {
            cnt++;

            // Jumping to index after the old word.
            i += oldWlen - 1;
        }
    }

    // Making new string of enough length
    result = (char *)malloc(i + cnt * (newWlen - oldWlen) + 1);

    i = 0;
    while (*s)
    {
        // compare the substring with the result
        if (strstr(s, oldW) == s)
        {
            strcpy(&result[i], newW);
            i += newWlen;
            s += oldWlen;
        }
        else
            result[i++] = *s++;
    }

    result[i] = '\0';
    return result;
}
