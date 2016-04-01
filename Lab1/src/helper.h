// Copyright 2015 Alejandro Nigrelli y Alejandro Silva

#ifndef LAB1_SRC_HELPER_H_
#define LAB1_SRC_HELPER_H_

#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

/*
 * Read the user input from specified FILE * until a newline is detected,
 * and return the corresponding (dinamically allocated) string.
 */
char *readline(FILE *file);

#endif  // LAB1_SRC_HELPER_H_
