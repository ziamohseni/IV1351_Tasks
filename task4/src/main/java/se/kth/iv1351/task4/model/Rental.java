package se.kth.iv1351.task4.model;

/**
 * This class represents a rental.
 * It contains all the information related to a rental.
 * 
 * @author Zia
 */
public class Rental implements RentalDTO {
  private final int rentalID;
  private final int instrumentID;
  private final int studentID;
  private final String rentalStartDate;
  private final String rentalEndDate;
  private String rentalTerminationDate;
  private boolean isRentalActive;

  /**
   * Creates a new instance of the rental.
   *
   * @param instrumentID the id of the instrument.
   * @param studentID    the id of the student.
   */
  public Rental(int instrumentID, int studentID) {
    this.rentalID = 0;
    this.instrumentID = instrumentID;
    this.studentID = studentID;
    this.rentalStartDate = null;
    this.rentalEndDate = null;
    this.rentalTerminationDate = null;
    this.isRentalActive = true;
  }

  /**
   * Creates a new instance of the rental.
   *
   * @param rentalID              the id of the rental.
   * @param instrumentID          the id of the instrument.
   * @param studentID             the id of the student.
   * @param rentalStartDate       the start date of the rental.
   * @param rentalEndDate         the end date of the rental.
   * @param rentalTerminationDate the termination date of the rental.
   * @param isRentalActive        the status of the rental.
   */
  public Rental(int rentalID, int instrumentID, int studentID, String rentalStartDate, String rentalEndDate,
      String rentalTerminationDate,
      boolean isRentalActive) {
    this.rentalID = rentalID;
    this.instrumentID = instrumentID;
    this.studentID = studentID;
    this.rentalStartDate = rentalStartDate;
    this.rentalEndDate = rentalEndDate;
    this.isRentalActive = isRentalActive;
  }

  /**
   * @return the rentalID
   */
  @Override
  public int getRentalID() {
    return rentalID;
  }

  /**
   * @return the instrumentID
   */
  @Override
  public int getInstrumentID() {
    return instrumentID;
  }

  /**
   * @return the studentID
   */
  @Override
  public int getStudentID() {
    return studentID;
  }

  /**
   * @return the rentalStartDate
   */
  @Override
  public String getRentalStartDate() {
    return rentalStartDate;
  }

  /**
   * @return the rentalEndDate
   */
  @Override
  public String getRentalEndDate() {
    return rentalEndDate;
  }

  /**
   * @return the rentalTerminationDate
   */
  @Override
  public String getRentalTerminationDate() {
    return rentalTerminationDate;
  }

  /**
   * @return the isRentalActive
   */
  @Override
  public boolean getIsRentalActive() {
    return isRentalActive;
  }

  /**
   * Terminates the rental.
   */
  public void terminateRental() {
    isRentalActive = false;
  }
}
