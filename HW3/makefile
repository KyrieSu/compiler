y.tab.o : cal.y
	yacc -d cal.y
	gcc -c y.tab.c -o y.tab.o

lex.yy.o : y.tab.h cal.l
	flex cal.l
	gcc -c lex.yy.c -o lex.yy.o

love : y.tab.o lex.yy.o
	gcc y.tab.o lex.yy.o -o yacc -ll

clean :
	rm y.tab.c y.tab.h  y.tab.o lex.yy.c lex.yy.o ./yacc
