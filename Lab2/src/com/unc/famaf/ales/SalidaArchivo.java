package com.unc.famaf.ales;

import java.io.FileWriter;
import java.io.IOException;

public class SalidaArchivo {
	FileWriter salida;

	SalidaArchivo(String nombre) throws IOException {
		salida = new FileWriter(nombre);
	}

	SalidaArchivo(String nombre, boolean agregar) throws IOException {
		salida = new FileWriter(nombre, agregar);
	}

	public void EscribirArchivo(String palabra) throws IOException {
		salida.write(palabra + "\n");
	}

	public void CerrarArchivo() throws IOException {
		salida.close();
	}
}
