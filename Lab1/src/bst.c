#include "bst.h"
#include "duo.h"


struct _tree_node_t {
    duo_t duo;
    struct _tree_node_t *left;
    struct _tree_node_t *right;
};

bst_t bst_empty(void) {

    bst_t empty = NULL;

    return (empty);
}

bst_t bst_destroy(bst_t bst) {

    if (bst != NULL) {
        bst->duo = destroy_duo(bst->duo);
        bst->left = bst_destroy(bst->left);
        bst->right = bst_destroy(bst->right);
        free(bst);
        bst = NULL;
    }

    return (bst);
}


char* bst_search(bst_t bst, char* word) {
    char* data = NULL;

    if (bst != NULL) {
        if ((strcmp(get_index(bst->duo), word)) == 0) {
            data = get_data(bst->duo);
        } else if (strcmp(get_index(bst->duo), word) < 0) {
            data = bst_search(bst->right, word);
        } else {
            data = bst_search(bst->left, word);
        }
    }

    return data;

}

bst_t bst_add(bst_t bst, char* index, char* data) {
   bst_t new = NULL;

    if (bst == NULL) {
        new = calloc(1, sizeof(struct _tree_node_t));
        new->duo = create_duo(index, data);
        new->left = NULL;
        new->right = NULL;

        bst = new;
    } else if (strcmp(index, get_index(bst->duo)) < 0) {
        bst->left = bst_add(bst->left, index, data);
    } else {
        bst->right = bst_add(bst->right, index, data);
    }

    return bst;
}
