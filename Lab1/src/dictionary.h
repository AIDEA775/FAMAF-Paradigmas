#include <assert.h>
#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

typedef struct _dic_node_t  *dic_t;

dic_t dic_empty (void);

dic_t dic_destroy(dic_t dic);

char* search_index(dic_t dic, char* word);

dic_t add_duo(dic_t dic, char* index, char* data);

int save_duo(char* index, char* data, char* namedic);

dic_t dic_create (char* namedic);