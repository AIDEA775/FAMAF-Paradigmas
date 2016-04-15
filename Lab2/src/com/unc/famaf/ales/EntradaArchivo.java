package com.unc.famaf.ales;

import java.io.*;
import java.util.Scanner;

public class EntradaArchivo {
	FileReader entrada;
	Scanner scanner;
	StringBuffer br;

	EntradaArchivo(String nombre) throws IOException {
		entrada = new FileReader(nombre);
		scanner = new Scanner(entrada);
		br = new StringBuffer(scanner.next());
	}

	private boolean EsSimbolo(char c) {
		String s = "" + c;
		return !s.matches("[\\p{L}]");
	}

	public static boolean EsLetras(String s) {
		return s.matches("[\\p{L}]");
	}
	
	public boolean Falta() {
		return scanner.hasNext() || br.length() != 0;
	}

	public String LeerPalabra() throws IOException {
		String palabra = "";
		boolean tipo;

		int n = br.length();
		if (n == 0) {
			br.append(scanner.next());
			n = br.length();
		}
		tipo = EsSimbolo(br.charAt(0));
		int i;
		for (i = 0; i < n && (tipo == EsSimbolo(br.charAt(i))); i++) {
			palabra += br.charAt(i);
		}
		br.delete(0, i);
		return palabra.toLowerCase();
	}

	public void CerrarArchivo() throws IOException {
		this.scanner.close();
		this.entrada.close();
	}
}
