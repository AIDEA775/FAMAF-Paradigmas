// Copyright 2015 Alejandro Nigrelli y Alejandro Silva

#include <argp.h>
#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

#include "./dictionaries.h"
#include "./helper.h"

// latin chars
const char *latin_mayus = "ÁÉÍÓÚÑ";
const char *latin_minus = "áéíóúñ";
const char *latin_chars = "áéíóúñÁÉÍÓÚÑ";

// user interface
const char *argp_program_version = "Ale's Translation 1.0";
const char *user_interface = "Ignore (i) - Ignore all (h) - "
                             "Translated as (t) - Always translate as (s)\n"
                             ">> I can't find translation for *%s*\n"
                             ">> Your option: ";
static char doc[] =
  "Translate Spanish to English files and backhand";

// The options
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

// Parse a single option
static error_t parse_opt(int key, char *arg, struct argp_state *state) {
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
        // too many arguments.
        argp_usage(state);
      break;
    case ARGP_KEY_END:
      if (settings->file_src == NULL)
        // need source file
        argp_usage(state);
      break;
    default:
      return ARGP_ERR_UNKNOWN;
    }
  return 0;
}

static struct argp argp = { options, parse_opt, 0, doc };

char to_latin_lower(char c) {
    char* i;
    if ((i = strchr(latin_mayus, c)) != NULL) {
        return latin_minus[(i - latin_mayus) / sizeof(char)];
    } else {
        return tolower(c);
    }
}

bool is_latin_apha(char c) {
  return isalpha(c) || (strchr(latin_chars, c) != NULL);
}

// translate a single word
void translate_word(dics_t dict, FILE *out, char* word) {
  char* option;
  char* translation;
  int translate;

  translate = dics_search(dict, word);
  switch (translate) {
    case FOUND:
      fprintf(out, "%s", get_translation(dict));
      break;

    case EXCEPTION:
      fprintf(out, "%s", word);
      break;

    case NOT_FOUND:
      printf(user_interface, word);
retry:
      option = readline(stdin);
      switch (*option) {
        case 'i':
        case 'h':
          // skip word
          fprintf(out, "%s", word);
          add_exception(dict, word, *option == 'h');
          printf(">> Word ignored!\n\n");
          break;

        case 't':
        case 's':
          // translate word
          printf(">> Translate *%s* as: ", word);
          translation = readline(stdin);
          add_translation(dict, word, translation, *option == 's');
          fprintf(out, "%s", translation);
          printf(">> Translated!\n\n");
          free(translation);
          break;

        default:
          printf(">> Sorry, try again: ");
          free(option);
          goto retry;
          break;
      }
      free(option);
      option = NULL;
      break;

    default:
      break;
  }
}

// translate src and save in out
void translate(dics_t dict, FILE *src, FILE *out) {
  char word[100];
  int ch, i;

  do {
    i = 0;

    // spaces
    while (EOF != (ch = fgetc(src)) && isspace(ch))
      fprintf(out, "%c", ch);

    if (ch == EOF)
      break;

    // character
    if (!is_latin_apha(ch)) {
      word[i++] = ch;
      word[i++] = '\0';
      fprintf(out, "%s", word);
      continue;
    }

    // word
    do {
      word[i++] = to_latin_lower(ch);
    } while (EOF != (ch = fgetc(src)) && is_latin_apha(ch));

    if (!is_latin_apha(ch))
      ungetc(ch, src);

    word[i++] = '\0';

    translate_word(dict, out, word);
  } while (1);
}

int main(int argc, char **argv) {
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
  argp_parse(&argp, argc, argv, 0, 0, &settings);

  dict = dics_create(settings.reverse, settings.file_dic, settings.file_ign);

  if (dict == NULL) {
    printf("Dictionary error\n");
    return 1;
  }

  src = fopen(settings.file_src, "r");
  if (src == NULL) {
    printf("File not found\n");
    return 1;
  }

  out = fopen(settings.file_out, "w+");
  if (out == NULL) {
    printf("File out error\n");
    return 1;
  }

  translate(dict, src, out);
  dict = dics_destroy(dict);
  fclose(src);
  fclose(out);
  return 0;
}
