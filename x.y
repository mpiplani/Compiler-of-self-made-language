%{
#include <stdio.h>
#include <stdlib.h>

extern FILE *fp;

%}

%token INT FLOAT CHAR LONG STRING BOOL
%token FOR WHILE 
%token IF ELSE ELSEIF
%token PRINT SCAN
%token BREAK CONTINUE RETURN
%token INCREMENT DECREMENT
%token PLUS MINUS MULTIPLY DIVIDE
%token MODULUS GREATER LESSER GE LE EQUALS NOTEQUALS LOGICAND LOGICOR
%token SIZE ID CONSTANT FUNK NEWLINE


%start CODE
%%
CODE					:	DECLARATION
						|	DECLARATION CODE
						;

DECLARATION 			:	FUNCTION_DEFINITION 
						|	VARIABLE_DECLARATION_STATEMENT
						|	STATEMENTS
						;

FUNCTION_DEFINITION		:	FUNK TYPE ID '(' PARAMETER ')' '{' NEWLINE STATEMENTS '}'NEWLINE;

PARAMETER 				:	ID_LIST
						|	
						;

ID_LIST					:   TYPE ID
						| TYPE ID ',' ID_LIST
						;


VARIABLE_DECLARATION	: TYPE DECLARATION_LIST 
						| DECLARATION_LIST 
						;
VARIABLE_DECLARATION_STATEMENT: VARIABLE_DECLARATION ';' NEWLINE ;


DECLARATION_LIST		: VARIABLE
						| VARIABLE ',' DECLARATION_LIST
						;


VARIABLE				: EXPRESSION
						| ASSIGNMENT_EXPRESSION
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

EXPRESSION 				: IDENTIFIER OPERATOR
						| '(' EXPRESSION ')'
						| RELATIONAL_STATEMENT
						| FUNCTION_CALL
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
						|	OUTPUT_STATEMENT
						| 	FUNCTION_CALL ';'NEWLINE
						;


ASSIGNMENT_EXPRESSION	:	ID '=' EXPRESSION  ; 

EXPRESSION_STATEMENT	:	EXPRESSION ';' NEWLINE
				|	ASSIGNMENT_EXPRESSION ';' NEWLINE
						;


FUNCTION_CALL			:	ID '(' PASS_PARAMETER ')' ;

PASS_PARAMETER 			:	IDENTIFIER
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



OPERATOR				:	UNARY_OPERATOR
						| OPERATORS_IDENTIFIER_LIST
						|	
						;



OPERATORS_IDENTIFIER_LIST	:	OPERATORS_IDENTIFIER_LIST OPERATORS_IDENTIFIER_LIST
							|	OPR EXPRESSION
						;


OPR 						:	PLUS
							|	MULTIPLY
							|	DIVIDE
							|	MODULUS
							|	MINUS
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



INPUT_STATEMENT				:	SCAN '(' PASS_PARAMETER ')' ';' NEWLINE; 


OUTPUT_STATEMENT 			:	PRINT '('ID')' ';' NEWLINE ;

%%`
#include"lex.yy.c"
#include<ctype.h>


int main(int argc, char *argv[])
{
	yyin = fopen(argv[1], "r");
	
   if(!yyparse())
		printf("\nParsing complete\n");
	else
		printf("\nParsing failed\n");
	
	fclose(yyin);
    return 0;
}
         
void yyerror(char *s) {
	printf("%d : %s %s\n", yylineno,s, yytext );
}
