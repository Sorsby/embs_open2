/*
 * util.h
 *
 *  Created on: 4 May 2018
 *      Author: Matthew
 */

#ifndef SRC_UTIL_UTIL_H_
#define SRC_UTIL_UTIL_H_

int strToInt(char* response);
char* getNumParts(char* response);
int getNextPart(char* response);
char* getRequestType(char* response);
void splitData(char* data);
int split(char * str, char delim, char ***array, int *length);
void remove_all_chars(char* str, char c);
char* replaceString(const char *s, const char *oldW, const char *newW);

#endif /* SRC_UTIL_UTIL_H_ */
