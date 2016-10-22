%{
    int line = 1;
    #include <stdio.h>
    #include <stdlib.h>
    #define id 1
    #define integer_literal 2
    #define float_literal 3
    #define exp_float 4 //science exponential
    #define str 5
    #define comma 6
    #define semicolon 7
    #define left_parenthesis 8
    #define right_parenthesis 9

    /* KEY WORD */
    #define begin_num 10
    #define end_num 11
    #define read_num 12
    #define write_num 13
    #define if_num 14
    #define then_num 15
    #define else_num 16
    #define endif_num 17
    #define for_num 18
    #define to_num 19
    #define endfor_num 20
    #define while_num 21
    #define endwhile_num 22
    #define repeat_num 23
    #define repeatend_num 24
    #define declare_num 25
    #define as_num 26
    #define integer_num 27
    #define real_num 28
    #define bool_num 29
    #define scaneof 30

    /* operator */
    #define assignment 31 // :=
    #define addition 32
    #define subtraction 33
    #define multiplication 34
    #define division 35
    #define notequal 36 //!=
    #define greaterthan 37 //>
    #define lessthan 38 //<
    #define greater_equal 39 //>=
    #define less_equal 40 //<=
    #define equal 41 //==
    #define doubleplus 42 //++
    #define doublesub 43 //--
    #define remainder 44 //%
    #define and 45 //&&
    #define or 46 // ||
    #define not 49 //!
    #define plus_ass 50 //+=
    #define sub_ass 51 //-=
    #define mul_ass 52 //*=
    #define div_ass 53 //"/="
    #define remainder_ass 54 // %=
    #define error 55
%}

/* Regular Expression */
%x comment1
%x comment2
Digit [0-9]
Letter [a-zA-Z]
IntLit {Digit}+
Id {Letter}({Letter}|{Digit}|_)*
FPLit {Digit}+[.]{Digit}+
FEPLit {Digit}+[.]*{Digit}+[E|e][-]*{Digit}+
LINE \n
%%
{LINE}	{line++;}
^[ \t]*\n	{line++;}
[ \t\n] { }
[Bb][Ee][Gg][Ii][Nn] { return begin_num; }
[Ee][Nn][Dd] { return end_num; }
[Rr][Ee][Aa][Dd] { return read_num; }
[Ww][Rr][Ii][Tt][Ee] { return write_num; }
[Ii][Ff] { return if_num; }
[Tt][Hh][Ee][Nn] { return then_num; }
[Ee][Ll][Ss][Ee] { return else_num; }
[Ee][Nn][Dd][Ii][Ff] { return endif_num; }
[Ff][Oo][Rr] { return for_num; }
[Tt][Oo] { return to_num; }
[Ee][Nn][Dd][Ff][Oo][Rr] { return endfor_num; }
[Ww][Hh][Ii][Ll][Ee] { return while_num; }
[Ee][Nn][Dd][Ww][Hh][Ii][Ll][Ee] { return endwhile_num; }
[Rr][Ee][Pp][Ee][Aa][Tt] { return repeat_num; }
[Rr][Ee][Pp][Ee][Aa][Tt][Ee][Nn][Dd] { return repeatend_num; }
[Dd][Ee][Cc][Ll][Aa][Rr][Ee] { return declare_num; }
[Aa][Ss] { return as_num; }
[Ii][Nn][Tt][Ee][Gg][Ee][Rr] { return integer_num; }
[Rr][Ee][Aa][Ll] { return real_num; }
[Bb][Oo][Oo][Ll] { return bool_num; }
[Ss][Cc][Aa][Nn][Ee][Oo][Ff] { return scaneof; }
{Id} { return id; }
{IntLit} { return integer_literal; }
{FPLit} { return float_literal; }
{FEPLit} { return exp_float; }
\"[^\"\n]*\" { striquotes(); return str; }
"," { return comma; }
";" { return semicolon; }
"(" { return left_parenthesis; }
")" { return right_parenthesis; }
":=" { return assignment; }
"+" { return addition; }
"-" { return subtraction; }
"*" { return multiplication; }
"/" { return division; }
"!=" { return notequal; }
">" { return greaterthan; }
"<" { return lessthan; }
">=" { return greater_equal; }
"<=" { return less_equal; }
"==" { return equal; }
"++" { return doubleplus; }
"--" { return doublesub; }
"%" { return remainder; }
"&&" { return and; }
"||" { return or; }
"!" { return not; }
"+=" { return plus_ass; }
"-=" { return sub_ass; }
"*=" { return mul_ass; }
"/=" { return div_ass; }
"%=" { return remainder_ass; }
<<eof>> { return scaneof; }
"%%"	{ BEGIN comment1; }
"{%"	{ BEGIN comment2; }
<comment1>\n	{ line++;BEGIN INITIAL; }
<comment1>.	{}
<comment2>\n { line++;}
<comment2>. {}
<comment2>"%}"  { BEGIN INITIAL; }
[,]+[,]+ { return error; }
["."]+["."]+ { return error; }
{Letter}+[.]{Digit}+	{ return error; }
{Digit}+[.]{Letter}+	{ return error; }
[.]{Digit}+ { return error; }
{Digit}+[.]	{ return error; }
{Digit}+[.]{Digit}+{Letter}+	{ return error; }
{Letter}+{Digit}+[.]{Digit}+	{ return error; }
{Digit}+[.]*{Digit}+[E|e][-]*{Digit}+{Letter}+	{ return error; }
["]+{Letter}+{Digit}+	{return error; }
[*]+[*]+	{ return error; }
[*]+[/]+	{ return error; }
[+]+[-]+	{ return error; }
[/]+[+]+	{ return error; }
[*]+[+]+	{ return error; }
([:][=])+	{ return error; }
[>]+[=]+	{ return error; }
[>][<]	{ return error; }
[=][>]	{ return error; }


%%

striquotes(){
    int frompos , topos = 0;
    for(frompos=1;frompos<yyleng;frompos++){
        yytext[topos++] = yytext[frompos];
    }
    yyleng -= 2;
    yytext[yyleng] = '\0';
}

int main(){
    int i;
    while((i=yylex())){
        if(i==30){ //EOF
            printf("Token number:%d,value:\"SCANEOF\",line %d \n",i,line);
            printf("End of the execution\n");
            break;
        }else if(i==55){ //illegal
            printf("Line %d: %s is an illegal identifier.\n",line,yytext);
        }else{ // normal
            printf("Token number:%d,value:\"%s\",line %d.\n",i,yytext,line);
        }
    }
    return 0;
}
