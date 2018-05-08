/*
 * util.h
 *
 *  Created on: 4 May 2018
 *      Author: Matthew
 */

#ifndef SRC_UTIL_UTIL_H_
#define SRC_UTIL_UTIL_H_

float myRandom(float min, float max);
int strToInt(char* response);
char* getNumParts(char* response);
int getNextPart(char* response);
char* getRequestType(char* response);

#endif /* SRC_UTIL_UTIL_H_ */
