%{
    #include "y.tab.h"
%}

%%
[ \t] ;
[\n] { return '\n'; }
. { return yytext[0]; }
%%

int yywrap(){
    return 1;
}
