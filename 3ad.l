%{
#include"y.tab.h"
#include<stdio.h>
extern char yyval;
%}

DIGIT [0-9]+
ALPHABET [a-zA-Z]+

%%


{DIGIT} {yylval.sym=(char)yytext[0]; return DIGIT;}
{ALPHABET} {yylval.sym=(char)yytext[0];return ALPHABET;}

\n {return 0;}
. {return yytext[0];}

%%
int yywrap(void)
{
	return 1;
}

