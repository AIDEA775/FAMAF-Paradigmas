#ifndef _DICTIONARIES_H
#define _DICTIONARIES_H

#include "dictionary.h"

#define FOUND 0
#define NOT_FOUND 1
#define EXCEPTION 2

typedef _dics_t *dics_t


dics_t dics_create(bool reverse, char* name_dic, char* name_ign);

int dics_search(dics_t dics, char* word);

char* get_translation(dics_t dics);

void add_translation(dics_t dics, char* word, char* translation);

void add_exception(dics_t dics, char* word);

dics_t dics_destroy(dics_t dics);

#endif
