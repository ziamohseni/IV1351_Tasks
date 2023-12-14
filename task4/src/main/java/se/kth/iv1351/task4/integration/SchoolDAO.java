package se.kth.iv1351.task4.integration;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * This class is responsible for handling the database connection for the school
 * database.
 * It can be used as a base for other DAOs that require database connectivity.
 * 
 * Author: Zia
 */
public class SchoolDAO {
    private Connection connection;

    /**
     * Constructor for SchoolDAO. It initiates a connection to the school database.
     * 
     * @throws SchoolDBException If unable to connect to the database.
     */
    public SchoolDAO() throws SchoolDBException {
        try {
            connectToSchoolDB();
        } catch (SQLException exception) {
            throw new SchoolDBException("Could not connect to school db.", exception);
        }
    }

    /**
     * Establishes a connection to the school database and sets the auto-commit mode
     * to false.
     * This method uses hard coded database credentials to establish the connection.
     * 
     * @throws SQLException If a database access error occurs or the url is null.
     */
    private void connectToSchoolDB() throws SQLException {
        connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/school_db", "postgres", "password");
        connection.setAutoCommit(false);
    }

    // Getter for the connection, if needed by other DAOs
    public Connection getConnection() {
        return connection;
    }
}
