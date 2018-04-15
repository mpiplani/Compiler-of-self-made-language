%{
#include <stdio.h>
#include <stdlib.h>

extern FILE *fp;
struct symbolTable

{

char sym_name[15];

};

 

int cnt=0;

void insert(char tok[15]);

void print();

struct symbolTable sym[10];
%}

%token INT FLOAT CHAR LONG STRING BOOL
%token FOR WHILE 
%token IF ELSE ELSEIF
%token PRINT SCAN
%token BREAK CONTINUE RETURN
%token INCREMENT DECREMENT
%token PLUS MINUS MULTIPLY DIVIDE
%token MODULUS GREATER LESSER GE LE EQUALS NOTEQUALS LOGICAND LOGICOR
%token SIZE 
%token ID 
%token CONSTANT 
%token FUNK NEWLINE


%start CODE
%%
CODE					:	DECLARATION {$$=$1;printf("final%d",$1);}
						|	DECLARATION CODE
						;

DECLARATION 			:	FUNCTION_DEFINITION 
						|	VARIABLE_DECLARATION_STATEMENT{$$=$1;printf("%d",$1);}
						|	STATEMENTS {$$=$1;printf("s%d",$1);}
						;

FUNCTION_DEFINITION		:	FUNK TYPE ID '(' PARAMETER ')' '{' NEWLINE STATEMENTS '}'NEWLINE;

PARAMETER 				:	ID_LIST
						|	
						;

ID_LIST					:   TYPE ID
						| TYPE ID ',' ID_LIST
						;


VARIABLE_DECLARATION	: TYPE DECLARATION_LIST 
						| DECLARATION_LIST {$$=$1;printf("%d",$1);}
						;
VARIABLE_DECLARATION_STATEMENT: VARIABLE_DECLARATION ';' NEWLINE {$$=$1;printf("%d",$1);} ;


DECLARATION_LIST		: VARIABLE {$$=$1;printf("%d",$1);}
						| VARIABLE ',' DECLARATION_LIST
						;


VARIABLE				: EXPRESSION
						| ASSIGNMENT_EXPRESSION {$$=$1;printf("%d",$1);}
						| ID'['SIZE']'
						| ID
						| ID'['SIZE']' '['SIZE']'
						;

TYPE					: INT
						| FLOAT
						| CHAR
						| STRING
						| BOOL
						| LONG
						;

EXPRESSION 				: EXPRESSION OPR EXPRESSION{ printf("operator %c numbers %d %d",$2,$1,$3);switch($2){
									case '+':
									$$=$1+$3;
									printf(" + case %d",$$);
									break;
									case '*':
									$$=$1*$3;
									break;

									case '/':
									$$=$1/$3;
									break;

									case '-':
									$$=$1-$3;
									break;

									case '%':
									$$=$1%$3;
									break;
								}
								printf("output%d",$$);}


						| '(' EXPRESSION ')'{$$=$2;}
						| RELATIONAL_STATEMENT{$$=$1;}
						| FUNCTION_CALL {$$=$1;}
						| SIZE		{$$=$1;printf("%d",$1);}
						| ID 		{$$=$1;printf("variable %d",$1);}
						| UNARY_OPERATION
						;



IDENTIFIER 				:	ID 
						|	STRING
						|	CONSTANT
						|	SIZE
						;

						

STATEMENTS 				:	LOOPING_STATEMENTS
						|	CONDITIONAL_STATEMENTS
						|	JUMP
						|	STATEMENTS STATEMENTS
						|	EXPRESSION_STATEMENT
						|	VARIABLE_DECLARATION_STATEMENT
						|	INPUT_STATEMENT
						|	OUTPUT_STATEMENT{$$=$1;printf("out%d %d",$$,$1);}
						| 	FUNCTION_CALL ';'NEWLINE
						;


ASSIGNMENT_EXPRESSION	:	ID '=' EXPRESSION  {$1 = $3;$$=$1;printf("value in id%d",$1);} ;

EXPRESSION_STATEMENT	:	EXPRESSION ';'NEWLINE
				|	ASSIGNMENT_EXPRESSION ';' NEWLINE 
						;


FUNCTION_CALL			:	ID '(' PASS_PARAMETER ')' ;

PASS_PARAMETER 			:	IDENTIFIER{$$=$1;}
						|	IDENTIFIER ',' PASS_PARAMETER
						;


CONDITIONAL_STATEMENTS 	:	IF '(' EXPRESSION ')''{'NEWLINE
								STATEMENTS 
							'}'NEWLINE
						
						|	IF '(' EXPRESSION ')' '{' NEWLINE
								STATEMENTS
							'}' NEWLINE
							ELSE '{' NEWLINE
								STATEMENTS
							'}'NEWLINE
						
						|	IF '(' EXPRESSION ')' '{' NEWLINE
								STATEMENTS 
							'}' NEWLINE
							ELSEIF '(' EXPRESSION ')' '{' NEWLINE
								STATEMENTS 
							'}' NEWLINE
							ELSE '{' NEWLINE
								STATEMENTS 
							'}'NEWLINE
						;


LOOPING_STATEMENTS 		:	WHILE '(' EXPRESSION ')' '{' NEWLINE
								STATEMENTS
							'}'NEWLINE

						|	FOR '(' VARIABLE_DECLARATION ';'  EXPRESSION ';' EXPRESSION ')' '{' NEWLINE
								STATEMENTS 	
							'}'NEWLINE

						;


JUMP					:	CONTINUE ';'NEWLINE
						|	BREAK ';'NEWLINE
						|	RETURN ';'NEWLINE
						|	RETURN EXPRESSION ';'NEWLINE
						;



UNARY_OPERATION				:	IDENTIFIER UNARY_OPERATOR
						;




OPR 						:	PLUS {$$='+';}
							|	MULTIPLY {$$='*';}
							|	DIVIDE   {$$='/';}
							|	MODULUS  {$$='%';}
							|	MINUS    {$$='-';}
						;


UNARY_OPERATOR 				:	INCREMENT
							|	DECREMENT
						;


RELATIONAL_OPR				:	GE
							|	LE
							|	GREATER
							|	LESSER
							|	NOTEQUALS
							|	EQUALS
							|	LOGICAND
							|	LOGICOR
						;


RELATIONAL_STATEMENT 		:	EXPRESSION RELATIONAL_LIST
							|	FUNCTION_CALL RELATIONAL_LIST
						;


RELATIONAL_LIST				:	RELATIONAL_OPR EXPRESSION
							|	RELATIONAL_OPR FUNCTION_CALL
							|	RELATIONAL_OPR RELATIONAL_LIST
						;



INPUT_STATEMENT				:	SCAN '(' PASS_PARAMETER ')' ';'{scanf("%d",&$3);printf("%d",$3);} NEWLINE; 


OUTPUT_STATEMENT 			:	PRINT '('ID')' ';' {printf("value of id %d %d",$3,$2);$$ = $3;printf("vvv %d",$$);} NEWLINE  ;

%%
#include"lex.yy.c"
#include<ctype.h>

void insert(char tok[15])

{

int fl=0,i;

for(i=0;i<cnt;i++)

{

if(strcmp(sym[i].sym_name,tok)==0)

{

fl=1;

break;

}

}

if(fl==0)

{

strcpy(sym[cnt++].sym_name,tok);

}

}

 
int main(int argc, char *argv[])
{
	yyin = fopen(argv[1], "r");
	
   if(!yyparse())
		printf("\nParsing complete\n");
	else
		printf("\nParsing failed\n");
	printf(“\n********* Symbol Table **********\n”);

        for(i=0;i<cnt;i++)

      printf(“%s\n”,sym[i].sym_name);
	
	fclose(yyin);
    return 0;
}
         
void yyerror(char *s) {
	printf("%d : %s %s\n", yylineno,s, yytext );
}
