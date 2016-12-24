%{
    #include <stdio.h>
    #include <string.h>
    #include <stdlib.h>
    extern int yylex();
    extern char* yytext;
    extern int line;
    void yyerror(char*);
%}

%union{
    int num;
}

%type <num> expr

%token <num> INPUT OUTPUT
%token BUFF NOT AND NAND OR NOR XOR NXOR

%left '='

%%
lines
    : /* empty*/
    | lines expr '\n' { printf("%1f\n",$2); }
    | lines '\n'
;
expr
;
%%


int main(){
    yyparse();
    return 0;
}
