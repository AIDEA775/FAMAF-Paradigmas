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

	Traductor(String dic, String ign, String fuente, String salida, boolean reversa) throws IOException {
		this.fuente = new EntradaArchivo(fuente);
		this.salida = new SalidaArchivo(salida);
		this.traductor = new Traducir(dic, ign, reversa);
	}

	private void ImprimirInterfaz(String palabra) {
		System.out.println(this.interfaz);
	}

	private String ParsearOpcion(String palabra) throws IOException {
		Scanner s = new Scanner(System.in);
		String resultado = palabra;
		boolean reintentar;
		do {
			reintentar = false;
			switch (s.next()) {
			case "i":
				System.out.println(String.format(">>> Ignorar *%s* en este documento...", palabra));
				this.traductor.AgregarIgnorada(palabra, false);
				break;
			case "h":
				System.out.println(String.format(">>> Ignorar *%s* siempre...", palabra));
				this.traductor.AgregarIgnorada(palabra, true);
				break;
			case "t":
				System.out.print(String.format(">>> Traducir *%s* en este documento como: ", palabra));
				resultado = s.next();
				this.traductor.AgregarTraduccion(palabra, resultado, false);
				break;
			case "s":
				System.out.print(String.format(">>> Traducir siempre *%s* como: ", palabra));
				resultado = s.next();
				this.traductor.AgregarTraduccion(palabra, resultado, true);
				break;
			default:
				System.out.print(">>> Lo siento, intente de nuevo: ");
				reintentar = true;
				break;
			}
		} while (reintentar);
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
		this.fuente.CerrarArchivo();
		this.traductor.CerrarDiccionario();
	}

}