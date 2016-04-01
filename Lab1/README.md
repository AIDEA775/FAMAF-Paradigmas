# Ale's Translation

## Las pruebas...
Para compilar:
`$ make`

Para ejecutar:
`$ bin/translator`


## Las ideas...
##### Nuestro main
En este proyecto decidimos usa argp para el pasaje de argumentos, ya que nos pareció mas completo y con un estilo mas GNU. Decidimos leer el archivo carácter por carácter así podemos respetar los espacios y caracteres especiales.

##### Nuestros TADS
Para traducir decidimos implementar el *`TAD dictionaries`* que es un conjunto de diccionarios. Un diccionario para las excepciones y otro con las traducciones, con la posibilidad de agregar mas idiomas. Para implementar los diccionarios, creamos el *`TAD dictionary`*, el cual nos permite agregar y buscar la traducción de una palabra. Para la busqueda de una palabra implementamos el *`TAD bst`*, para que sea mas eficiente ya que es log(n). Para la traducción de una palabra implementamos el *`TAD duo`*, que contiene la palabra y su traducción, los cuales no tiene limite de longitud porque si se usa con otros idiomas (diccionarios) no sabemos que longitud puede tener las palabras.

##### Nuestro reverse
Para implementar la función  *`reverse`*, decidimos que al momento de cargar el diccionario desde un archivo, lo hacemos en sentido contrario. En el caso del diccionario de excepciones, este se carga siempre en el mismo sentido, por lo que una palabra ignorada vale para todos los idiomas.

## Las otras ideas...
##### Nuestro scanf
Para leer la entrada estándar y los archivos usamos la función *`readline()`* implementada en *`helper.h`* porque lo usamos tanto en el *`main`* como *`diccionary`*.

##### Nuestro isalpha
Para detectar si un *`char`* es un carácter o una letra, existe una función de la librería estándar *`string`* llamada *`isalpha()`*. Pero esta no reconoce la **ñ** ni los **acentos**, por lo que la expandimos en nuestra función *`islatinapha()`* con un simple *or*.

##### Nuestro tolower
Al igual que isalpha, la función *`tolower()`* no devuelve la minúscula de una **Ñ** ó **É** por ejemplo, para expandirla usamos un string con letras en *mayusculas* y otro con las mismas letras en *minuscula* en el mismo orden. Si el carácter se encuentra en el string de *mayusculas*, devolvemos el carácter que está en la misma posición del arreglo de *minusculas*.

##### Nuestras minúsculas
Decidimos que la traducción sea toda en minúscula para no complicarnos, además, hasta google translate lo hace aveces.

##### Nuestro doble switch case
Para modularizar mas la busqueda de la traducción, decidimos que *`dics_search()`* sólo retorne si encontró o no la traducción y si hay que ignorarla. Si encontró la traducción, se la puede recuperar a través de *`get_translation()`*. Esto es para que eventualmente poder agregar mas funcionalidades, como un diccionario con insultos, lo cual debería censurarse con "\*\*\*\*\*".

##### Nuestro add save duo
Save duo se encarga de guardar en el archivo la palabra con su traducción, decidimos separarla de add duo para no modificar el *`TAD bst`*, ya que este solo modifica el árbol en memoria.

## Las ultimas ideas...
##### Nuestro ejemplo
Anexamos un texto muy interesante, un texto de pruebas y un diccionario de ejemplos, con ellos el traductor es de Español-Ingles.

##### Nuestros signos
En realidad no queriamos implementarlo, porque es un efoque muy particular de dos idiomas. Decidimos hacerlo lo mas simple posible, con **¿** funciona pero con **¡** no. Estamos seguros de que es por ASCII y que además supera las intenciones de este laboratorio, por eso lo dejamos como está.

### Esperemos que les gusten nuestra interfaz de usuario!
