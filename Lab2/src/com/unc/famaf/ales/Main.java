package com.unc.famaf.ales;

import java.io.IOException;

import com.martiansoftware.jsap.*;

public class Main {

    public static void main(String[] args) throws Exception {
        JSAP jsap = new JSAP();
        Traductor traductor;
        
        FlaggedOption opt1 = new FlaggedOption("diccionario")
                                .setStringParser(JSAP.STRING_PARSER)
                                .setDefault("diccionario.txt") 
                                .setRequired(false) 
                                .setShortFlag('d'); 

        opt1.setHelp("Ingrese un diccionario");
        jsap.registerParameter(opt1);
        
        FlaggedOption opt2 = new FlaggedOption("ignoradas")
                                 .setStringParser(JSAP.STRING_PARSER)
                                 .setDefault("ignoradas.txt")
                                 .setRequired(false)
                                 .setShortFlag('i');

        opt2.setHelp("Ingrese un diccionario de palabras ignoradas");
        jsap.registerParameter(opt2);

        FlaggedOption opt3 = new FlaggedOption("entrada")
                                .setStringParser(JSAP.STRING_PARSER)
                                .setRequired(true)
                                .setShortFlag('e');

        opt3.setHelp("Ingrese un archivo a traducir existente");
        jsap.registerParameter(opt3);

        FlaggedOption opt4 = new FlaggedOption("salida")
                                 .setStringParser(JSAP.STRING_PARSER)
                                 .setDefault("salida.txt")
                                 .setRequired(false)
                                 .setShortFlag('i');

        opt4.setHelp("Traducir de ingles a español");
        jsap.registerParameter(opt4);

        Switch opt5 = new Switch("reversa")
                        .setShortFlag('r');

        opt5.setHelp("Traducir de ingles a español");
        jsap.registerParameter(opt5); 

        JSAPResult config = jsap.parse(args);    
 
        if (!config.success()) {
            System.err.println();
            System.err.println("Usage: java ");
            System.err.println("                " + jsap.getUsage());
            System.err.println();
            //imprime la ayuda de todas las opciones
            System.err.println(jsap.getHelp());
            System.exit(1);
        }

        try{
            traductor = new Traductor(config.getString("diccionario"), config.getString("ignoradas"), 
                                        config.getString("entrada"), config.getString("salida"), 
                                        config.getString("reversa"));
            traductor.Traduce();
        }catch(IOException e){
            e.printStackTrace();
        }

    }
}
