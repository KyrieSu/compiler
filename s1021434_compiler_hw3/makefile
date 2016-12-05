y.tab.o : cal.y
	yacc -d cal.y
	gcc -c y.tab.c -o y.tab.o

lex.yy.o : y.tab.h cal.l
	flex cal.l
	gcc -c lex.yy.c -o lex.yy.o

love : y.tab.o lex.yy.o
	gcc y.tab.o lex.yy.o -o yacc -ll

run : ./yacc
	./yacc < test
clean :
	rm y.tab.c y.tab.h  y.tab.o ./yacc
