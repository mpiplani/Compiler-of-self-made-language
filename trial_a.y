%{
//# ==
//^ >=
//~ <=
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
void ThreeAddressCode();
void triple();
void qudraple();
void label1();
void label2();
void label3();
char AddToTable(char ,char, char);

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

%token <sym> LETTER NUMBER IF ELSE THEN 
%type <sym> expr
%type <sym> bool
%token GE LE DE
%left '-''+'
%right '*' '/'

%%

S : IF '(' bool ')'{ label1();} THEN expr ';'{label2();} ELSE expr ';'{label3();}
  ;
expr: expr '+' expr {$$ = AddToTable((char)$1,(char)$3,'+');}
| expr '-' expr {$$ = AddToTable((char)$1,(char)$3,'-');}
| expr '*' expr {$$ = AddToTable((char)$1,(char)$3,'*');}
| expr '/' expr {$$ = AddToTable((char)$1,(char)$3,'/');}
| '(' expr ')' {$$ = (char)$2;}
|LETTER '=' expr {$$ = AddToTable((char)$1,(char)$3,'=');}
| NUMBER {$$ = (char)$1;}
| LETTER {$$ = (char)$1;}
;

bool : bool GE bool {$$ = AddToTable((char)$1,(char)$3,'^');}
|bool '>' bool {$$ = AddToTable((char)$1,(char)$3,'>');}
|bool LE bool {$$ = AddToTable((char)$1,(char)$3,'~');}
|bool DE bool {$$ = AddToTable((char)$1,(char)$3,'#');}
|bool '<' bool {$$ = AddToTable((char)$1,(char)$3,'<');}
| LETTER {$$ = (char)$1;}

%%

#include "lex.yy.c"
#include<ctype.h>
struct incod code[20];

int id=0;

void label1(){
AddToTable('$','~','Z');

}

void label2(){

AddToTable('&','~','Z');
}

void label3(){
AddToTable('%','%','%');
}

char AddToTable(char opd1,char opd2,char opr)
{
code[ind].opd1=opd1;
code[ind].opd2=opd2;
code[ind].opr=opr;
ind++;
temp++;
return temp;
}

void ThreeAddressCode()
{
int cnt=0;
temp++;
printf("\n\n\t THREE ADDRESS CODE\n\n");
while(cnt<ind)
{


if(code[cnt].opd1=='$')
{
printf( "if not %c ",temp-1); 
printf(" GOTO L \n");
cnt++;
}
else if(code[cnt].opd1=='&')
{ 
printf("GOTO L1 \n");
printf("L : \n");
cnt++;
}
else if(code[cnt].opd1=='%')
{ 
printf("L1 : \n");
cnt++;
}
else{
printf("%c : = \t",temp);
if(isalpha(code[cnt].opd1))
printf("%c\t",code[cnt].opd1);
else
{//printf("%c\t",temp);
printf("%d\t",code[cnt].opd1-'0');}

printf("%c\t",code[cnt].opr);

if(isalpha(code[cnt].opd2))
printf("%c\t",code[cnt].opd2);
else
{//printf("%c\t",temp);
printf("%d\t",code[cnt].opd2-'0');}

printf("\n");
cnt++;
temp++;
}
}
}




main()
{
printf("\n Enter the Expression: ");
yyparse();
temp='A';
ThreeAddressCode();

}

