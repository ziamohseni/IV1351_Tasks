package se.kth.iv1351.task4.integration;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import se.kth.iv1351.task4.model.*;

/**
 * This class is responsible for handling the database connection for
 * student-related operations.
 * It establishes a connection to the school database.
 * 
 * Author: Zia
 */
public class StudentDAO {
    private static final String STUDENT_TABLE_NAME = "student";
    private static final String STUDENT_STUDENT_ID_PK_COLUMN_NAME = "student_id";
    private static final String STUDENT_PERSON_NUMBER_COLUMN_NAME = "person_number";
    private static final String STUDENT_FIRST_NAME_COLUMN_NAME = "first_name";
    private static final String STUDENT_LAST_NAME_COLUMN_NAME = "last_name";
    private static final String STUDENT_ENROLLMENT_DATE_COLUMN_NAME = "enrollment_date";
    private static final String STUDENT_RENTAL_LIMIT_COLUMN_NAME = "rental_limit";
    private static final String STUDENT_INSTRUMENT_SKILL_LEVEL_COLUMN_NAME = "instrument_skill_level";
    private static final String STUDENT_EMAIL_ADDRESS_COLUMN_NAME = "email_address";

    private Connection connection;
    private PreparedStatement findStudentByIdStatement;
    private PreparedStatement updateStudentRentalLimitStatement;

    /**
     * Constructor for StudentDAO. It initiates a connection to the school database.
     * 
     * @param schoolDB The school database
     */
    public StudentDAO(SchoolDAO schoolDB) throws SchoolDBException {
        this.connection = schoolDB.getConnection();
        try {
            prepareStudentStatements();
        } catch (SQLException e) {
            throw new SchoolDBException("Could not prepare statements", e);
        }
    }

    /**
     * Prepares all the SQL statements for student-related operations.
     * 
     * @throws SQLException If an error occurs while preparing the statements.
     */
    private void prepareStudentStatements() throws SQLException {
        findStudentByIdStatement = connection.prepareStatement("SELECT * FROM " + STUDENT_TABLE_NAME + " WHERE "
                + STUDENT_STUDENT_ID_PK_COLUMN_NAME + " = ?");
        updateStudentRentalLimitStatement = connection.prepareStatement("UPDATE " + STUDENT_TABLE_NAME + " SET "
                + STUDENT_RENTAL_LIMIT_COLUMN_NAME + " = ? WHERE " + STUDENT_STUDENT_ID_PK_COLUMN_NAME + " = ?");
    }

    /**
     * Finds a student by ID.
     * 
     * @param studentID The ID of the student to be found.
     * @return The student with the specified ID.
     * @throws SchoolDBException If an error occurs while finding the student.
     */
    public Student findStudentById(int studentID) throws SchoolDBException {
        Student student = null;
        try {
            findStudentByIdStatement.setInt(1, studentID);
            try (ResultSet rs = findStudentByIdStatement.executeQuery()) {
                if (rs.next()) {
                    student = new Student(rs.getInt(STUDENT_STUDENT_ID_PK_COLUMN_NAME),
                            rs.getString(STUDENT_PERSON_NUMBER_COLUMN_NAME),
                            rs.getString(STUDENT_FIRST_NAME_COLUMN_NAME),
                            rs.getString(STUDENT_LAST_NAME_COLUMN_NAME),
                            rs.getString(STUDENT_ENROLLMENT_DATE_COLUMN_NAME),
                            rs.getInt(STUDENT_RENTAL_LIMIT_COLUMN_NAME),
                            rs.getString(STUDENT_INSTRUMENT_SKILL_LEVEL_COLUMN_NAME),
                            rs.getString(STUDENT_EMAIL_ADDRESS_COLUMN_NAME));
                }
            }
            connection.commit();
        } catch (Exception e) {
            throw new SchoolDBException("Could not find student with id " + studentID, e);
        }
        return student;
    }

    /**
     * Updates the rental limit of a student.
     * 
     * @param studentID   The ID of the student whose rental limit is to be updated.
     * @param rentalLimit The new rental limit.
     * @throws SchoolDBException If an error occurs while updating the rental limit.
     */
    public void updateStudentRentalLimit(StudentDTO student) throws SchoolDBException {
        try {
            updateStudentRentalLimitStatement.setInt(1, student.getRentalLimit());
            updateStudentRentalLimitStatement.setInt(2, student.getStudentID());
            updateStudentRentalLimitStatement.executeUpdate();
            connection.commit();
        } catch (Exception e) {
            DAOUtils.handleException(connection,
                    "Could not update rental limit for student with id " + student.getStudentID(), e);
        }
    }
}
