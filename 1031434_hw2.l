%{
    #include <cstdio>
    #include <cstdlib>
    #define id 1
    #define integer_literal 2
    #define float_literal 3
    #define exp_float 4 //science exponential
    #define str 5
    #define comma 6
    #define semicolon 7
    #define left_parenthesis 8 //(
    #define left_parenthesis 9 //)

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
    #define end_while 22
    #define repeat_num 23
    #define repeatend_num 24
    #define declare_num 25
    #define as_num 26
    #define integer_num 27
    #define real_num 28
    #define bool_num 29
    #define scaneof 30

    /* operator */
    #define assignment 31 // =
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
    #define remain_ass 54 // %=
%}

/* Regular Expression */
Digit [0-9]
Letter [a-zA-Z]
IntLit {Digit}+
Id {Letter}({Letter}|{Digit}|_)*
%%
/* Rule action */




%%

void striquotes(){
    int frompos , topos = 0;
    for(frompos=1;frompos<yyleng;frompos++){
        yytext[topos++] = yytext[fromps];
    }
    yyleng -= 2;
    yytext[yyleng] = '\0';
}
