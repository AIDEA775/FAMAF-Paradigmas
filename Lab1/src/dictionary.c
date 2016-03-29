#include "duo.h"
#include "bst.h"
#include "dictionary.h"
#include "helper.h"

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

char* search_index(dic_t dic, char* word) {
    char *result;
    result = bst_search(dic->bst, word);

    return result;
}

dic_t add_duo(dic_t dic, char *word, char *translation) {
    dic->bst = bst_add(dic->bst, word, translation);
    return dic;
}

void save_duo(dic_t dic, char *index, char *data) {
    FILE *file;

    assert(dic->name_file != NULL);

    file = fopen(dic->name_file, "a");
    fprintf(file,"%s" ,index);
    fprintf(file, "," );
    fprintf(file,"%s\n" ,data);
    fclose(file);
}

dic_t dic_destroy(dic_t dic) {
    dic->bst = bst_destroy(dic->bst);
    free(dic->name_file);
    free(dic);
    dic = NULL;
    return dic;
}
