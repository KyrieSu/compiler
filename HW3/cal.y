%{
    #include <stdio.h>
    extern int yylex();
    extern char* yytext;
    extern int line;
    void yyerror(char*);
    extern double arr[10];
    double Varvalue(int);
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
    | expr '=' expr { $$ = $3; }
    | NEG '(' expr ')' { $$ = -$3; }
    | ABS '(' expr ')' { $$ = fabs($3); }
    | SIN '(' expr ')' { $$ = sin($3); }
    | COS '(' expr ')' { $$ = cos($3); }
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

double Varvalue(int x){
    return arr[x];
}

int main(){
    yyparse();
    return 0;
}
