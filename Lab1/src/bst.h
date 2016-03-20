#ifndef _BST_H
#define _BST_H

#include <assert.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

#include "bst.h"
#include "duo.h"

typedef struct _tree_node_t  *bst_t;

bst_t bst_empty(void);

bst_t bst_destroy(bst_t bst);

char* bst_search(bst_t bst, char* index);

bst_t bst_add(bst_t bst, char* index, char* data);

#endif