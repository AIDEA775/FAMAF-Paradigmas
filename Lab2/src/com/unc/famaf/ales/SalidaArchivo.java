package com.unc.famaf.ales;

import java.io.FileWriter;
import java.io.IOException;

public class SalidaArchivo {
	FileWriter salida;

	SalidaArchivo(String nombre) throws IOException {
		salida = new FileWriter(nombre, true);

	}

	public void EscribirArchivo(String palabra) throws IOException {
		salida.write(palabra + "\n");
	}
	
	public void CerrarArchivo() {
		try {
			salida.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
