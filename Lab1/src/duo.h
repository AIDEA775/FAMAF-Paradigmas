#include <stdio.h>
#include <stdbool.h>

typedef struct _duo_t  *duo_t;

duo_t create_duo(string index, string data);

string get_data(duo_t duo);

string get_index(duo_t duo);

duo_t destroy_duo(duo_t duo);
