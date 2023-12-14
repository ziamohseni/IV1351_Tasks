package se.kth.iv1351.task4.integration;

import java.sql.Connection;
import java.sql.SQLException;

/**
 *
 * @author Zia
 */
public class DAOUtils {
  /**
   * Handles the exception thrown by the database.
   * 
   * @param failureMsg The message to show to the user.
   * @param cause      The exception thrown by the database.
   * @throws SchoolDBException If an error occurs while handling the exception.
   */
  public static void handleException(Connection connection, String failureMsg, Exception cause)
      throws SchoolDBException {
    try {
      connection.rollback();
    } catch (SQLException rollbackExc) {
      failureMsg = failureMsg + ". Also failed to rollback transaction because of: "
          + rollbackExc.getMessage();
    }

    if (cause != null) {
      throw new SchoolDBException(failureMsg, cause);
    } else {
      throw new SchoolDBException(failureMsg);
    }
  }
}
