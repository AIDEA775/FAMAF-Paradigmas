FLAGS = -g -Wall -Werror -pedantic -std=c99
OBJETOS = main.o dictionaries.o dictionary.o bst.o duo.o

translator : $(OBJETOS)
	gcc $(FLAGS) -o translator $(OBJETOS) 

main.o : main.c dictionaries.h
	gcc $(FLAGS) -c main.c

dictionaries.o : dictionaries.c dictionary.h
	gcc $(FLAGS) -c dictionaries.c

dictionary.o : dictionary.c bst.h duo.h
	gcc $(FLAGS) -c dictionary.c

duo.o : duo.c
	gcc $(FLAGS) -c duo.c

clean :
		rm translator $(OBJETOS)
