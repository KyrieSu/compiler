%{
#include <stdio.h>
#include <math.h>
#define PI 3.141592
extern int yylex();
void yyerror(char *);
int abstest(float value);
float Varvalue(int varvalue);
void putVarvalue(int varvalue, float value);
int list[10][2]; //二維列表，左側為var，右側為value
int tempVar; 
int isHead = 1; // 當第一個(等號左邊的var)讀進時，會變0，保證左邊的值才會被存取
%}

%union { float num;
int index;
}
%type <num> expr;

%token <num> NUMBER;
%token <index> VAR;
%token SIN COS NEG ABS LOG ADD SUB
%token ERROR1

%left '=' 
%left '+' '-'
%left '*' '/' '%'
%right '^'
%right UMINUS

%%
lines
    : /* empty */
    | lines expr '\n'  { printf("%lf\n", $2); }
    | lines '\n'
    ;
expr
    : expr '+' expr {$$ = $1 + $3;}
    | expr '-' expr {$$ = $1 - $3;}
    | expr '*' expr {$$ = $1 * $3;}
    | expr '/' expr {$$ = $1 / $3;}
    | expr '%' expr {$$ = fmod($1,$3);}
    | expr '^' expr {$$ = pow($1,$3);}
    | expr '=' expr {$$ = $3; putVarvalue(tempVar,$3); }
    | NEG '(' expr ')' { $$ = -$3; } 
    | ABS '(' expr ')' { $$ = abstest($3); }
    | SIN '(' expr ')' { $$ = sin($3); } //$$ = sin(($3/180*PI));
    | COS '(' expr ')' { $$ = cos($3); } //$$ = cos(($3/180*PI)); 
    | LOG '(' expr ')' { $$ = log($3)/log(10); }
    | ADD expr { $$ = ($2+1); } 
    | SUB expr { $$ = ($2-1); } 
    | '(' expr ')' {$$ = $2; }
    | '-' expr %prec UMINUS {$$ = -$2;}
    | NUMBER
    | VAR { $$ = Varvalue($1); }   
   // | ERROR1 {printf("syntax error with token \"%s\"\n",yytext);}
;

%%
void yyerror(char *s) {
    printf("%s\n", s);
    
}
int abstest(float value)
{
	if(value < 0)
		return (-value);
}
float Varvalue(int varvalue) //當var第一次被讀入設值為0，當第二次以上被讀入，找其值
{
//printf("var%d\n",varvalue);
    if(isHead == 1)
    {
	tempVar = varvalue;
	isHead = 0;
    }	
int find = 0;
int i,j;
    for(i = 0; i < 10; i++)
    {
         if(varvalue == list[i][0])
         {
               find = 1;
//printf("IS FIND!\n");
               return list[i][1];
		break;
         }
    }
    if(find == 0)
    {
         for(j = 0 ; j < 10; j++)
         {
              if(list[j][0] == 0)
              {
//printf("put varvalue 0\n");
                    list[j][0] = varvalue;
                    list[j][1] = 0;
                    break;
              }
         }
         return 0;
    }
}
void putVarvalue(int varvalue, float value) //var值再等號左邊，放入值
{
int i;
isHead = 1; 
//printf("list[%d][0]\n",varvalue);
    for(i = 0; i < 10; i++)
    {
         if(varvalue == list[i][0])
         {
               list[i][1] = value;
//printf("putVarvalue = %f\n",value);
		break;
         }
    }
}
int main(void)
{
    yyparse();
    return 0;
}
