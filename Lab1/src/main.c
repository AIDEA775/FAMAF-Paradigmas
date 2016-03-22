#include <argp.h>
#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

#include "dictionaries.h"
#include "helper.h"

const char *argp_program_version = "Ale's Translation 1.0";
const char *user_interface = "No hay traducción para la palabra: %s\n"
             "Ignore (i) - Ignorar Todas (h) - Traducir como (t) - Traducir siempre como (s)";

// Documentation.
static char doc[] =
  "Translate Spanish to English files and backhand";

// The options.
static struct argp_option options[] = {
  {"input", 'i', "FILE", 0, "Input file to translate" },
  {"output", 'o', "FILE", 0, "Output file" },
  {"dictionary", 'd', "FILE", 0,  "Translation dictionary" },
  {"ignored", 'g', "FILE", 0, "Dictionary ignored words" },
  {"reverse", 'r', 0, 0, "Reverse translation" },
  { 0 }
};

struct Settings {
  char *file_src;
  char *file_out;
  char *file_dic;
  char *file_ign;
  bool reverse;
};

// Parse a single option.
static error_t parse_opt (int key, char *arg, struct argp_state *state) {
  struct Settings *settings = state->input;

  switch (key) {
    case 'i':
      settings->file_src = arg;
      break;
    case 'o':
      settings->file_out = arg;
      break;
    case 'd':
      settings->file_dic = arg;
      break;
    case 'g':
      settings->file_ign = arg;
      break;
    case 'r':
      settings->reverse = true;
      break;
    case ARGP_KEY_ARG:
        //Too many arguments.
        argp_usage (state);
      break;
    case ARGP_KEY_END:
      if (settings->file_src == NULL)
        // Need source file
        argp_usage (state);
      break;
    default:
      return ARGP_ERR_UNKNOWN;
    }
  return 0;
}

static struct argp argp = { options, parse_opt, 0, doc };


bool islatinapha(char c) {
  return isalpha(c) || (strchr("áéíóúÁÉÍÓÚñÑ", c) != NULL);
}


void translate_word(dics_t dict, FILE *out, char* word) {
  char* option;
  char* translation;
  int translate;

  translate = dics_search(dict, word);
    switch (translate) {
      case FOUND:
        fprintf(out, "*%s*", get_translation(dict));
        break;
      case NOT_FOUND:
        printf(user_interface, word);
        option = readline(stdin);
        switch (*option) {
          case 'i':
          case 'h':
            // skip word
            add_exception(dict, word, *option == 'h');
            printf("Ignore word\n");
            break;
          case 't':
          case 's':
            // translate word
            printf("Translate %s by: \n", word);
            translation = readline(stdin);
            add_translation(dict, word, translation, *option == 's');
            fprintf(out, "|%s|", translation);
            free(translation);
            break;
          default:
            printf("Esto no deberia imprimirse!!\n");
            break;
        }
        free(option);
        option = NULL;
        break;
      case EXCEPTION:
        // skip
        break;
      default:
        printf("Esto tampoco no deberia imprimirse!!\n");
        break;
    }
}


void translate (dics_t dict, FILE *src, FILE *out) {
  char word[100];
  int ch, i;

  do {
    i = 0;

    // spaces
    while(EOF != (ch = fgetc(src)) && isspace(ch))
      fprintf(out, "%c", ch);

    if (ch == EOF)
      break;

    // character
    if(!islatinapha(ch)) {
      word[i++] = ch;
      word[i++] = '\0';
      fprintf(out, "%s", word);
      continue;
    }

    // word
    do {
      word[i++] = tolower(ch);
    } while(EOF != (ch = fgetc(src)) && islatinapha(ch));

    if(!isalpha(ch))
      ungetc(ch, src);

    word[i++] = '\0';

    translate_word(dict, out, word);

  } while(1);

}

int main (int argc, char **argv) {
  struct Settings settings;
  FILE *src;
  FILE *out;
  dics_t dict;

  // Default values.
  settings.file_src = NULL;
  settings.file_out = "translated.txt";
  settings.file_dic = "dictionary.txt";
  settings.file_ign = "ignored.txt";
  settings.reverse = false;

  // Parse arguments.
  argp_parse (&argp, argc, argv, 0, 0, &settings);

  printf ("SRC = %s\nOUT = %s\nDIC = %s\n"
          "IGN = %s\nREV = %s\n",
          settings.file_src, settings.file_out,
          settings.file_dic,
          settings.file_ign,
          settings.reverse ? "yes" : "no");

  dict = dics_create(settings.reverse, settings.file_dic, settings.file_ign);

  if(dict == NULL) {
    printf("Dictionary not found\n");
    return 1;
  }

  src = fopen(settings.file_src, "r");
  if(src == NULL) {
    printf("File not found\n");
    return 1;
  }

  out = fopen(settings.file_out, "w+");
  if(out == NULL) {
    printf("File out error\n");
    return 1;
  }

  translate(dict, src, out);
  dict = dics_destroy(dict);
  fclose(src);
  fclose(out);
  return 0;
}
