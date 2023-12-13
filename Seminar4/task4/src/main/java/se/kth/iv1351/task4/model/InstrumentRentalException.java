package se.kth.iv1351.task4.model;

/**
 * This exception is thrown when something goes wrong while handling the
 * instrument rental.
 * 
 * @author Zia
 */
public class InstrumentRentalException extends Exception {
  /**
   * Creates a new instance with the specified message.
   * 
   * @param message The exception message.
   */
  public InstrumentRentalException(String message) {
    super(message);
  }

  /**
   * Creates a new instance with the specified message and root cause.
   * 
   * @param message The exception message.
   * @param cause   The exception that caused this exception.
   */
  public InstrumentRentalException(String message, Throwable cause) {
    super(message, cause);
  }
}
