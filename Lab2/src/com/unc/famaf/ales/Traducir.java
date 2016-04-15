package com.unc.famaf.ales;

import java.io.File;
import java.io.IOException;
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

	Traducir(String dic, String ign, boolean inverso) throws IOException {
		this.diccionario = new HashMap<String, String>();
		this.ignoradas = new HashSet<String>();
		this.inverso = inverso;
		this.dicArchivo = new SalidaArchivo(dic, true);
		this.ignArchivo = new SalidaArchivo(ign, true);

		// Cargar traducciones
		Scanner st = new Scanner(new File(dic));
		while (st.hasNextLine()) {
			Scanner dicPar = new Scanner(st.nextLine());
			dicPar.useDelimiter(",");
			String palabra1 = dicPar.next();
			String palabra2 = dicPar.next();
			if (!inverso)
				diccionario.put(palabra1, palabra2);
			else
				diccionario.put(palabra2, palabra1);
			dicPar.close();
		}
		st.close();

		// Cargar ignoradas
		Scanner si = new Scanner(new File(ign));
		while (si.hasNext()) {
			ignoradas.add(si.next());
		}
		si.close();
	}

	public String TraducirPalabra(String palabra) {
		if (ignoradas.contains(palabra))
			return palabra;
		else
			return this.diccionario.get(palabra);
	}

	public void AgregarTraduccion(String palabra, String traduccion, boolean guardar) throws IOException {
		diccionario.put(palabra, traduccion);
		if (guardar) {
			if (!this.inverso)
				this.dicArchivo.EscribirArchivo(palabra + "," + traduccion + "\n");
			else
				this.dicArchivo.EscribirArchivo(traduccion + "," + palabra + "\n");
		}
	}

	public void AgregarIgnorada(String palabra, boolean guardar) throws IOException {
		ignoradas.add(palabra);
		if (guardar) {
			this.ignArchivo.EscribirArchivo(palabra + "\n");
		}
	}

	public void CerrarDiccionario() throws IOException {
		this.dicArchivo.CerrarArchivo();
		this.ignArchivo.CerrarArchivo();
	}
}
