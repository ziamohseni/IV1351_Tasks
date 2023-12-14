package se.kth.iv1351.task4.model;

/**
 *
 * @author Zia
 */
public interface RentalDTO {
  /**
   * @return the rentalID
   */
  public int getRentalID();

  /**
   * @return the instrumentID
   */
  public int getInstrumentID();

  /**
   * @return the studentID
   */
  public int getStudentID();

  /**
   * @return the rentalStartDate
   */
  public String getRentalStartDate();

  /**
   * @return the rentalEndDate
   */
  public String getRentalEndDate();

  /**
   * @return the rentalTerminationDate
   */
  public String getRentalTerminationDate();

  /**
   * @return the isRentalActive
   */
  public boolean getIsRentalActive();
}
