%{
    #include <stdio.h>
    #define YYSTYPE double /* double type for yacc stack */
    extern int yylex()
    void yyerror(char*)
%}

%token NUMBER
