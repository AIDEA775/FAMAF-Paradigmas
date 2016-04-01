// Copyright 2015 Alejandro Nigrelli y Alejandro Silva

#ifndef LAB1_SRC_DICTIONARIES_H_
#define LAB1_SRC_DICTIONARIES_H_

#include <assert.h>
#include <stdbool.h>
#include <stdlib.h>

#include "./dictionary.h"

#define FOUND 0
#define NOT_FOUND 1
#define EXCEPTION 2

typedef struct _dics_node_t  *dics_t;

/*
 * Return a dics created with traduction and ignored dictionaries
 */
dics_t dics_create(bool reverse, char* name_dic, char* name_ign);

/*
 * Return EXCEPTION if word is in ignored dictionary
 * Return FOUND if word is in traduction dictionary
 * Return NOT_FOUND if word is not find in the dictionaries
 */
int dics_search(dics_t dics, char* word);

/*
 * Return the last translation found in dics
 * Call only after reciving FOUND by dics_search
 */
char* get_translation(dics_t dics);

/*
 * Add word and translation in the translation dictionary
 * If save = true, save it in translation file dictionary
 */
void add_translation(dics_t dics, char* word, char* translation, bool save);

/*
 * Add word and translation in the ignored dictionary
 * If save = true, save it in ignored file dictionary
 */
void add_exception(dics_t dics, char* word, bool save);

/*
 * Free the resources allocated for the given dics and their dictionaries
 * Return NULL
 */
dics_t dics_destroy(dics_t dics);

#endif  // LAB1_SRC_DICTIONARIES_H_
