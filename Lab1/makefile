FLAGS = -g -Wall -Werror -pedantic -std=c99
SRC = src/
BIN = bin/
OBJECTS = $(BIN)main.o $(BIN)dictionaries.o $(BIN)dictionary.o $(BIN)duo.o $(BIN)bst.o $(BIN)helper.o

translator : $(OBJECTS)
	gcc $(FLAGS) -o $(BIN)translator $(OBJECTS)

$(BIN)main.o : $(SRC)main.c $(SRC)dictionaries.h
	gcc $(FLAGS) -o $(BIN)main.o -c $(SRC)main.c

$(BIN)dictionaries.o : $(SRC)dictionaries.c $(SRC)dictionary.h
	gcc $(FLAGS) -o $(BIN)dictionaries.o -c $(SRC)dictionaries.c

$(BIN)dictionary.o : $(SRC)dictionary.c $(SRC)bst.h $(SRC)duo.h
	gcc $(FLAGS) -o $(BIN)dictionary.o -c $(SRC)dictionary.c

$(BIN)duo.o : $(SRC)duo.c
	gcc $(FLAGS) -o $(BIN)duo.o -c $(SRC)duo.c

$(BIN)bst.o : $(SRC)bst.c
	gcc $(FLAGS) -o $(BIN)bst.o -c $(SRC)bst.c

$(BIN)helper.o : $(SRC)helper.c
	gcc $(FLAGS) -o $(BIN)helper.o -c $(SRC)helper.c

clean :
		rm $(BIN)translator $(OBJECTS)
