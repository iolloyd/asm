functions : functions.o
	ld functions.o -o functions

functions.o : functions.s
	as functions.s -o functions.o 
