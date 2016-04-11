package com.unc.famaf.ales;

public class SalidaArchivo {
	FileWriter salida;
	SalidaArchivo(String nombre){
		try{
			salida = new FileWriter(nombre);
		}catch{
			//poner la excepcion
		}
	}
	public static void EscribirArchivo(String palabra){
		salida.write(palabra);
	}
}
