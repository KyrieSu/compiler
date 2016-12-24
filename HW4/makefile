target_name=net
cc=gcc

y.tab.o : net.y
	yacc -d ${target_name}.y
	${cc} -c y.tab.c -o y.tab.o

lex.yy.o : y.tab.h net.l
	flex ${target_name}.l
	${cc} -c lex.yy.c -o lex.yy.o

love : y.tab.o lex.yy.o
	${cc} y.tab.o lex.yy.o -o ${target_name} -ll

clean :
	rm y.tab.c y.tab.h  y.tab.o lex.yy.c lex.yy.o ${target_name}
