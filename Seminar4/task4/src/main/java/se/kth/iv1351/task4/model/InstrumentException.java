package se.kth.iv1351.task4.model;

/**
 * Thrown when something goes wrong while working with the instrument database.
 * @author Zia
 */
public class InstrumentException extends Exception {
    /**
     * Creates a new instance with the specified message.
     * 
     * @param message The exception message.
     */
    public InstrumentException(String message) {
        super(message);
    }
    
    /**
     * Creates a new instance with the specified message and root cause.
     * 
     * @param message The exception message.
     * @param cause The exception that caused this exception.
     */
    public InstrumentException(String message, Throwable cause) {
        super(message, cause);
    }
}
