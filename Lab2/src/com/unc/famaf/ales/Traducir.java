package com.unc.famaf.ales;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Scanner;

// diccionario
public class Traducir {
	HashMap<String, String> diccionario;
	HashSet<String> ignoradas;
	boolean inverso;
	SalidaArchivo dic_archivo;
	SalidaArchivo ign_archivo;
	

	Traducir(String dic, String ign, boolean inverso) throws FileNotFoundException {
		this.diccionario = new HashMap<String, String>();
		this.ignoradas = new HashSet<String>();
		this.inverso = inverso;
		this.dic_archivo = new SalidaArchivo(dic);
		this.ign_archivo = new SalidaArchivo(ign);

		// Cargar diccionario
		Scanner d = new Scanner(dic).useDelimiter(",");
		while (d.hasNext()) {
			String palabra1 = d.next();
			String palabra2 = d.next();
			if (!inverso)
				diccionario.put(palabra1, palabra2);
			else
				diccionario.put(palabra2, palabra1);
		}
		d.close();

		// Cargar ignoradas
		Scanner i = new Scanner(ign);
		while (i.hasNext()) {
			ignoradas.add(i.next());
		}
		i.close();
	}

	public String TraducirPalabra(String palabra) {
		if (ignoradas.contains(palabra))
			return palabra;
		else
			return this.diccionario.get(palabra);
	}

	public void AgregarTraduccion(String palabra, String traduccion, boolean guardar) {
		diccionario.put(palabra, traduccion);
		if (guardar) {
			if (!this.inverso)
				this.dic_archivo.EscribirArchivo(palabra + "," + traduccion);
			else
				this.dic_archivo.EscribirArchivo(traduccion + "," + palabra);
		}
	}

	public void AgregarIgnorada(String palabra, boolean guardar) {
		ignoradas.add(palabra);
		if (guardar) {
			this.dic_archivo.EscribirArchivo(palabra + ",");
		}
	}
}
