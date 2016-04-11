package com.unc.famaf.ales;

import java.io.FileWriter;
import java.io.IOException;

public class SalidaArchivo {
	FileWriter salida;

	SalidaArchivo(String nombre){
		try {
			salida = new FileWriter(nombre, true);
		} catch (IOException e){
			e.printStackTrace();
		}
	}

	public void EscribirArchivo(String palabra) {
		try {
			salida.write(palabra + "\n");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void CerrarArchivo() {
		try {
			salida.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
