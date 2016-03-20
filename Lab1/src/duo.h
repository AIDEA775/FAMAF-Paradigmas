#ifndef _DUO_H
#define _DUO_H

#include <assert.h>
#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

typedef struct _duo_t  *duo_t;

duo_t create_duo(char* index, char* data);

char* get_data(duo_t duo);

char* get_index(duo_t duo);

duo_t destroy_duo(duo_t duo);

#endif