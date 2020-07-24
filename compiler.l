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

