// Token definition

#include <math.h> // For arithmetic ops
#include <stdlib.h> // lib data
#include <stdio.h> // print and scanf funcs
#define MAX_CH 100 // max_buffer size

// check header def
#ifndef YYTOKENTYPE
#define YYTOKENTYPE

// default Symbol table 
enum yytokenty{
  main_fn = 258,
  int_var = 259,
  string_charp = 260,
  float_var = 261,
  char_var = 262,
  number = 263,
  variable = 264,
  variable_t = 265,
  delim_comma = 266,
  delim_break = 267,
  loop_for = 268,
  loop_while = 269,
  delim_colon = 270,
  switch_d = 271,
  switch_c = 272,
  then = 273,
  cond_if = 274,
  cond_else = 275,
  SWITCH = 276,
  paranth_op = 277,
  paranth_cl = 278,
  force_start = 279,
  force_end = 280,
  platform_print = 281,
  arith_add = 282,
  arith_min = 283,
  arith_mul = 284,
  arith_div = 285,
  arith_equ = 286,
  check_greaterthan = 287,
  check_lesserthan = 288,
  check_greaterequals = 289,
  check_lesserequals = 290,
  check_equals = 291,
  count_increment = 292,
  count_fact = 293,
  count_power = 294,
  declare_fn = 295,
  define_fn = 296,
  id_n = 297,
  check_if = 298
};

#endif

typedef int YYSTYPE;
extern YYSTYPE yylval;