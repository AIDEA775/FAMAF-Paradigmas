#Correcciones Lab 1:

##General:
	* Buen funcionamiento general del sistema.
	* Traducciones correctas
	* Argumentos y opciones implementadas correctamente
	* Parseo correcto

##Errores de diseño:
	* Los TADs implementados no representan correctamente la informacion, se deberia haber implementado una lista de manera separada. En general, no es un buen camino implementar un TAD que encapsula mas de una funcionalidad (su diccionario que puede "mutar" en lista).
	* Si no se utiliza el argumento '-o', no estan retornando la traduccion mediante ningun canal.
##Errores de implementacion
	* Al utilizar '-r', se guardan palabras invertidas en el diccionario. 
	* Utilizaron un goto para modificar el flow del menu. Hay que evitar el uso de goto en general.

##NOTA: 8
