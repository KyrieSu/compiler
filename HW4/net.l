%{
    #include "y.tab.h"
    #include <stdlib.h>
    #include <math.h>
    int line = 1;
%}

%x comment
%%
[Bb][Uu][Ff][Ff] { return BUFFER; }
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
"#" { BEGIN comment; }
<comment>\n	{ line++;BEGIN INITIAL; }
<comment>.	{}
%%

int yywrap(){
    return 1;
}
