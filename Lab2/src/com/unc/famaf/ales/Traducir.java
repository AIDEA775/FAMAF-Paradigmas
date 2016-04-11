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
	SalidaArchivo dicArchivo;
	SalidaArchivo ignArchivo;
	

	Traducir(String dic, String ign, boolean inverso) throws FileNotFoundException {
		this.diccionario = new HashMap<String, String>();
		this.ignoradas = new HashSet<String>();
		this.inverso = inverso;
		this.dicArchivo = new SalidaArchivo(dic);
		this.ignArchivo = new SalidaArchivo(ign);

		// Cargar diccionario
		Scanner d = new Scanner(new File(dic));
		while (d.hasNextLine()) {
			Scanner dicPar = new Scanner(d.nextLine());
			dicPar.useDelimiter(",");
				String palabra1 = dicPar.next();
				String palabra2 = dicPar.next();
			if (!inverso)
				diccionario.put(palabra1, palabra2);
			else
				diccionario.put(palabra2, palabra1);
			dicPar.close();
		}
		d.close();

		// Cargar ignoradas
		Scanner i = new Scanner(new File(ign));
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
				this.dicArchivo.EscribirArchivo(palabra + "," + traduccion);
			else
				this.dicArchivo.EscribirArchivo(traduccion + "," + palabra);
		}
	}

	public void AgregarIgnorada(String palabra, boolean guardar) {
		ignoradas.add(palabra);
		if (guardar) {
			this.ignArchivo.EscribirArchivo(palabra);
		}
	}
	
	public void CerrarDiccionario() {
		this.dicArchivo.CerrarArchivo();
		this.ignArchivo.CerrarArchivo();
	}
	
	public static void main(String[] args) {
		Traducir hola;
		try {
		hola = new Traducir("/home/aidea775/dic.txt", "/home/aidea775/ign.txt", false);
		//hola.AgregarTraduccion("hey", "Hey", true);
		//hola.AgregarIgnorada("tumama", true);
		System.out.println(hola.TraducirPalabra("hey"));
		hola.CerrarDiccionario();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}

		
	}
}
