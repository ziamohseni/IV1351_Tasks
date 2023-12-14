/*
 * The MIT License
 *
 * Copyright 2017 Leif Lindbäck <leifl@kth.se>.
 *
 */

package se.kth.iv1351.task4.view;

/**
 * Defines all commands that can be performed by a user of the chat application.
 */
public enum Command {
    LIST("Lists instruments. Options: all, <instrument type>."),
    RENT("Rents an instrument. Options: <instrument id> <student id>"),
    TERMINATE("Terminates the rental of an instrument. Options: <rental id>"),
    HELP("Lists all commands."),
    QUIT("Leave the chat application."),
    ILLEGAL_COMMAND("None of the valid commands above was specified.");

    private final String description;

    Command(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}
