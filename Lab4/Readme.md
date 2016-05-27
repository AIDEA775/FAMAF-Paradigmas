# LAB 4: APIs
## AleRSS

**El nombre de nuestro proyecto es una concatenacion de nuestros nombres y e
tipo de feed RSS.**

### La primera impresión
Partimos del ejemplo (pastebin) que dejó Cristian, a partir de ahí agregamos cosas hasta que el **AleRSS** comenzó a andar solo con la autenticacion a traves de github. Luego tuvimos que refactorizar el Auth para soportar mas proveedores (clase SignIn). Tambien nos entretuvimos mucho tiempo jugando con el HTML, jQuery y JavaScrip, por lo que cambiamos muchas cosas.

### El autenticador
Implementamos la clase **SignIn** con los metodos `login()`, `callback()` y `get_provider()` para usarlos desde *runserver.py* independientemente del proveedor.

Definimos una clase que hereda de `SignIn` por cada proveedor y redefinimos metodos en caso que necesitemos. Definimos objetos `oauth` con los parametros necesarios para cada proveedor.

Los objetos `oauth` en general requieren una `consumer_key` y `consumer_secret` 

Tambien definimos los `tokengetter` que no sabemos que hace, y si un usuario quiere ingresar a una pag que no tiene permisos, levantamos un abort con el codigo 404.


### Corre server corre
En runserver el controlador de la vista modelos, a grande rasgos aca vamos a manejar todas las solicitudes del usuario (http get).

Algunas de estos metodos necesita login_required para proteger la privacidad de los usuarios ya registrados y para que los usuarios no registrados no puedan leer feeds. Ademas tenemos metodos para crear, eliminar y mostrar feed y un metodo que captura el error 404 para renderear nuestra pantalla de not found personalizada.

### El sencillo
Creamos la aplicacion flask, configuramos la aplicacion flask a travez del archivo setting previamente importado. Definimos la base de datos.

### Los intactos
Setting y models.


### Decisiones
No nos gusto el boton de eliminar y lo cambiamos por una cruz. Para ser mas cool cambiamos el `logut` y el `home` por iconos para que sean mas representaivos y que no dependa del idioma.

### Ahora somos del club DEVs
Para crear las apis de gthub, github y dropbox. Nos registramos como desarrolladores en respectivas paginas luego leimos la documentacion que nos brindaba cada pagina. Con los datos que nos dieron cuando la creamos (como key, id, etc) llenamos el objeto que esta en el codigo.

### Tambien somos miembros de testers
Testeamos lo mas que pudimos la interfaz, haciendo mas de dos clics a todo
(literalmente) y encontramos bugs pero lo solucionamos con `.finish()` para
limpiar todas las animaciones pendientes.


### Inspiracion
Copypastear todo el codigo que encontramos en stackoverflow, ejemplos en github
en la documentacion oficial.

### Justo lo necesario
No usamos mas librerias de las que propuso la catedra.
