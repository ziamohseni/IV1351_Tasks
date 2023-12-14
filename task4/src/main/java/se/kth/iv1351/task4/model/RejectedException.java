package se.kth.iv1351.task4.model;

/**
 * This exception is thrown when a student tries to rent an instrument but
 * fails.
 * 
 * @author Zia
 */
public class RejectedException extends Exception {

  /**
   * Creates a new instance with a message specifying the reason why the exception
   * is thrown.
   * 
   * @param reason The reason why the exception is thrown.
   */
  public RejectedException(String reason) {
    super(reason);
  }

  /**
   * Creates a new instance with a message specifying the reason why the exception
   * is thrown.
   * 
   * @param reason    The reason why the exception is thrown.
   * @param rootCause The exception that caused this exception to be thrown.
   */
  public RejectedException(String reason, Throwable rootCause) {
    super(reason, rootCause);
  }
}
