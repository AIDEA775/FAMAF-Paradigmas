package com.unc.famaf.ales;

import java.io.*;

public class EntradaArchivo {
	static FileReader entrada = null;
	static int c;

	EntradaArchivo(String nombre) {
		try {
			entrada = new FileReader(nombre);
			c = entrada.read();
		} catch (IOException e) {
			// aca va el cuerpo del catch
		}
	}
	
	public static boolean EsSimbolo(char c) {
		String s = "¡?,.?!¿";
		String aux = "" + c;
		boolean b = s.contains(aux);
		return (b);
	}

	public static String LeerPalabra() throws IOException {
		char ch;
		String palabra = "";

		while (c != -1) {
			if ((char) c == ' ' && palabra != "") {

				c = entrada.read();
				return (palabra);

			} else if (EsSimbolo((char) c) && palabra == "") {

				ch = (char) c;
				palabra = palabra + ch;
				c = entrada.read();
				return (palabra);

			} else if (EsSimbolo((char) c) && palabra != "") {

				return (palabra);

			} else if ((char) c == ' ' || (char) c == '\n') {

				c = entrada.read();

			} else {

				ch = (char) c;
				palabra = palabra + ch;
				c = entrada.read();

			}
			if (c == -1 && palabra != "") {
				return (palabra);
			}
		}
		return palabra;
	}
}
