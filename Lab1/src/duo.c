#include <assert.h>
#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include <stdlib.h>


struct _duo_t {
	string index;
	string data;
};

duo_t create_duo(string index, string data)  {
    duo_t duo;
    duo = calloc(1, sizeof(struct _duo_t));
    duo->index = calloc(strlegth(index) + 1, sizeof(char));
    duo->data = calloc(strlegth(data) + 1, sizeof(char));
    strncpy(duo->index, index);
    strncpy(duo->data, data);

    return(duo);
}

string get_data(duo_t duo) {
    return(duo->data);
}

string get_index(duo_t duo) {
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
