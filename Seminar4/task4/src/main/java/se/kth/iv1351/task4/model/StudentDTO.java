package se.kth.iv1351.task4.model;

/**
 *
 * @author Zia
 */
public interface StudentDTO {
  /**
   * @return the studentID
   */
  public int getStudentID();

  /**
   * @return the personNumber
   */
  public String getPersonNumber();

  /**
   * @return the firstName
   */
  public String getFirstName();

  /**
   * @return the lastName
   */
  public String getLastName();

  /**
   * @return the enrollmentDate
   */
  public String getEnrollmentDate();

  /**
   * @return the rentalLimit
   */
  public int getRentalLimit();

  /**
   * @return the instrumentSkillLevel
   */
  public String getInstrumentSkillLevel();

  /**
   * @return the emailAddress
   */
  public String getEmailAddress();

}
