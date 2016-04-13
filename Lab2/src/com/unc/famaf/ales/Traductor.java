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
		System.out.println("No encontre la traduccion de " + palabra);
		System.out.println("Ya sabes las opciones, sinó primero usa la version escrita en C");
	}

	private void ParsearOpcion() {
		Scanner s = new Scanner(System.in);
		switch (s.next()) {
		case "a":
			break;
		case "s":
			break;
		default:
			break;
		}
		s.close();
	}
	
	public void traduce() throws IOException {
		String palabra;		
		while (true) {
			palabra = this.traductor.TraducirPalabra(this.fuente.LeerPalabra());
			if (palabra == null) {
				this.ImprimirInterfaz(palabra);
				this.ParsearOpcion();
			} else {
				this.salida.EscribirArchivo(palabra);
			}
		}
	}

	public static void main(String[] args) {
		Traductor hola;
		try {
			hola = new Traductor("/home/aidea775/dic.txt", "/home/aidea775/ign.txt", "/home/aidea/text.txt", "/home/aidea/traduc.txt", false);
			hola.traduce();
		} catch (IOException e) {
			e.printStackTrace();
		}
	
	}
}