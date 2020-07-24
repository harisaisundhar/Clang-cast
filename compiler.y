// Header value init
%{

	#include "header.h"
	
	int pivot=0;
	int temp_int=1;
	int i,j;
	int freq = 0;
	int keys_d[26],data_d[26];	
	
	extern int counter_int;
	extern char buff_array[100][100];	
	
%}

//Token declartion
%token main_fn int_var string_charp float_var char_var number variable variable_t delim_comma delim_break loop_for loop_while delim_colon switch_d switch_c then cond_if cond_else SWITCH paranth_op paranth_cl force_start force_end platform_print arith_add arith_min arith_mul arith_div arith_equ check_greaterthan check_lesserthan check_greaterequals check_lesserequals check_equals count_increment count_fact count_power declare_fn define_fn id_n

%nonassoc check_if
%nonassoc cond_else

%left arith_add arith_min
%left arith_mul arith_div

%left count_fact
%left count_power

%left check_lesserthan check_greaterthan
%left variable
