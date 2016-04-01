# Ale's Translation

## Las pruebas...
Para compilar:  
`$ make`

Para ejecutar:  
`$ bin/translator`


## Las ideas...
##### Nuestro main
En este proyecto decidimos usa argp para el pasaje de argumentos, ya que nos pareció  mas completo y con un estilo mas GNU. Decidimos leer el archivo caracter por caracter asi podemos respetar los espacios y caracteres especiales.

##### Nuestros TADS
Para traducir decidimos implementar el *`TAD dictionaries`* que es un conjunto de diccionarios. Un diccionario para las excepciones y otro con las traducciones, con la posibilidad de agregar mas idiomas. Para implementar los diccionarios, creamos el *`TAD dictionary`*, el cual nos permite agregar y buscar la traduccion de una palabra. Para la busqueda de una palabra implementamos el *`TAD bst`*, para que sea mas eficiente ya que es log(n). Para la traduccion de una palabra implementamos el *`TAD duo`*, que contiene la palabra y su traduccion, los cuales no tiene limite de longitud porque si se usa con otros idiomas (diccionarios) no sabemos que longitud puede tener las palabras.

## Las otras ideas...
##### Nuestro scanf
Para leer la entrada estandar y los archivos usamos la funcion *`readline()`* implementada en *`helper.h`* porque lo usamos tanto en el *`main`* como *`diccionary`*.

##### Nuestro isalpha
Para detectar si un *`char`* es un caracter o una letra, existe una funcion de la libreria estandar *`string`* llamada *`isalpha()`*. Pero esta no reconoce la **ñ** ni los **acentos**, por lo que la expandimos en nuestra funcion *`islatinapha()`* con un simple *or*.

##### Nuestro tolower
Al igual que isalpha, la funcion *`tolower()`* no devulve la minuscula de una **Ñ** ó **É** por ejemplo, para expandirla usamos un string con letras en *mayusculas* y otro con las mismas letras en *minuscula* en el mismo orden. Si el caracter se encuentra en el string de *mayusculas*, devolvemos el caracter que está en la misma posicion del arreglo de *minusculas*.

##### Nuestras minusculas
Decidimos que la traduccion sea toda en minuscula para no complicarnos, ademas, hasta google translate lo hace aveces.

##### Nuestro doble switch case
Para modularizar mas la busqueda de la traduccion, decidimos que *`dics_search()`* sólo retorne si encontró o no la traduccion y si hay que ignorarla. Si encontró la traduccion, se la puede recuperar a través de *`get_translation()`*. Esto es para que eventualmente poder agregar mas funcionalidades, como un diccionario con insultos, lo cual deberia censurarse con "\*\*\*\*\*".

##### Nuestro add save duo
Save duo se encarga de guardar en el archivo la palabra con su traducción, decidimos separarla de add duo para no modificar el *`TAD bst`*, ya que este solo modifica el árbol en memoria.
