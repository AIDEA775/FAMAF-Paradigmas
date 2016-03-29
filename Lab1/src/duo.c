#include "duo.h"

struct _duo_t {
	char *index;
	char *data;
};

duo_t create_duo(char *index, char *data)  {
    duo_t duo;
    duo = calloc(1, sizeof(struct _duo_t));
    duo->index = calloc(strlen(index) + 1, sizeof(char));
    duo->data = calloc(strlen(data) + 1, sizeof(char));
    strcpy(duo->index, index);
    strcpy(duo->data, data);

    return(duo);
}

char* get_data(duo_t duo) {
    return(duo->data);
}

char* get_index(duo_t duo) {
    return(duo->index);
}

duo_t destroy_duo(duo_t duo) {
    free(duo->index);
    duo->index = NULL;
    free(duo->data);
    duo->data = NULL;
    free(duo);
    duo = NULL;

    return(duo);
}
