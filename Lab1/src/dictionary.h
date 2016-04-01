// Copyright 2015 Alejandro Nigrelli y Alejandro Silva

#ifndef LAB1_SRC_DICTIONARY_H_
#define LAB1_SRC_DICTIONARY_H_

#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

#include "./bst.h"

typedef struct _dic_node_t  *dic_t;

dic_t dic_create(bool reverse, char* name_dic);

char* search_index(dic_t dic, char* word);

dic_t add_duo(dic_t dic, char* index, char* data);

void save_duo(dic_t dic, char* index, char* data);

dic_t dic_destroy(dic_t dic);

#endif  // LAB1_SRC_DICTIONARY_H_
