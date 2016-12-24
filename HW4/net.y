%{
    #include <stdio.h>
    #include <string.h>
    #include <stdlib.h>
    extern int yylex();
    extern char* yytext;
    extern int line;
    void yyerror(char*);
    void setValue(int,int);
    int arr[10000];
    int output = 0;
    int output_arr[100];
%}

%union{
    int num;
}

%type <num> expr

%token <num> INPUT OUTPUT NUMBER
%token BUFF NOT AND NAND OR NOR XOR NXOR

%right '='

%%
lines
    : /* empty*/
    | lines expr '\n'
    | lines '\n'
;
expr
    : NUMBER { $$ = $1;}
    | INPUT { $$ = $1;}
    | OUTPUT { $$ = $1;}
    | expr '=' expr { $$ = $3; setValue($1,$3); }
    | BUFF '(' expr ')' { $$ = arr[$3];}
    | NOT '(' expr ')' { $$ = !arr[$3];}
    | AND '(' expr ',' expr ')' { $$ = arr[$3] & arr[$5]; }
    | NAND '(' expr ',' expr ')' { $$ = !(arr[$3] & arr[$5]); }
    | OR '(' expr ',' expr ')'  { $$ = arr[$3] | arr[$5]; }
    | NOR '(' expr ',' expr ')' { $$ = !(arr[$3]|arr[$5]); }
    | XOR '(' expr ',' expr ')' { $$ = arr[$3]^ arr[$5]; }
    | NXOR '(' expr ',' expr ')'{ $$ = !(arr[$3] ^ arr[$5] );}
;
%%

void yyerror(char* msg){
    printf("Line %d:%s with token \"%s\"\n",line,msg,yytext);
}

void setValue(int index,int value){
    arr[index] = value;
}

int main(){
    memset(&arr,0,10000);
    yyparse();
    return 0;
}
