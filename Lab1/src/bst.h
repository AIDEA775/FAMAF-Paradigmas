// Copyright 2015 Alejandro Nigrelli y Alejandro Silva

#ifndef  LAB1_SRC_BST_H_
#define  LAB1_SRC_BST_H_

#include <assert.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

#include "../src/duo.h"

typedef struct _tree_node_t  *bst_t;

bst_t bst_empty(void);

bst_t bst_destroy(bst_t bst);

char* bst_search(bst_t bst, char* index);

bst_t bst_add(bst_t bst, char* index, char* data);

#endif  // LAB1_SRC_BST_H_
