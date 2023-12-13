package se.kth.iv1351.task4.startup;

import se.kth.iv1351.task4.view.BlockingInterpreter;
import se.kth.iv1351.task4.controller.Controller;
import se.kth.iv1351.task4.integration.SchoolDBException;

/**
 * Starts the application.
 * 
 * @author Zia
 */
public class Main {
    public static void main(String[] args) {
        try {
            new BlockingInterpreter(new Controller()).handleCmds();
        } catch (SchoolDBException e) {
            System.out.println("Could not connect to school db.");
            e.printStackTrace();
        }
    }
}
