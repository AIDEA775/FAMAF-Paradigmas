# **Ales-Traductor**
*(Ahora multiplataforma)*


## Nuestras cosas (Objetos)
##### El inicio (Main.java)
Decidimos tener una clase solo para el parser, para ello usamos la librería JSAP porque nos pareció la mas fácil y simple.
Luego de parsear, llamamos al método Traduce de la clase Traductor.


#### La central (Traductor.java)
Acá tenemos el ciclo principal del traductor. Leemos una palabra de la fuente (con la clase **EntradaArchivo**), buscamos una traducción (con la clase **Traducir**), y escribimos la traducción en el archivo de salida (con la clase **SalidaArchivo**).

En caso de que no se encuentre traducción, llamamos al método **ParsearOpcion()** que se encarga de imprimir la interfaz y manejar la opción del usuario.

Chequeamos con el regex **[\p{L}]+** si la palabra en realidad son símbolos, para no traducirla y escribirla directamente.

Tuvimos que armar un método para cerrar todos los archivos sino los datos no se guardaban a disco.


#### La puerta de bienvenida (EntradaArchivo.java)
En esta clase leemos desde el archivo fuente y devolvemos palabra por palabra por el metodo **LeerPalabra()**.

Decidimos separar las palabras de los símbolos. Usamos scanner para separar las palabras por espacios pero estas contienen letras y símbolos. Entonces recorremos la palabra carácter por carácter y devolvemos la primera parte, ya sea símbolo o carácter y el resto lo guardamos en un buffer.

Para diferenciar entre símbolos y caracteres utilizamos la función **EsSimbolo()** que usa la función matches con el regex **[\p{L}]+**.

#### La puerta de salida (SalidaArchivo.java)
Decidimos que esta clase escriba la palabra que le pasamos tal cual en el archivo de salida.

#### La biblioteca (Traducir.java)
Decidimos usar una **HashMap** para lar palabras con traducción, y un **HashSet** para las palabras ignoradas.

Para las traducción, armamos la HashMap según el sentido de la traducción, por lo que solo debemos indexar la palabra a traducir para obtener la traducción. Cosa que para las ignoradas no hay problema.

Implementamos el método **TraducirPalabra()** que devuelve la traducción si no esta dentro de las ignoradas.

Dos metodos mas para agregar traducciones y palabras ignoradas. En el caso de las traducciones, escribimos en el archivo según el sentido de la traducción en el que estamos traduciendo.


## Nuestras ocurrencias
#### Interfaz
Mejoramos la interfaz copiando los `>>>` de python.

#### Guardando traducciones
Cuando estamos en el sentido Español->Ingles, levantamos el diccionario tal cual y lo mismo para guardar traduciones (Español,Ingles).

Cuando estamos en el sentido opuesto Ingles->Español, como cargamos el diccionario en sentido contrario, en memoria tenemos traduciones Ingles,Español. Por lo que al guardar en disco una traduccion nueva, debemos invertir la traduccion para guardar correctamente Español,Ingles.

#### Los albañiles (Constructores)

Para los constructores de las clases que abren archivos, decidimos implementar ""destructores"" que cierran los archivos para que se guarden los cambios a disco.

#### La dinamita (Excepciones)
Decidimos que cualquier excepcion que se produzca leyendo o escribiendo archivos, van a ser capturadas por el Main, para interrumpir el proceso ya que no hay forma de recuperarse.


#### El terreno (IDE)
Usamos Eclipse y `Source > Format` para corregir el estilo de codigo.


#### El capataz (makefile)
Unas de las cosas mas dificiles del proyecto nos fue armar el makefile, pero lo logramos:

Para compilar los .java:

`$ make`

Para compilar un .jar con la librería linkeada:

`$ make`  
`$ make jar`

Para compilar a un .jar con la librería incluida:

`$ make`  
`$ make pack`


### Como siempre, agregamos un texto muy interesante de ejemplo y uno de prueba. Disfrute la lectura
