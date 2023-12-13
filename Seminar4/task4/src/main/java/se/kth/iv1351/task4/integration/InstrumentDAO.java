package se.kth.iv1351.task4.integration;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import se.kth.iv1351.task4.model.*;

/**
 * This class is responsible for handling the database connection for
 * instrument-related operations.
 * It establishes a connection to the school database.
 * 
 * Author: Zia
 */
public class InstrumentDAO {
    private static final String INSTRUMENT_TABLE_NAME = "instrument";
    private static final String INSTRUMENT_INSTRUMENT_ID_PK_COLUMN_NAME = "instrument_id";
    private static final String INSTRUMENT_INSTRUMENT_TYPE_COLUMN_NAME = "instrument_type";
    private static final String INSTRUMENT_INSTRUMENT_BRAND_COLUMN_NAME = "instrument_brand";
    private static final String INSTRUMENT_INSTRUMENT_PRICE_COLUMN_NAME = "instrument_price";
    private static final String INSTRUMENT_IS_AVAILABLE_COLUMN_NAME = "is_available";

    private Connection connection;
    private PreparedStatement findAllInstrumentsStatement;
    private PreparedStatement findInstrumentByIdStatement;
    private PreparedStatement findAvailableInstrumentsByTypeStatement;
    private PreparedStatement updateRentedInstrumentStatement;

    /**
     * Constructor for InstrumentDAO. It initiates a connection to the school
     * database.
     * 
     * @param schoolDB The school database
     */
    public InstrumentDAO(SchoolDAO schoolDB) throws SchoolDBException {
        this.connection = schoolDB.getConnection();
        try {
            preparedStatement();
        } catch (Exception e) {
            throw new SchoolDBException("Could not prepare statements", e);
        }
    }

    /**
     * Prepares all the SQL statements for instrument-related operations.
     * 
     * @throws SQLException If an error occurs while preparing the statements.
     */
    private void preparedStatement() throws SQLException {
        findAllInstrumentsStatement = connection.prepareStatement("SELECT * FROM " + INSTRUMENT_TABLE_NAME);
        updateRentedInstrumentStatement = connection.prepareStatement("UPDATE " + INSTRUMENT_TABLE_NAME
                + " SET " + INSTRUMENT_IS_AVAILABLE_COLUMN_NAME + " = ? WHERE "
                + INSTRUMENT_INSTRUMENT_ID_PK_COLUMN_NAME + " = ?");
        findInstrumentByIdStatement = connection.prepareStatement("SELECT * FROM " + INSTRUMENT_TABLE_NAME + " WHERE "
                + INSTRUMENT_INSTRUMENT_ID_PK_COLUMN_NAME + " = ?");
        findAvailableInstrumentsByTypeStatement = connection.prepareStatement("SELECT * FROM "
                + INSTRUMENT_TABLE_NAME + " WHERE CAST(" + INSTRUMENT_INSTRUMENT_TYPE_COLUMN_NAME
                + " AS TEXT) = ? AND "
                + INSTRUMENT_IS_AVAILABLE_COLUMN_NAME + " = true");
    }

    /**
     * Lists all the instruments in the school database.
     * 
     * @return A list of all the instruments in the school database.
     * @throws SchoolDBException If unable to list instruments.
     */
    public List<Instrument> findAllInstruments() throws SchoolDBException {
        List<Instrument> instruments = new ArrayList<>();
        try (ResultSet rs = findAllInstrumentsStatement.executeQuery()) {
            while (rs.next()) {
                instruments.add(new Instrument(rs.getInt(INSTRUMENT_INSTRUMENT_ID_PK_COLUMN_NAME),
                        rs.getString(INSTRUMENT_INSTRUMENT_TYPE_COLUMN_NAME),
                        rs.getString(INSTRUMENT_INSTRUMENT_BRAND_COLUMN_NAME),
                        rs.getInt(INSTRUMENT_INSTRUMENT_PRICE_COLUMN_NAME),
                        rs.getBoolean(INSTRUMENT_IS_AVAILABLE_COLUMN_NAME)));
            }
            connection.commit();
        } catch (SQLException e) {
            throw new SchoolDBException("Could not list instruments", e);
        }
        return instruments;
    }

    /**
     * Finds an instrument in the school database by its id.
     * 
     * @param instrumentID The id of the instrument to be found.
     * @return The instrument with the specified id.
     * @throws SchoolDBException If unable to find instrument.
     */
    public Instrument findInstrumentById(int instrumentID) throws SchoolDBException {
        Instrument instrument = null;
        try {
            findInstrumentByIdStatement.setInt(1, instrumentID);
            try (ResultSet rs = findInstrumentByIdStatement.executeQuery()) {
                if (rs.next()) {
                    instrument = new Instrument(rs.getInt(INSTRUMENT_INSTRUMENT_ID_PK_COLUMN_NAME),
                            rs.getString(INSTRUMENT_INSTRUMENT_TYPE_COLUMN_NAME),
                            rs.getString(INSTRUMENT_INSTRUMENT_BRAND_COLUMN_NAME),
                            rs.getInt(INSTRUMENT_INSTRUMENT_PRICE_COLUMN_NAME),
                            rs.getBoolean(INSTRUMENT_IS_AVAILABLE_COLUMN_NAME));
                }
            }
            connection.commit();
        } catch (Exception e) {
            throw new SchoolDBException("Could not find instrument with id " + instrumentID, e);
        }
        return instrument;
    }

    /**
     * Finds all available instruments of a specific type in the school database.
     * 
     * @param instrumentType The type of the instrument to be found.
     * @return A list of all available instruments of the specified type.
     * @throws SchoolDBException If unable to find instrument.
     */
    public List<Instrument> findAvailableInstrumentsByType(String instrumentType) throws SchoolDBException {
        List<Instrument> instruments = new ArrayList<>();
        try {
            findAvailableInstrumentsByTypeStatement.setString(1, instrumentType);
            try (ResultSet rs = findAvailableInstrumentsByTypeStatement.executeQuery()) {
                while (rs.next()) {
                    instruments.add(new Instrument(rs.getInt(INSTRUMENT_INSTRUMENT_ID_PK_COLUMN_NAME),
                            rs.getString(INSTRUMENT_INSTRUMENT_TYPE_COLUMN_NAME),
                            rs.getString(INSTRUMENT_INSTRUMENT_BRAND_COLUMN_NAME),
                            rs.getInt(INSTRUMENT_INSTRUMENT_PRICE_COLUMN_NAME),
                            rs.getBoolean(INSTRUMENT_IS_AVAILABLE_COLUMN_NAME)));
                }
            }
            connection.commit();
        } catch (Exception e) {
            throw new SchoolDBException("Could not find instrument with type " + instrumentType, e);
        }
        return instruments;
    }

    /**
     * Updates the availability of an instrument in the school database.
     * 
     * @param instrument The instrument to be updated.
     * @throws SchoolDBException If unable to update instrument.
     */
    public void updateRentedInstrument(InstrumentDTO instrument) throws SchoolDBException {
        try {
            updateRentedInstrumentStatement.setBoolean(1, instrument.getIsAvailable());
            updateRentedInstrumentStatement.setInt(2, instrument.getInstrumentID());
            updateRentedInstrumentStatement.executeUpdate();
            connection.commit();
        } catch (SQLException e) {
            DAOUtils.handleException(connection, "Could not update instrument with id " + instrument.getInstrumentID(),
                    e);
        }
    }
}