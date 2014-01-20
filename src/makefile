CC=gcc
FLAGS=-O2 -Wall
INCLUDE=CG.h SM.h ST.h
FLEXFILE=simple.l
BISONFILE=simple.y

simple:$(INCLUDE) bison_out lex.yy.c  
	$(CC) *.c   -o simple -lfl	 
	
bison_out:$(BISONFILE)
	bison -d $(BISONFILE)
	
lex.yy.c:$(FLEXFILE)
	flex $(FLEXFILE)
	
 
clean:
	rm  simple   lex.yy.c simple.tab.*
