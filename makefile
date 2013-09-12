parla.tab.c parla.tab.h: parla.y
	bison -y -d parla.y

lex.yy.c: parla.l parla.tab.h
	flex parla.l

clean: 
	rm lex.yy.c y.tab.c y.tab.h parla.tab.c parla.tab.h parla

parla: lex.yy.c parla.tab.c parla.tab.h
	gcc lex.yy.c y.tab.c main.c -o parla

