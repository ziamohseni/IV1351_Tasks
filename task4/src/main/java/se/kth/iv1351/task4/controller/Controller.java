package se.kth.iv1351.task4.controller;

import java.sql.SQLException;
import java.util.List;
import se.kth.iv1351.task4.integration.*;
import se.kth.iv1351.task4.model.*;

/**
 *
 * @author Zia
 */
public class Controller {
    SchoolDAO schoolDB;
    StudentDAO studentDB;
    InstrumentDAO instrumentDB;
    InstrumentRentalDAO instrumentRentalDB;

    /**
     * Constructor for Controller. Initiates the database connection.
     * 
     * @throws SchoolDBException If unable to connect to the database.
     */
    public Controller() throws SchoolDBException {
        schoolDB = new SchoolDAO();
        studentDB = new StudentDAO(schoolDB);
        instrumentDB = new InstrumentDAO(schoolDB);
        instrumentRentalDB = new InstrumentRentalDAO(schoolDB);
    }

    /**
     * Lists all the instruments in the school database.
     * 
     * @param option Can be all, <instrument type> or empty
     * @return A list of all the instruments in the school database.
     * @throws InstrumentException If unable to list instruments.
     */
    public List<? extends InstrumentDTO> listInstruments(String option) throws InstrumentException {
        try {
            if (option.equalsIgnoreCase("all") || option.equals("")) {
                return instrumentDB.findAllInstruments();
            } else {
                String capitalizedOption = capitalizeFirstLetter(option);
                System.out.println("Capitalized option: " + capitalizedOption);
                return instrumentDB.findAvailableInstrumentsByType(capitalizedOption);
            }
        } catch (Exception e) {
            throw new InstrumentException("Could not list instruments", e);
        }
    }

    /**
     * Creates a new rental in the database.
     * 
     * @param instrumentID the ID of the instrument to be rented
     * @param studentID    the ID of the student renting the instrument
     * @throws InstrumentRentalException if unable to create the rental
     */
    public void rentInstrument(int instrumentID, int studentID) throws InstrumentRentalException {
        // Throw exception if invalid ID
        if (instrumentID <= 0 || studentID <= 0) {
            throw new InstrumentRentalException("Invalid instrument or student ID");
        }

        try {
            Instrument instrument = instrumentDB.findInstrumentById(instrumentID);
            Student student = studentDB.findStudentById(studentID);

            // Throw exception if instrument is not available
            if (!instrument.getIsAvailable()) {
                throw new InstrumentRentalException("Instrument with id (" + instrumentID + ") is not available");
            }

            // Throw exception if student has reached rental limit
            if (student.getRentalLimit() == 0) {
                throw new InstrumentRentalException("Student with id (" + studentID + ") has reached rental limit");
            }

            // Create a new rental
            Rental newRental = new Rental(instrumentID, studentID);
            instrumentRentalDB.createInstrumentRental(newRental);

            // Update instrument availability
            instrument.setIsAvailable(false);
            instrumentDB.updateRentedInstrument(instrument);

            // Update student rental limit
            student.decreaseRentalLimit();
            studentDB.updateStudentRentalLimit(student);
        } catch (Exception e) {
            throw new InstrumentRentalException("Could not rent instrument", e);
        }
    }

    /**
     * Terminates a rental in the database.
     * 
     * @param rentalID the ID of the rental to be terminated
     * @throws InstrumentRentalException if unable to terminate the rental
     */
    public void terminateRental(int rentalID) throws InstrumentRentalException {
        // Throw exception if invalid ID
        if (rentalID <= 0) {
            throw new InstrumentRentalException("Invalid rental ID");
        }

        try {
            Rental rental = instrumentRentalDB.findInstrumentRentalById(rentalID);

            // Throw exception if rental does not exist
            if (rental == null) {
                throw new InstrumentRentalException("Rental with id (" + rentalID + ") does not exist");
            }

            Instrument instrument = instrumentDB.findInstrumentById(rental.getInstrumentID());
            Student student = studentDB.findStudentById(rental.getStudentID());

            // Terminate rental
            if (rental.getIsRentalActive()) {
                instrumentRentalDB.updateRentalStatusOnTermination(rental);
            } else {
                throw new InstrumentRentalException("Rental with id (" + rentalID + ") is already terminated");
            }

            // Update instrument availability
            instrument.setIsAvailable(true);
            instrumentDB.updateRentedInstrument(instrument);

            // Update student rental limit
            student.increaseRentalLimit();
            studentDB.updateStudentRentalLimit(student);
        } catch (Exception e) {
            throw new InstrumentRentalException("Could not terminate rental", e);
        }
    }

    /**
     * Capitalizes the first letter of a string.
     * 
     * @param input The string to be capitalized.
     * @return The capitalized string.
     */
    private String capitalizeFirstLetter(String input) {
        if (input.isEmpty()) {
            return input;
        }
        String lowerCaseInput = input.toLowerCase();
        return Character.toUpperCase(lowerCaseInput.charAt(0)) + lowerCaseInput.substring(1);
    }

}
