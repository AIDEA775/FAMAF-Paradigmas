#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "duo.h"


struct _dic_node_t {
    duo_t duo;
    struct _dic_node_t *left;
    struct _dic_node_t *right;
};

typedef struct _dic_node_t  *dic_t;

dic_t dic_empty (void) {

    dic_t empty = NULL;
    return (empty);
}

dic_t dic_create (char* name_dic) {
    dic_t dic = dic_empty();
    FILE *archive;
    archive = fopen(name_dic,"r+a");
    duo_t duo;
    char *line;
    char *tokenindex;
    char *tokendata;

    if (archive == NULL) {
        fclose(archive);
        return NULL;
    }

    while(feof(archive) == 0) {
        line = readline(archive);
        tokenindex = strtok(line, ",");
        tokendata = strtok(NULL, "\n");
        if(tokendata != NULL && tokenindex != NULL)
            dic = add_duo(dic, tokenindex, tokendata);
    }
    fclose(archive);
    return dic;
}

char *readline(FILE * file) {
    bool done = false;
    char *result = NULL, *read_from = NULL;
    char *alloc_result = NULL, *fgets_result = NULL;
    unsigned int size = 128;
    size_t result_len = 0;

    while (!done) {
        /* need to use 2 pointers to avoid leaking resources from 'result' */
        alloc_result = realloc(result, size * sizeof(char));
        if (alloc_result == NULL) {
            /* realloc failed, yet we need to free the memory from 'result' */
            free(result);
            result = NULL;
            done = true;
        } else {
            /* point 'result' to the newly allocated memory */
            result = alloc_result;

            /* point 'read_from' to the unused memory space */
            read_from = result + result_len;

            /* read from 'file' up to 'size - result_len' */
            fgets_result = fgets(read_from, size - result_len, file);
            if (fgets_result == NULL) {
                free(result);
                result = NULL;
                done = true;
            } else {
                /* check if the user entered a newline */
                result_len = strlen(result);
                if (feof(file)) {
                    done = true;
                } else if (result[result_len - 1] == '\n') {
                    /* Remove trailing '\n' */
                    result[result_len - 1] = '\0';
                    done = true;
                }
            }
        }
        size = size * 2;
    }
    return (result);
}


char* search_index(dic_t dic, char* word) {
    char* data = NULL;

    if (dic != NULL) {
        if ((strcmp(get_index(dic->duo), word)) == 0) {
            data = get_data(dic->duo);
        } else if (strcmp(get_index(dic->duo), word) < 0) {
            data = search_index(dic->right, word);
        } else {
            data = search_index(dic->left, word);
        }
    }

    return (data);
}

dic_t add_duo(dic_t dic, char* index, char* data) {
    dic_t nuevo = NULL;

    if (dic == NULL) {
        nuevo = calloc(1, sizeof(struct _dic_node_t));
        nuevo->duo = create_duo(index, data);
        nuevo->left = NULL;
        nuevo->right = NULL;

        dic = nuevo;
    } else if (strcmp(index, get_index(dic->duo)) < 0) {
        dic->left = add_duo(dic->left, index, data);
    } else {
        dic->right = add_duo(dic->right, index, data);
    }

    return (dic);
}

int save_duo(char *name_dic, char *index, char *data) {
    FILE *file;
    if (name_dic == NULL) {
        return -1;
    } else {
        file = fopen(name_dic, "a");
        fprintf(file,"\n%s" ,index);
        fprintf(file, "," );
        fprintf(file,"%s" ,data);
        fclose(file);

        return 0;
    }
}


dic_t dic_destroy(dic_t dic) {

    if (dic != NULL) {
        dic->duo = destroy_duo(dic->duo);
        dic->left = dic_destroy(dic->left);
        dic->right = dic_destroy(dic->right);
        free(dic);
        dic = NULL;
    }

    return (dic);
}