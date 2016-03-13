
#include <stdlib.h>
#include <argp.h>
#include <stdbool.h>

const char *argp_program_version = "Ale's Translation 1.0";

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

int main (int argc, char **argv) {
  struct Settings settings;

  // Default values.
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

  exit (0);
}