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
%left arith_div arith_mul

%left count_fact
%left count_power

%left check_lesserthan check_greaterthan
%left variable

// Rules are defined here
%%

get_start_run: main_fn paranth_op paranth_cl force_start get_params get_call_function force_end  { printf("\nSuccess: Compilation\n"); } ;

get_call_function: ;| define_fn id_n paranth_op paranth_cl force_start get_funcdata force_end  { printf("\nSuccess: End of function\n"); } ;

get_params: | get_params get_value | get_params get_vardec | get_params get_while_cond | get_params get_udfunc ;

get_udfunc: declare_fn id_n paranth_op paranth_cl delim_break { printf("\nCall: Function defined by user\n"); } ;
	
get_vardec: get_vartyp get_vardef delim_break	{ printf("\nInterpret: Declaration valid\n"); } ;
			
get_vartyp: int_var | float_var | char_var ;

get_funcdata: number delim_break 
{
	if($1 % 2 == 0) { printf("\nInterpret: %d -> even \n", $1); }
	else { printf("\nInterpret: %d -> odd \n", $1); }
} ;
	
get_vardef: get_varfollow delim_comma get_vardef | get_varfollow ;
			
get_varfollow: variable	
{
	if(data_d[$1] == 1) { printf("\nError: %c -> re-initialized\n", $1+'a'); }
	else { data_d[$1] = 1; }
} | variable_t
{																			
	for(i = 0; i < counter_int-1; i++) {									
		for(j = 0; buff_array[counter_int-1][j] != '\0'; j++) {
			if(buff_array[i][j] == buff_array[counter_int-1][j]) { freq++; }	
		}				
		if(freq == j && buff_array[i][j] == '\0' && buff_array[counter_int-1][j] == '\0') {	printf("\nAssign: %s -> re-initialized \n", buff_array[counter_int-1]); }
		freq=0;																		
	}										
} | variable_t arith_equ number 
{
	if(counter_int < 2) { char c = (char) $3; buff_array[pivot][99] = c; int i = (int) c; pivot++; }
	for(i = 0; i < counter_int - 1; i++) {	
		for(j = 0; buff_array[counter_int-1][j] != '\0'; j++) {
			if(buff_array[i][j] == buff_array[counter_int-1][j]) { freq++; }
		}
		if(freq == j && buff_array[i][j] == '\0' && buff_array[counter_int-1][j] =='\0') { printf("\nAssign: %s -> re-initialized \n", buff_array[counter_int-1]); temp_int=0; }
		freq=0;
	}
	if(temp_int&&counter_int > 1) { char c = (char) $3; buff_array[pivot][99] = c; int i = (int) c; pivot++; }
	if(temp_int) { printf("\nInterpret: value of %s = %d\t\n",buff_array[counter_int-1],buff_array[counter_int-1][99]); }
} | variable arith_equ number 
{ 	
	if(data_d[$1] == 1) { printf("\nAssign: %c -> re-initialized\n", $1 + 'a'); }
	else { data_d[$1]=1; }
	keys_d[$1] = $3; 
	printf("\nInterpret: value of the %c = %d\t\n",$1 + 'a', $3);
} ;
			
get_while_cond: cond_if paranth_op get_validate paranth_cl force_start get_validate force_end %prec check_if	
{			
	if($3) { printf("\nDebugger: value of the condition -> (if): %d\n", $7); }
	else { printf("\nDebugger: value of the condition -> (cond_if): 0\n"); }								
} |cond_if paranth_op get_validate paranth_cl force_start cond_if paranth_op get_validate paranth_cl force_start get_validate force_end cond_else force_start get_validate force_end force_end cond_else force_start get_validate force_end 
{
	if($3) { 
		if($9) { printf("\nDebugger: value of the condition -> (if if): %d\n", $13); }
		else { printf("\nDebugger: value of the condition -> (if else): %d\n", $17); }
	}
	else { printf("\nvalue of get_validate in only else: %d\n", $21); }
} |cond_if paranth_op get_validate paranth_cl force_start get_validate force_end cond_else force_start cond_if paranth_op get_validate paranth_cl force_start get_validate force_end cond_else force_start get_validate force_end force_end
{
	if($3) { printf("\nDebugger: value of the condition -> (only if): %d\n", $7); }
	else {
		if($14) { printf("\nDebugger: value of the condition -> (else if): %d\n", $18); }
		else { printf("\nDebugger: value of the condition -> (else else): %d\n", $21); }
	}
} | number count_fact 
{  
	int fac=1 ;
	for( int m = $1; m > 0; m--) { fac=fac*m; }
	$$ = fac;
	printf("\nInterpret: factorial(!) -> %d\n", $$); 
} | loop_for paranth_op variable arith_equ number delim_break variable check_lesserequals number delim_break variable count_increment paranth_cl force_start get_while_cond force_end
{
	printf("\nCall:Loop Started :\n");
	for( keys_d[$3]=$5; keys_d[$3] <= $9; keys_d[$3]++) { printf("data -> %d\n", $15); }
} | loop_while paranth_op variable check_lesserthan number paranth_cl force_start get_while_cond variable count_increment delim_break force_end    
{
	printf("\nCall:While loop Started :\n");
	while(keys_d[$3] < $5){ printf("data -> %d\n", $9); keys_d[$3]++; }
} | platform_print paranth_op variable paranth_cl delim_break 
{ 
	printf("\nDebugger:Print called -> value: %d\n", keys_d[$3]); 
} | get_validate delim_break ;
					
get_value: delim_break | get_validate delim_break 
{ 
	printf("\nDebugger:Expresssion -> value: %d\n", $1); 
} | variable arith_equ get_validate delim_break 	
{
	keys_d[$1] = $3; 
	if(data_d[$1] != 1) { printf("\nError:'%c' undefined\n", $1 + 'a'); }
} ;
	
get_validate: variable					
{ 
	$$ = keys_d[$1]; 
} | get_validate check_lesserthan get_validate
{
	$$ = $1 < $3; 
} | get_validate check_greaterthan get_validate	
{
	$$ = $1 > $3;
} | get_validate arith_mul get_validate	
{
	$$ = $1 * $3; 
} | get_validate arith_div get_validate	
{ 
	if($3) { $$ = $1 / $3; }
	else { $$ = 0; printf("\nError: Zero divison\n"); }
} |get_validate arith_add get_validate
{
	$$ = $1 + $3;
} |get_validate arith_min get_validate 
{
	$$ = $1 - $3;
} | get_validate count_power get_validate
{ 
	$$ = pow($1, $3);
	printf("\nInterpret: power -> value = %d\n", $$);
} |get_finaldata ;
			 
get_finaldata: get_digp;
			
get_digp: get_num	
{
	$$ = $1;
} | paranth_op get_validate paranth_cl 
{
	$$ = $2;
} ;
			
get_num: number { $$ = $1; } ;
			
%%

yyerror(char *error){ printf( "\nError:%s\n", error); return 0; }

int yywrap() { return 1; }