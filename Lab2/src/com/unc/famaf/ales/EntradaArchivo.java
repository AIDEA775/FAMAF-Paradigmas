package com.unc.famaf.ales;

import java.io.*;

public class EntradaArchivo {
	static FileReader entrada = null;
	static int c;

	EntradaArchivo(String nombre) throws IOException {
		entrada = new FileReader(nombre);
		Scanner scanner = new Scanner(entrada);
		String auxstring = "" + scanner.next();
		br = new StringBuffer(auxstring); 
	}
	
	private boolean EsSimbolo(char c) {
		String s = "¡?,.?!¿";
		String aux = "" + c;
		boolean b = s.contains(aux);
		return (b);
	}

	public boolean FinalArchivo() {
		return scanner.hasNext();
	}
	
	public String LeerPalabra() throws IOException {
		String palabra = "";
		String signos = "";
		int n = br.length();
		if (n == 0) {
			auxstring = "" + scanner.next();
			br = br.append(auxstring); 
		}
       for (int i = 0; i < n; i++ ) {
         if (is_symbol(br.charAt(0)) && palabra == "") {
             auxsignos = auxsignos + br.charAt(0);
             br.delete(0,1);
         }else if(!is_symbol(br.charAt(0)) && auxsignos == ""){
            palabra = palabra + br.charAt(0);
             br.delete(0,1);
        }
        else if(is_symbol(br.charAt(0)) && palabra != ""){
             return palabra;
        }else if(!is_symbol(br.charAt(0)) && auxsignos != ""){
             return auxsignos;
        }
    }
    if (palabra != "") {
    	return palabra;
  
    } else if( auxsignos != ""){
    	return auxsignos;
    }
   }
}


}
