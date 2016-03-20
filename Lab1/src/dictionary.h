#ifndef _DICTIONARY_H
#define _DICTIONARY_H

#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

typedef struct _dic_node_t  *dic_t;

dic_t dic_empty (void);

dic_t dic_create (bool reverse, char* name_dic);

char* search_index(dic_t dic, char* word);

dic_t add_duo(dic_t dic, char* index, char* data);

int save_duo(char* name_dic, char* index, char* data);

dic_t dic_destroy(dic_t dic);

#endif