%{

#include<stdio.h>
#include<string.h>
#include<stdlib.h>
void Three_address();
char Add_Table(char ,char, char);

int ind=0;
char temp='A';
struct incod
{
char opd1;
char opd2;
char opr;
};
%}

%union
{
char sym;
}

%token <sym> ALPHABET DIGIT
%type <sym> expr
%left '-''+'
%right '*' '/'

%%

statement: ALPHABET '=' expr ';' {Add_Table((char)$1,(char)$3,'=');}
| expr ';'
;

expr: expr '+' expr {$$ = Add_Table((char)$1,(char)$3,'+');}
| expr '-' expr {$$ = Add_Table((char)$1,(char)$3,'-');}
| expr '*' expr {$$ = Add_Table((char)$1,(char)$3,'*');}
| expr '/' expr {$$ = Add_Table((char)$1,(char)$3,'/');}
| '(' expr ')' {$$ = (char)$2;}
| DIGIT {$$ = (char)$1;}
| ALPHABET {$$ = (char)$1;}
;

%%
#include"lex.yy.c"
#include<ctype.h>

yyerror(char *s)
{
printf("%s",s);
exit(0);
}

struct incod code[20];

int id=0;

char Add_Table(char opd1,char opd2,char opr)
{
code[ind].opd1=opd1;
code[ind].opd2=opd2;
code[ind].opr=opr;
ind++;
temp++;
return temp;
}

void Three_address()
{
int cnt=0;
temp++;
printf("\n\n\t THREE ADDRESS CODE\n\n");
while(cnt<ind)
{
printf("%c : = \t",temp);
if(isalpha(code[cnt].opd1))
printf("%c\t",code[cnt].opd1);
else
{printf("%c\t",temp);}

printf("%c\t",code[cnt].opr);

if(isalpha(code[cnt].opd2))
printf("%c\t",code[cnt].opd2);
else
{printf("%c\t",temp);}

printf("\n");
cnt++;
temp++;
}
}

main()
{
printf("\n Enter the Expression: ");
yyparse();
temp='A';
Three_address();
}


 
