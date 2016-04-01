// Copyright 2015 Alejandro Nigrelli y Alejandro Silva

#ifndef  LAB1_SRC_BST_H_
#define  LAB1_SRC_BST_H_

#include <assert.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

#include "./duo.h"

typedef struct _tree_node_t  *bst_t;

/*
 * Returns a newly created, empty binary search tree (BST)
 */
bst_t bst_empty(void);

/*
 * Returns the given bst with the pair index and data added to it
 */
bst_t bst_add(bst_t bst, char* index, char* data);

/*
 * Returns the data associated to the given index in the given bst,
 * or NULL if the index is not in bst
 */
char* bst_search(bst_t bst, char* index);

/*
 * Free the resources allocated for the given bst, and return NULL
 */
bst_t bst_destroy(bst_t bst);

#endif  // LAB1_SRC_BST_H_
