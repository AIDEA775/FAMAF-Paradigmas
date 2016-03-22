#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "duo.h"
#include "bst.h"
#include "dictionary.h"


struct _dic_node_t {
    char* name_file;
	struct _tree_node_t *bst;
};


dic_t dic_create (bool reverse, char* name_dic) {
    dic_t dic = calloc(1, sizeof(struct _dic_node_t));
    dic->bst = bst_empty();
    dic->name_file = calloc(strlen(name_dic)+1, sizeof(char));
    strcpy(dic->name_file, name_dic);
    FILE *archive;
    archive = fopen(name_dic,"r+a");
    char *line;
    char *token_1;
    char *token_2;

    if (archive == NULL)
        return NULL;

    while(feof(archive) == 0) {
        line = readline(archive);
        token_1 = strtok(line, ",");
        token_2 = strtok(NULL, "\n");
        if(token_1 != NULL && token_2 != NULL) {
            if(reverse)
                dic->bst = bst_add(dic->bst, token_2, token_1);
            else
                dic->bst = bst_add(dic->bst, token_1, token_2);
        }
        free(line);
    }
    fclose(archive);
    return dic;
}

char *readline(FILE *file) {
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
    return result;
}


int save_duo(dic_t dic, char *index, char *data) {
    FILE *file;
    if (dic->name_file == NULL) {
        return -1;
    }
    file = fopen(dic->name_file, "a");
    fprintf(file,"\n%s" ,index);
    fprintf(file, "," );
    fprintf(file,"%s" ,data);
    fclose(file);
    return 0;
}

char* search_index(dic_t dic, char* word) {
    char *result;
    result = bst_search(dic->bst, word);

    return result;
}


dic_t dic_destroy(dic_t dic) {
    dic->bst = bst_destroy(dic->bst);
    free(dic->name_file);
    free(dic);
    dic = NULL;
    return dic;
}

dic_t add_duo(dic_t dic, char *word, char *translation) {
    dic->bst = bst_add(dic->bst, word, translation);
    return dic;
}