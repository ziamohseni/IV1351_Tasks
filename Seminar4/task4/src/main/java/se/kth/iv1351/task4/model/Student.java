package se.kth.iv1351.task4.model;

/**
 * This class represents a student.
 * It contains all the information related to a student.
 * 
 * @author Zia
 */
public class Student implements StudentDTO {
  private final int studentID;
  private final String personNumber;
  private final String firstName;
  private final String lastName;
  private final String enrollmentDate;
  private int rentalLimit;
  private String instrumentSkillLevel;
  private String emailAddress;

  /**
   * Creates a new instance of the student.
   *
   * @param studentID            the id of the student.
   * @param personNumber         the person number of the student.
   * @param firstName            the first name of the student.
   * @param lastName             the last name of the student.
   * @param enrollmentDate       the enrollment date of the student.
   * @param rentalLimit          the rental limit of the student.
   * @param instrumentSkillLevel the instrument skill level of the student.
   * @param emailAddress         the email address of the student.
   */
  public Student(int studentID, String personNumber, String firstName, String lastName, String enrollmentDate,
      int rentalLimit, String instrumentSkillLevel, String emailAddress) {
    this.studentID = studentID;
    this.personNumber = personNumber;
    this.firstName = firstName;
    this.lastName = lastName;
    this.enrollmentDate = enrollmentDate;
    this.rentalLimit = rentalLimit;
    this.instrumentSkillLevel = instrumentSkillLevel;
    this.emailAddress = emailAddress;
  }

  /**
   * @return the studentID
   */
  @Override
  public int getStudentID() {
    return studentID;
  }

  /**
   * @return the personNumber
   */
  @Override
  public String getPersonNumber() {
    return personNumber;
  }

  /**
   * @return the firstName
   */
  @Override
  public String getFirstName() {
    return firstName;
  }

  /**
   * @return the lastName
   */
  @Override
  public String getLastName() {
    return lastName;
  }

  /**
   * @return the enrollmentDate
   */
  @Override
  public String getEnrollmentDate() {
    return enrollmentDate;
  }

  /**
   * @return the rentalLimit
   */
  @Override
  public int getRentalLimit() {
    return rentalLimit;
  }

  /**
   * @return the instrumentSkillLevel
   */
  @Override
  public String getInstrumentSkillLevel() {
    return instrumentSkillLevel;
  }

  /**
   * @return the emailAddress
   */
  @Override
  public String getEmailAddress() {
    return emailAddress;
  }

  /**
   * Increases the rental limit of the student.
   */
  public void increaseRentalLimit() throws RejectedException {
    // Throw exception if rental limit is already 2
    if (rentalLimit == 2) {
      throw new RejectedException("Your rental limit has reached the maximum limit.");
    }

    // Increase rental limit
    if (rentalLimit < 2) {
      rentalLimit++;
    }
  }

  /**
   * Decreases the rental limit of the student.
   */
  public void decreaseRentalLimit() throws RejectedException {
    // Throw exception if rental limit is already 0
    if (rentalLimit == 0) {
      throw new RejectedException("You have reached the rental limit.");
    }

    // Decrease rental limit
    if (rentalLimit > 0) {
      rentalLimit--;
    }
  }

}
