package com.unc.famaf.ales;

import com.martiansoftware.jsap.*;

public class Main {

	 public static void main(String[] args) throws Exception {
	        JSAP jsap = new JSAP();
	        
	        FlaggedOption opt1 = new FlaggedOption("count")
	                                .setStringParser(JSAP.INTEGER_PARSER)
	                                .setDefault("1") 
	                                .setRequired(true) 
	                                .setShortFlag('n') 
	                                .setLongFlag(JSAP.NO_LONGFLAG);

	        opt1.setHelp("The number of times to say hello.");
	        jsap.registerParameter(opt1);
	        
	        Switch sw1 = new Switch("verbose")
	                        .setShortFlag('v')
	                        .setLongFlag("verbose");
	        
	        sw1.setHelp("Requests verbose output.");
	        jsap.registerParameter(sw1);
	        
	        UnflaggedOption opt2 = new UnflaggedOption("name")
	                                .setStringParser(JSAP.STRING_PARSER)
	                                .setDefault("World")
	                                .setRequired(true)
	                                .setGreedy(true);
	        
	        opt2.setHelp("One or more names of people you would like to greet.");
	        jsap.registerParameter(opt2);
	        
	        JSAPResult config = jsap.parse(args);    

	        if (!config.success()) {
	            
	            System.err.println();

	            // print out specific error messages describing the problems
	            // with the command line, THEN print usage, THEN print full
	            // help.  This is called "beating the user with a clue stick."
	            for (java.util.Iterator errs = config.getErrorMessageIterator();
	                    errs.hasNext();) {
	                System.err.println("Error: " + errs.next());
	            }
	            
	            System.err.println();
	            System.err.println("Usage: java "
	                                + Main.class.getName());
	            System.err.println("                "
	                                + jsap.getUsage());
	            System.err.println();
	            System.err.println(jsap.getHelp());
	            System.exit(1);
	        }
	        
	        String[] names = config.getStringArray("name");
	        for (int i = 0; i < config.getInt("count"); ++i) {
	            for (int j = 0; j < names.length; ++j) {
	                System.out.println((config.getBoolean("verbose") ? "Hello" : "Hi")
	                                + ", "
	                                + names[j]
	                                + "!");
	            }
	        }
	        
	        // traductor.run(archivo archivo)
	    }

}