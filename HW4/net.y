%{
    #include <stdio.h>
    #include <string.h>
    #include <stdlib.h>
    extern int yylex();
    extern char* yytext;
    extern int line;
    void yyerror(char*);
%}
