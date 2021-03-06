/* Defining basic data*/
digit [0-9]
space [" "]

/* Header and declar data*/  
%{
	#include "header.h"

	extern int yylval;
	char str[MAX_CH];
	char buff_array[MAX_CH][MAX_CH];
	int i,counter_int=0;
%}

/* Keywords and wildcards def*/
%%


"cout_op"  { return cout_op };
"<<"    { return output_op };
"cin"   { return cin_op };
">>"	{ return input_op };
"class" { return class_dec };
"try"	{ return try_op };
"catch"	{ return catch_op };
"throw"	{ return throw_op };
"::"	{ return scope_res };
"template <typename T>" { return template_op };
"private"	{ return private_spec };
"public"	{ return public_spec };
"protected"	{ return protected_spec };
"T"		{ return T };
"return"	{return return_op};


"function"								{ return declare_fn; }
"int_main"								{ return main_fn; }

"!" 									{ return count_fact; }
"^" 									{ return count_power; }

"int"{space}"function"           	{ return define_fn; }

"float"								{ return float_var; }
"int"								{ return int_var; }
"char"								{ return char_var; }

{digit}+								{ yylval = atoi(yytext); return number; }

"{"									{ return force_start; }
"("										{ return paranth_op; }

")"										{ return paranth_cl; }
"}"									{ return force_end; }

"+"										{ return arith_add; }
"*"										{ return arith_mul; }

"/"										{ return arith_div; }
"-"										{ return arith_min; }

":"										{ return delim_colon; }
";"									{ return delim_break; }
","										{ return delim_comma; }

"="									{ return arith_equ;  }

"<"										{ return check_lesserthan; }
"<="									{ return check_lesserequals; }

">"										{ return check_greaterthan; }
">="									{ return check_greaterequals; }

"=="		    							{ return check_equals; }
"++"									{ return count_increment; }

"for"									{ return loop_for; }
"while"  								{return loop_while; }

"else"									{ return cond_else; }
"if"									{ return cond_if; }

"then"									{ return then; }

"printf" 							 	{return platform_print;}

[a-z]									{ yylval = *yytext - 'a'; return variable;}

[a-z]+[0-9]								{ yylval = *yytext - 'a'; return	id_n; }	
		
[a-z][a-z]+ 							{ for(i=0;i<yyleng;i++) buff_array[counter_int][i] = yytext[i]; counter_int++; return variable_t; }			

[ \t\n]*								;

"//"(.)*"\n" 							{ printf("Dummy comm line used to convey meaning\n");}

%%

//Main func
int main()
{
	printf("xxxxx____________Welcome to C/C++ Compiler___________xxxxx\n");
	printf("A gcc clone using flex and bison, open for contribution\n");
	printf("Developers :-\n");
	printf("Harisai, Karan, Sathwik\n");
	yyin = freopen("code.txt","r",stdin);
	printf("Program uppdate : Data read from file : code_txt\n");
	printf("Program uppdate : File parsed and saved : parse_txt\n");
	printf("xxxxx_________________Happy coding___________________xxxxx\n");
	yyout = freopen("parse.txt","w",stdout);
	yyparse();
	return 0;
}

