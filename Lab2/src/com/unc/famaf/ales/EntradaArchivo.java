package com.unc.famaf.ales;

import java.io.*;
import java.util.Scanner;

public class EntradaArchivo {
	static FileReader entrada = null;
	static int c;
	Scanner scanner;
	StringBuffer br;
	String lectura;

	EntradaArchivo(String nombre) throws IOException {
		entrada = new FileReader(nombre);
		scanner = new Scanner(entrada);
		String lectura = "" + scanner.next();
		br = new StringBuffer(lectura);
	}

	private boolean EsSimbolo(char c) {
		String s = "¡?,.?!¿;:{}]['|/#()=_-%$#";
		String aux = "" + c;
		boolean b = s.contains(aux);
		return (b);
	}

	public boolean Falta() {
		return scanner.hasNext();
	}

	public String LeerPalabra() throws IOException {
		String palabra = "";
		String signos = "";
		int n = br.length();
		if (n == 0) {
			lectura = "" + scanner.next();
			br = br.append(lectura);
		}
		for (int i = 0; i < n; i++) {
			if (EsSimbolo(br.charAt(0)) && palabra == "") {
				signos = signos + br.charAt(0);
				br.delete(0, 1);
			} else if (!EsSimbolo(br.charAt(0)) && signos == "") {
				palabra = palabra + br.charAt(0);
				br.delete(0, 1);
			} else if (EsSimbolo(br.charAt(0)) && palabra != "") {
				return palabra;
			} else if (!EsSimbolo(br.charAt(0)) && signos != "") {
				return signos;
			}
		}
		if (palabra != "") {
			return palabra;

		} else if (signos != "") {
			return signos;
		}
		return "";
	}
}
