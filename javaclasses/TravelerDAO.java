package javaclasses;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TravelerDAO {

    /**
     * Επιστρέφει τη σύνδεση μέσω της κλάσης DB
     */
    private Connection getConnection() throws SQLException {
        try {
            DB db = new DB();
            return db.getConnection();
        } catch (Exception e) {
            throw new SQLException("Error getting connection: " + e.getMessage());
        }
    }

    // SQL Queries
    private static final String INSERT_TRAVELER = "INSERT INTO traveler (user_id,first_name,last_name, gender, birth_date, interests) VALUES (?, ?, ?, ?, ?, ?)";
    private static final String SELECT_TRAVELER_BY_ID = "SELECT traveler_id, user_id, first_name, last_name, gender, birth_date, interests FROM traveler WHERE traveler_id=?";
    private static final String SELECT_ALL_TRAVELERS = "SELECT traveler_id, user_id, first_name, last_name, gender, birth_date, interests FROM traveler";
    private static final String UPDATE_TRAVELER = "UPDATE traveler SET user_id=?, first_name=?, last_name=?, gender=?, birth_date=?, interests=? WHERE traveler_id=?";
    private static final String DELETE_TRAVELER = "DELETE FROM traveler WHERE traveler_id = ?";

    private static final String SELECT_TRAVELER_BY_USER_ID = "SELECT * FROM traveler WHERE user_id=?";

    /**
     * Εισαγωγή νέου Traveler
     */
    public int insertTraveler(Traveler traveler) {
        int generatedId = -1; // Αρχικοποίηση όπως στη registerUser

        // Προσθήκη Statement.RETURN_GENERATED_KEYS για να πάρουμε το ID
        try (Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(INSERT_TRAVELER, Statement.RETURN_GENERATED_KEYS)) {

            preparedStatement.setInt(1, traveler.getUserId());
            preparedStatement.setString(2, traveler.getFirstName());
            preparedStatement.setString(3, traveler.getLastName());
            preparedStatement.setString(4, traveler.getGender());
            preparedStatement.setDate(5, (java.sql.Date) traveler.getBirthDate());
            preparedStatement.setString(6, traveler.getInterests());

            int affectedRows = preparedStatement.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet rs = preparedStatement.getGeneratedKeys()) {
                    if (rs.next()) {
                        generatedId = rs.getInt(1); // Παίρνουμε το traveler_id
                        traveler.setTravelerId(generatedId); // Ενημερώνουμε το αντικείμενο traveler
                    }
                }
            }
        } catch (SQLException e) {
            System.out.println("--- SQL ERROR START ---");
            e.printStackTrace(); // Αυτό θα τυπώσει το κόκκινο κείμενο στην κονσόλα
            System.out.println("--- SQL ERROR END ---");
        }

        return generatedId; // Επιστρέφει το ID ή -1 αν απέτυχε
    }

    /**
     * Ανάκτηση Traveler με βάση το ID του (traveler_id)
     */
    public Traveler selectTravelerById(int travelerId) {
        Traveler traveler = null; // Αρχικοποίηση ως null
        try (Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(SELECT_TRAVELER_BY_ID)) {

            preparedStatement.setInt(1, travelerId);

            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    traveler = new Traveler(
                            rs.getInt("traveler_id"),
                            rs.getInt("user_id"),
                            rs.getString("first_name"),
                            rs.getString("last_name"),
                            rs.getString("gender"),
                            rs.getDate("birth_date"),
                            rs.getString("interests")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return traveler; // Επιστρέφει το αντικείμενο ή null
    }

    /**
     * Ανάκτηση όλων των Travelers
     */
    public List<Traveler> selectAllTravelers() {
        List<Traveler> travelers = new ArrayList<>();
        try (Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_TRAVELERS)) {

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                Traveler traveler = new Traveler(
                        rs.getInt("traveler_id"),
                        rs.getInt("user_id"),
                        rs.getString("first_name"),
                        rs.getString("last_name"),
                        rs.getString("gender"),
                        rs.getDate("birth_date"),
                        rs.getString("interests")
                );
                travelers.add(traveler);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return travelers;
    }

    /**
     * Ενημέρωση στοιχείων Traveler
     */
    public boolean updateTraveler(Traveler traveler) {
        boolean rowUpdated = false;
        try (Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_TRAVELER)) {

            preparedStatement.setInt(1, traveler.getUserId());
            preparedStatement.setString(2, traveler.getGender());
            preparedStatement.setDate(3, traveler.getBirthDate());
            preparedStatement.setString(4, traveler.getInterests());
            preparedStatement.setInt(5, traveler.getTravelerId()); // Το WHERE clause

            // ΠΡΟΣΟΧΗ: executeUpdate() για UPDATE, όχι executeQuery()
            rowUpdated = preparedStatement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowUpdated;
    }

    /**
     * Διαγραφή Traveler
     */
    public boolean deleteTraveler(int travelerId) {
        boolean rowDeleted = false;
        try (Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(DELETE_TRAVELER)) { // Εδώ έλειπε το {

            preparedStatement.setInt(1, travelerId);
            rowDeleted = preparedStatement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowDeleted;
    }

    /**
     * Μέθοδος για εύρεση traveler με βάση το UserID (μετά το login)
     */
    public Traveler getTravelerByUserId(int userId) {
        Traveler traveler = null;
        try (Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(SELECT_TRAVELER_BY_USER_ID)) {

            preparedStatement.setInt(1, userId);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    traveler = new Traveler(
                            rs.getInt("traveler_id"),
                            rs.getInt("user_id"),
                            rs.getString("first_name"),
                            rs.getString("last_name"),
                            rs.getString("gender"),
                            rs.getDate("birth_date"),
                            rs.getString("interests")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return traveler;
    }
}
