package com.unc.famaf.ales;

import java.io.IOException;
import java.util.Scanner;

public class Traductor {
	Traducir traductor;
	EntradaArchivo fuente;
	SalidaArchivo salida;
	
	Traductor(String dic, String ign, String fuente, String salida, boolean reversa) throws IOException {
		this.fuente = new EntradaArchivo(fuente);
		this.salida = new SalidaArchivo(salida);
		this.traductor = new Traducir(dic, ign, reversa);
	}

	private void ImprimirInterfaz(String palabra) {
		System.out.println("\n\nIgnorar (i) - Ignorar Todas (h) - Traducir como (t) - Traducir siempre como (s)");
		System.out.println(">>> No encontre la traduccion de " + palabra);
		System.out.println(">>> Su opcion: ");
	}

	private String ParsearOpcion(String palabra) throws IOException {
		Scanner s = new Scanner(System.in);
		String resultado = palabra;
		reintentar:
		switch (s.next()) {
		case "i":
			System.out.println(">>> Ignorar *" + palabra + "* en este documento...");
			this.traductor.AgregarIgnorada(palabra, false);
			break;
		case "h":
			System.out.println(">>> Ignorar *" + palabra + "* siempre...");
			this.traductor.AgregarIgnorada(palabra, true);
			break;
		case "t":
			System.out.print(">>> Traducir *" + palabra + "* en este documento como: ");
			resultado = s.next();
			this.traductor.AgregarTraduccion(palabra, resultado, false);
			break;
		case "s":
			System.out.print(">>> Traducir siempre *" + palabra + "* como: ");
			resultado = s.next();
			this.traductor.AgregarTraduccion(palabra, resultado, true);
			break;
		default:
			System.out.print(">>> Lo siento, intente de nuevo: ");
			break reintentar;
		}
		s.close();
		return resultado;
	}
	
	public void Traduce() throws IOException {
		String palabra;		
		while (this.fuente.Falta()) {
			palabra = this.traductor.TraducirPalabra(this.fuente.LeerPalabra());
			if (palabra == null) {
				this.ImprimirInterfaz(palabra);
				palabra = this.ParsearOpcion(palabra);
			}
			this.salida.EscribirArchivo(palabra);
		}
	}
	
	public void Limpiar() throws IOException {
		this.salida.CerrarArchivo();
		this.traductor.CerrarDiccionario();
	}

	public static void main(String[] args) {
		Traductor hola;
		try {
			hola = new Traductor("dic.txt", "ign.txt", "text.txt", "trad.txt", false);
			hola.Traduce();
			hola.Limpiar();
		} catch (IOException e) {
			e.printStackTrace();
		}
	
	}
}