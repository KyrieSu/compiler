%{
    #include <stdio.h>
    #include <string.h>
    #include <stdlib.h>
    #define angle 180/3.1415926
    extern int yylex();
    extern char* yytext;
    extern int line;
    void yyerror(char*);
    double arr[100];
    double Varvalue(int);
    void setValue(int,double);
    int tmpIndex;
    int flag = 1;
%}

%union{
    double num;
    int index;
}

%type <num> expr

%token <num> NUMBER
%token <index> VAR
%token SIN COS NEG ABS LOG ADD SUB

%left '='
%left '+' '-'
%left '*' '/' '%'
%right '^'
%right UMINUS

%%
lines
    : /* empty*/
    | lines expr '\n' { printf("%1f\n",$2); }
    | lines '\n'
;
expr
    : expr '+' expr { $$ = $1 + $3; }
    | expr '-' expr { $$ = $1 - $3; }
    | expr '*' expr { $$ = $1 * $3; }
    | expr '/' expr { $$ = $1 / $3; }
    | expr '%' expr { $$ = fmod($1,$3); }
    | expr '^' expr { $$ = pow($1,$3);}
    | expr '=' expr { $$ = $3; setValue(tmpIndex,$3); }
    | NEG '(' expr ')' { $$ = -$3; }
    | ABS '(' expr ')' { $$ = fabs($3); }
    | SIN '(' expr ')' { $$ = sin($3*angle); }
    | COS '(' expr ')' { $$ = cos($3*angle); }
    | LOG '(' expr ')' { $$ = log10($3); }
    | expr ADD { $$ = ($1+1); }
    | expr SUB { $$ = ($1-1); }
    | ADD expr { $$ = ($2+1); }
    | SUB expr { $$ = ($2-1); }
    | '(' expr ')' {$$ = $2; }
    | '-' expr %prec UMINUS {$$ = -$2;}
    | NUMBER { $$ = $1; }
    | VAR { $$ = Varvalue($1); }
;
%%

void yyerror(char* msg){
    printf("Line %d:%s with token \"%s\"\n",line,msg,yytext);
}

double Varvalue(int index){
    if(flag==1){
        tmpIndex = index;
        flag = 0;
    }
    if(tmpIndex!=index && arr[index]==0){
        printf("Line %d:var%d is undefined\n",line,index);
        exit(-1);
    }
    return arr[index];
}

void setValue(int index,double value){
    flag = 1;
    arr[index] = value;
}

int main(){
    memset(&arr,0,100); //initize arr value = 0
    yyparse();
    return 0;
}
