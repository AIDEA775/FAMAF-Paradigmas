// Copyright 2015 Alejandro Nigrelli y Alejandro Silva

#ifndef LAB1_SRC_DUO_H_
#define LAB1_SRC_DUO_H_

#include <assert.h>
#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

typedef struct _duo_t  *duo_t;

/*
 * Build a new pair from the given index and data.
 * Can free index and data after creating the dou
 */
duo_t create_duo(char* index, char* data);

/*
 * Return data
 */
char* get_data(duo_t duo);

/*
 * Return index
 */
char* get_index(duo_t duo);

/*
 * Free the memory allocated by the given duo, as well as the respective
 * index and data
 * Return NULL
 */
duo_t destroy_duo(duo_t duo);

#endif  // LAB1_SRC_DUO_H_
