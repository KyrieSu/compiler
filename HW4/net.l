%{
    #include "y.tab.h"
    #include <stdlib.h>
    #include <math.h>
    int line = 1;
%}
int CHARtoINT(char*,int);
%x comment
%%
"#" { BEGIN comment; }
<comment>\n	{ line++;BEGIN INITIAL; }
<comment>.	{}
[0-9]+ { yylval.num = atoi(yytext); return NUMBER; }
[Ii][Nn][Pp][Uu][Tt]"("[0-9]+")" { yylval.num = CHARtoINT(yytext,1); return INPUT; }
[Oo][Uu][Tt][Pp][Uu][Tt]"("[0-9]+")" { yylval.num = CHARtoINT(yytext,2); return OUTPUT; }
[Bb][Uu][Ff][Ff] { return BUFF; }
[Nn][Oo][Tt] { return NOT; }
[Nn][Aa][Nn][Dd] { return NAND; }
[Aa][Nn][Dd] { return AND; }
[Nn][Oo][Rr] { return NOR; }
[Oo][Rr] { return OR; }
[Nn][Xx][Oo][Rr] { return NXOR;}
[Xx][Oo][Rr] { return XOR; }
[ \t]   ;
[\n] { line++; return '\n'; }
^[ \t]*\n	{line++;}
. { return yytext[0]; }
%%

int yywrap(){
    return 1;
}

int CHARtoINT(char* text,int mode){ //mode==1 -> input //mode==2 -> output
    int value;
    if(mode==1)
        sscanf(text,"input(%d)",&value);
    if(mode==2)
        sscanf(text,"output(%d)",&value);
    return value;
}
