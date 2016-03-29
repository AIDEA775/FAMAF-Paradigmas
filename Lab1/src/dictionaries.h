// Copyright 2015 Alejandro Nigrelli y Alejandro Silva

#ifndef LAB1_SRC_DICTIONARIES_H_
#define LAB1_SRC_DICTIONARIES_H_

#include <assert.h>
#include <stdbool.h>
#include <stdlib.h>

#include "../src/dictionary.h"

#define FOUND 0
#define NOT_FOUND 1
#define EXCEPTION 2

typedef struct _dics_node_t  *dics_t;

dics_t dics_create(bool reverse, char* name_dic, char* name_ign);

int dics_search(dics_t dics, char* word);

char* get_translation(dics_t dics);

void add_translation(dics_t dics, char* word, char* translation, bool save);

void add_exception(dics_t dics, char* word, bool save);

dics_t dics_destroy(dics_t dics);

#endif  // LAB1_SRC_DICTIONARIES_H_
