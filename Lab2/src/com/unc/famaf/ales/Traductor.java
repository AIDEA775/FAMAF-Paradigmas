package com.unc.famaf.ales;

import java.io.IOException;
import java.util.Scanner;

public class Traductor {
	String interfaz = "\n\nIgnorar (i) - Ignorar Todas (h) - " +
					"Traducir como (t) - Traducir siempre como (s)\n" +
					">>> No encontre la traduccion de %s\n" +
					">>> Su opcion: ";
	Traducir traductor;
	EntradaArchivo fuente;
	SalidaArchivo salida;
	Scanner s;

	Traductor(String dic, String ign, String fuente, String salida, boolean reversa) throws IOException {
		this.fuente = new EntradaArchivo(fuente);
		this.salida = new SalidaArchivo(salida);
		this.traductor = new Traducir(dic, ign, reversa);
		s = new Scanner(System.in);
	}

	private String ParsearOpcion(String palabra) throws IOException {
		String resultado = palabra;
		boolean reintentar;
		System.out.format(this.interfaz, palabra);
		do {
			reintentar = false;
			switch (this.s.next()) {
			case "i":
				System.out.format(">>> Ignorar %s en este documento...", palabra);
				this.traductor.AgregarIgnorada(palabra, false);
				break;
			case "h":
				System.out.format(">>> Ignorar %s siempre...", palabra);
				this.traductor.AgregarIgnorada(palabra, true);
				break;
			case "t":
				System.out.format(">>> Traducir %s en este documento como: ", palabra);
				resultado = s.next();
				this.traductor.AgregarTraduccion(palabra, resultado, false);
				break;
			case "s":
				System.out.format(">>> Traducir siempre %s como: ", palabra);
				resultado = s.next();
				this.traductor.AgregarTraduccion(palabra, resultado, true);
				break;
			default:
				System.out.print(">>> Lo siento, intente de nuevo: ");
				reintentar = true;
				break;
			}
		} while (reintentar);
		return resultado;
	}

	public void Traduce() throws IOException {
		String palabra;
		String traduccion;

		while (this.fuente.Falta()) {
			palabra = this.fuente.LeerPalabra();
			if (palabra.matches("[\\p{L}]+")) {
				System.out.println("es letra");
				traduccion = traductor.TraducirPalabra(palabra);
				if (traduccion == null)
					traduccion = this.ParsearOpcion(palabra);
			} else {
				traduccion = palabra;
			}
			this.salida.EscribirArchivo(traduccion + " ");
		}
	}

	public void Limpiar() throws IOException {
		this.salida.CerrarArchivo();
		this.fuente.CerrarArchivo();
		this.traductor.CerrarDiccionario();
		this.s.close();
	}

}