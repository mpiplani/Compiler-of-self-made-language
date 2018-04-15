digit			[0-9]
alphabet		[a-zA-Z]

%{
	#include "y.tab.h"
	#include<stdio.h>
	void count(void);
	void comment(void);
	int yylineno=0;
%}

%%
[ \t]			;
[\n]+			{ count(); yylineno=yylineno+1; return(NEWLINE);}

"/*"			{ comment(); }
"//"[^\n]*              { /* consume //-comment */ }

"Boolean"			return BOOL;
"int" 			return INT;
"float" 			return FLOAT;
"char" 			return CHAR;
"long" 			return LONG;
"string"			return STRING;
"for" 			return FOR;
"while"			return WHILE;
"if" 			return IF;
"elseif"			return ELSEIF;
"else"		return ELSE;
"printf" 			return PRINT;
"scanf"			return SCAN;
"break"			return BREAK;
"continue"	return CONTINUE;
"return"		return RETURN;
"funk"		return FUNK;


"!"			return('!');
"++"		return(INCREMENT);
"--"		return(DECREMENT);
"+"		return(PLUS);
"-"		return(MINUS);
"*"		return(MULTIPLY);
"/"				return(DIVIDE);
"%"			return(MODULUS);
">"			return(GREATER);
"<"			return(LESSER);
">="		return(GE);
"<="		return(LE);
"=="		return(EQUALS);
"!="		return(NOTEQUALS);
"&&"		return(LOGICAND);
"||"		return(LOGICOR);

{digit}+       {yylval=atoi(yytext); return SIZE;}
{alphabet}({alphabet}|{digit})* {return (ID);yylval=atoi(yytext);}
{digit}+"."{digit}+		{yylval=strdup(yytext);return(CONSTANT);}
\"(\\.|[^\\"])*\"		{yylval=strdup(yytext);return(STRING);}

";"				{ count(); return(';'); }
"{"				{ count(); return('{'); }
"}"				{ count(); return('}'); }
","				{ count(); return(','); }
"("				{ count(); return('('); }
")"				{ count(); return(')'); }
"."				{ count(); return('.'); }
[ \t\v\f]		{ count(); }
.			{return yytext[0];}
%%

int yywrap(void)
{
	return 1;
}

int column = 0;

void count(void)
{
	int i;

	for (i = 0; yytext[i] != '\0'; i++)
		if (yytext[i] == '\n')
			column = 0;
		else if (yytext[i] == '\t')
			column += 8 - (column % 8);
		else
			column++;

	ECHO;
}

void comment(void)
{
	char c, prev = 0;
  
	while ((c = input()) != 0)      /* (EOF maps to 0) */
	{
		if (c == '/' && prev == '*')
			return;
		prev = c;
	}
	error("unterminated comment");
}
