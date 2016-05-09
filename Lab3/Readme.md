# Guerra Funcional en OCAML

## Cartas
Para comenzar definimos el tipo de cartas y carta, donde carta es una tupla (string,int) y cartas es una lista de carta.
cartas es la encargada de administrar el mazo (mezclarlo, repartirlo etc) y de que cada jugador tenga
las cartas que le corresponden. Creamos un mazo que contiene todas las cartas tanto especiales como cartas comunes
ese mazo es mezclado por la funcion mazo completo y administrado por las demas.

## Varios
En este modulo recolectamos varias funciones sobre la lectura de la stdin, con respecto a la interfaz y algunas funciones poliformicas.


## Jugador
Jugador es un record con su nombre, puntos, carta jugada y cartas en la mano. Implementamos varias funciones para consultar datos para mantener la abstraccion.

La funcion mas importante es `jugador_juega()`: lee la std hasta que el jugador ingresa una carta valida, dependiendo del tipo de carta (especial o comun) llama a `jugar_comun()` o `jugar_especial()` respectivamente. Devolvemos el nuevo jugador y el nuevo mazo general.


## Mesa

Necesitamos una mesa donde sentar a los jugadores no?. En la mesa estan las funciones "principales" con respecto al reparto del juego.
El record mesa contiene la lista de jugadores y el mazo general a partir de ahi se decide que jugadores van a jugar, las cartas jugadas en esa ronda, el ganador de la ronda, y el "*ESTADO*" actual de la mesa.

## La guerra

Ya teniendo todo los elementos para jugar, solo necesitamos iniciar y de eso se encarga guerra funcional. Guerra funcional es el anfitrion de la fiesta se encarga de crear la mesa, registrar a los jugadores, decir quien es el ganador de cada ronda y de que el juego no se termine hasta que un jugador no haya ganado.

## Decisiones
* La funcion `carta_of_string()` agregamos un parametro extra `cs` para que devuelva una carta si y solo si está dentro de `cs`.

* Implementamos las cartas especiales como un palo mas dentro del mazo general `("S", int)` donde int es un numero que representa una carta especial y hacemos la tranformacion con las funciones internas `especial()`.

* Las cartas especiales no se consideran para la comparacion de cartas, es decir: **SPAR** **SMAX** **SMIN**.

* Caso borde con MAX (y MIN), en caso de no encontrar una carta en el mazo general es porque no quedan cartas comunes. Por lo tanto se vuelve a jugar.

* Al principio de `jugar()` preguntamos si el jugador juega una carta especial y esta era su ultima carta.

### Bibliografia y/o paginas de consulta

Libros:

Copying and pasting from Stack Overflow

Webs:

https://ocaml.org/learn/tutorials/99problems.html


http://stackoverflow.com

## Easter Egg!!!
Si usted alguna vez jugo mortal kombat y sabia los trucos, como a b arriba b arriba b a abajo (para desbloquear jugadores motaro, shao khan, 99 credits mortal kombat ultimate 3 (SEGA)) bueno usted es de los nuestros, aunque pedimos 12 horas para poder entregar este LAB, no podiamos dejar pasar esta oportunidad!! si es lo que esta pensando nos dimos el lujo de poner un comando secreto. Para ver esta sorpresa cuando el juego le pida el nombre de un jugador ingrese la respuesta de este acertijo: "`es una letra griega y compañero suyo`"

### Que lo disfrute!!!
