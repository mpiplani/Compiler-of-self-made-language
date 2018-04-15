NUMBER [0-9]+
LETTER [a-zA-Z]+

%{
	#include"y.tab.h"
	#include<stdio.h>
%}


%%
if                 return IF;
then                 return THEN;
else                 return ELSE; 
">="		return(GE);
"<="		return(LE);
"=="		return(DE);
{NUMBER} {yylval.sym=(char)yytext[0]; return NUMBER;}
{LETTER} {yylval.sym=(char)yytext[0];return LETTER;}
[ \t]                 ;
\n                yyterminate();
.                 return yytext[0];
%%
