#guerra funcional en OCAML

##cartas
Para comenzar (aparte de los mani y la cervaza para la juntada con amigos a jugar) definimos el tipo de cartas y carta, donde carta es una tupla (string,int) y cartas es una lista de carta.
cartas es la encargada de administrar el mazo (mezclarlo, repartirlo etc) y de que cada jugador tenga
las cartas que le corresponden. Creamos un mazo que contiene todas las cartas tanto especiales como cartas comunes
ese mazo es mezclado por la funcion mazo completo y administrado por las demas.

##Varios

##Jugador
Una vez 

##Mesa
Necesitamos una mesa donde sentar a los jugadores no?. En la mesa estan las funciones "principales" con respecto al reparto del juego.
Teniendo el record mesa que contiene, la lista de jugadores y el mazo general a partir de ahi s e deciden cuantos jugadores va a haber, las cartas que se jugo en esa ronda, el ganador de la ronda, y el "ESTADO" actual de la mesa.

guerra funcional
ya teniendo todo los elementos para jugar, solo necesitamos iniciar y de eso se encarga guerra funcional. Guerra funcional es el anfitrion de la fiesta se encarga de crear la mesa, registrar a los jugadores, decir quien es el ganador de cada ronda y de que el juego no se termine hasta que un jugador no haya ganado.

##Decisiones
funcion carta_of_string
##Ideas

###Bibliografia y/o paginas de consulta

Libros: Copying and pasting from Stack Overflow
	    Real World Ocml

Webs: https://ocaml.org/learn/tutorials/99problems.html
      http://stackoverflow.com

##SORPRESA!!!
si usted alguna vez jugo mortal kombat y sabia los trucos, como a b arriba b arriba b a abajo (para desbloquear jugadores motaro, shao khan, 99 credits mortal kombat ultimate 3 (SEGA)) bueno usted es de los nuestros, aunque pedimos 12 horas para poder entregar este LAB, no podiamos dejar pasar esta oportunidad!! si es lo que esta pensando nos dimos el lujo de poner un comando secreto. Para ver esta sorpresa cuando el juego le pida el nombre de un jugador ingrese "los ales tienen 10" fijese con confianza!! que lo disfrute!!!

