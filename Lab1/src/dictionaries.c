#include <assert.h>
#include <stdbool.h>
#include <stdlib.h>

#include "dictionaries.h"

struct _dics_t {
    struct dic_t translation;
    struct dic_t exception;
    char* result;
};


dics_t dics_create(bool reverse, char* name_dic, char* name_ign) {
    dics_t dics = calloc(1, sizeof(struct _dics_t));

    dics->translation = dic_create(reverse, name_dic);
    if(dics->translation == NULL) {
        free(dics);
        return NULL;
    }

    dics->exception = dic_create(false, name_ign);
    if(dics->exception == NULL) {
        dic_destroy(dics->translation);
        free(dics);
        return NULL;
    }

    dics->result = NULL;
    return dics;
}

int dics_search(dics_t dics, char* word) {
    char* result;

    if((result = search_index(dics->exception)) != NULL) {
        return EXCEPTION;
    } else if((result = search_index(dics->translation)) != NULL) {
        dics->result = result;
        return FOUND;
    } else {
        return NOT_FOUND;
    }
}

char* get_translation(dics_t dics) {
    char* translated;

    assert(dics->result != NULL);

    translated = dics->result;
    dics->result = NULL;

    return translated;
}

void add_translation(dics_t dics, char* word, char* translation, bool save) {
    dics->translation = add_duo(dics->translation, word, translation);
    if(save)
        save_duo(dics->translation, word, translation);
}

void add_exception(dics_t dics, char* word, bool save) {
    dics->exception = add_duo(dics->exception, word, word);
    if(save)
        save_duo(dics->exception, word, word);
}

dics_t dics_destroy(dics_t dics) {
    dics->translation = dic_destroy(dics->translation);
    dics->exception = dic_destroy(dics->exception);
    dics->result = NULL;
    return NULL;
}