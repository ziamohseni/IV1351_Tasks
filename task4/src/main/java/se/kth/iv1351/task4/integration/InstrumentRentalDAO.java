package se.kth.iv1351.task4.integration;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import se.kth.iv1351.task4.model.Rental;
import se.kth.iv1351.task4.model.RentalDTO;

/**
 * This class is responsible for handling the database connection for
 * instrument-rental-related operations.
 * It establishes a connection to the school database.
 * 
 * Author: Zia
 */
public class InstrumentRentalDAO {
    private static final String INSTRUMENT_RENTAL_TABLE_NAME = "instrument_rental";
    private static final String INSTRUMENT_RENTAL_RENTAL_ID_PK_COLUMN_NAME = "rental_id";
    private static final String INSTRUMENT_RENTAL_INSTRUMENT_ID_FK_COLUMN_NAME = "instrument_id";
    private static final String INSTRUMENT_RENTAL_STUDENT_ID_FK_COLUMN_NAME = "student_id";
    private static final String INSTRUMENT_RENTAL_RENTAL_START_DATE_COLUMN_NAME = "rental_start_date";
    private static final String INSTRUMENT_RENTAL_RENTAL_END_DATE_COLUMN_NAME = "rental_end_date";
    private static final String INSTRUMENT_RENTAL_RENTAL_TERMINATION_DATE_COLUMN_NAME = "rental_termination_date";
    private static final String INSTRUMENT_RENTAL_IS_RENTAL_ACTIVE_COLUMN_NAME = "is_rental_active";

    private Connection connection;
    private PreparedStatement createInstrumentRentalStatement;
    private PreparedStatement findInstrumentRentalByIdStatement;
    private PreparedStatement updateRentalStatusOnTerminationStatement;

    /**
     * Constructor for InstrumentDAO. It initiates a connection to the school
     * database.
     * 
     * @param schoolDB The school database
     */
    public InstrumentRentalDAO(SchoolDAO schoolDB) throws SchoolDBException {
        this.connection = schoolDB.getConnection();
        try {
            preparedStatement();
        } catch (Exception e) {
            throw new SchoolDBException("Could not prepare statements", e);
        }
    }

    /**
     * Prepares all the SQL statements for instrument-rental-related operations.
     * 
     * @throws SQLException If an error occurs while preparing the statements.
     */
    private void preparedStatement() throws SQLException {
        createInstrumentRentalStatement = connection.prepareStatement(
                "INSERT INTO " + INSTRUMENT_RENTAL_TABLE_NAME + " (" +
                        INSTRUMENT_RENTAL_INSTRUMENT_ID_FK_COLUMN_NAME + ", " +
                        INSTRUMENT_RENTAL_STUDENT_ID_FK_COLUMN_NAME + ", " +
                        INSTRUMENT_RENTAL_RENTAL_START_DATE_COLUMN_NAME + ", " +
                        INSTRUMENT_RENTAL_RENTAL_END_DATE_COLUMN_NAME + ", " +
                        INSTRUMENT_RENTAL_IS_RENTAL_ACTIVE_COLUMN_NAME + ") " +
                        "VALUES (?, ?, CURRENT_DATE, CURRENT_DATE + INTERVAL '30 days', TRUE)");
        findInstrumentRentalByIdStatement = connection.prepareStatement(
                "SELECT * FROM " + INSTRUMENT_RENTAL_TABLE_NAME + " WHERE " +
                        INSTRUMENT_RENTAL_RENTAL_ID_PK_COLUMN_NAME + " = ?");
        updateRentalStatusOnTerminationStatement = connection.prepareStatement(
                "UPDATE " + INSTRUMENT_RENTAL_TABLE_NAME + " SET " +
                        INSTRUMENT_RENTAL_IS_RENTAL_ACTIVE_COLUMN_NAME + " = FALSE, " +
                        INSTRUMENT_RENTAL_RENTAL_TERMINATION_DATE_COLUMN_NAME + " = CURRENT_DATE " +
                        "WHERE " + INSTRUMENT_RENTAL_RENTAL_ID_PK_COLUMN_NAME + " = ?");

    }

    /**
     * Creates a new instrument rental in the database.
     * 
     * @param instrumentID    The ID of the instrument to be rented.
     * @param studentID       The ID of the student who is renting the instrument.
     * @param rentalStartDate The start date of the rental, default is the current
     *                        date.
     * @param rentalEndDate   The end date of the rental, default is the current
     *                        date + 30.
     * @param isRentalActive  Whether the rental is active or not, default is TRUE.
     * @return The ID of the newly created instrument rental.
     * @throws SchoolDBException If an error occurs while creating the instrument
     *                           rental.
     */
    public void createInstrumentRental(RentalDTO newRent) throws SchoolDBException {
        try {
            createInstrumentRentalStatement.setInt(1, newRent.getInstrumentID());
            createInstrumentRentalStatement.setInt(2, newRent.getStudentID());
            createInstrumentRentalStatement.executeUpdate();

            connection.commit();
        } catch (SQLException sqlExc) {
            DAOUtils.handleException(connection, "Could not create instrument rental", sqlExc);
        }
    }

    /**
     * Finds an instrument rental by its ID.
     * 
     * @param rentalID The ID of the rental to be found.
     * @return The rental with the specified ID.
     * @throws SchoolDBException If an error occurs while finding the rental.
     */
    public Rental findInstrumentRentalById(int rentalID) throws SchoolDBException {
        Rental rental = null;
        try {
            findInstrumentRentalByIdStatement.setInt(1, rentalID);
            try (ResultSet rs = findInstrumentRentalByIdStatement.executeQuery()) {
                if (rs.next()) {
                    rental = new Rental(rs.getInt(INSTRUMENT_RENTAL_RENTAL_ID_PK_COLUMN_NAME),
                            rs.getInt(INSTRUMENT_RENTAL_INSTRUMENT_ID_FK_COLUMN_NAME),
                            rs.getInt(INSTRUMENT_RENTAL_STUDENT_ID_FK_COLUMN_NAME),
                            rs.getString(INSTRUMENT_RENTAL_RENTAL_START_DATE_COLUMN_NAME),
                            rs.getString(INSTRUMENT_RENTAL_RENTAL_END_DATE_COLUMN_NAME),
                            rs.getString(INSTRUMENT_RENTAL_RENTAL_TERMINATION_DATE_COLUMN_NAME),
                            rs.getBoolean(INSTRUMENT_RENTAL_IS_RENTAL_ACTIVE_COLUMN_NAME));
                }
            }
            connection.commit();
        } catch (Exception e) {
            throw new SchoolDBException("Could not find a rental with id" + rentalID, e);
        }
        return rental;
    }

    /**
     * Updates the rental status of a rental on rental termination.
     * 
     * @param rental The rental to be updated.
     * @throws SchoolDBException If an error occurs while updating the rental
     *                           status.
     */
    public void updateRentalStatusOnTermination(RentalDTO rental) throws SchoolDBException {
        try {
            updateRentalStatusOnTerminationStatement.setInt(1, rental.getRentalID());
            updateRentalStatusOnTerminationStatement.executeUpdate();

            connection.commit();
        } catch (Exception e) {
            DAOUtils.handleException(connection, "Could not update rental status for id " + rental.getRentalID(), e);
        }
    }

}