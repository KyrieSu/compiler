%{
    #include "y.tab.h"
    #include <stdlib.h>
    #include <math.h>
    int line = 1;
%}
int CHARtoINT(char*);
%%
[0-9]+"."[0-9]+ { yylval.num = strtod(yytext,NULL); return NUMBER; }
[0-9]+  { yylval.num = strtod(yytext,NULL); return NUMBER; }
(var|VAR)[0-9]+ { yylval.index = CHARtoINT(yytext); return VAR; }
sin|SIN  { return SIN; }
cos|COS  { return COS; }
neg|NEG  { return NEG; }
abs|ABS  { return ABS; }
log|LOG  { return LOG; }
"++" { return ADD; }
"--" { return SUB; }
[ \t]   ;
[\n] { line++; return '\n'; }
^[ \t]*\n	{line++;}
. { return yytext[0]; }
%%

int yywrap(){
    return 1;
}

int CHARtoINT(char* text){
    return (text[3]-'0');
}
