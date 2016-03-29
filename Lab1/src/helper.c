#include "helper.h"

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
