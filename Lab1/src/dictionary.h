// Copyright 2015 Alejandro Nigrelli y Alejandro Silva

#ifndef LAB1_SRC_DICTIONARY_H_
#define LAB1_SRC_DICTIONARY_H_

#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

#include "./bst.h"

typedef struct _dic_node_t  *dic_t;

/*
 * Return a dict instance populated by the data in the given filename
 * If reverse = true, the translations are loaded in the opposite direction
 * The caller must call dic_destroy when done using the resulting dict
 */
dic_t dic_create(bool reverse, char* name_dic);

/*
 * Return the translation associated with word
 */
char* search_index(dic_t dic, char* word);

/*
 * Return the given dic with the given word and data added
 */
dic_t add_duo(dic_t dic, char* index, char* data);

/*
 * Save index and data in file associated with dic
 */
void save_duo(dic_t dic, char* index, char* data);

/*
 * Free the resources allocated for the given dict and return NULL
 */
dic_t dic_destroy(dic_t dic);

#endif  // LAB1_SRC_DICTIONARY_H_
