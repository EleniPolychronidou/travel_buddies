package javaclasses;

import java.sql.*;
import javaclasses.Agency;

public class AgencyDAO {

    // Μέθοδος σύνδεσης χρησιμοποιώντας την κλάση DB που παρείχες
    private Connection getConnection() throws Exception {
        DB db = new DB();
        return db.getConnection();
    }

    private static final String INSERT_AGENCY = "INSERT INTO agency (user_id, business_name, address, phone) VALUES (?, ?, ?, ?)";
    private static final String SELECT_AGENCY_BY_USER_ID = "SELECT * FROM agency WHERE user_id = ?";

    /**
     * Εισαγωγή νέου Agency στη βάση
     */
    public boolean insertAgency(Agency agency) {
        boolean rowInserted = false;
        
        // Χρησιμοποιούμε try-with-resources για αυτόματο κλείσιμο
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_AGENCY)) {

            preparedStatement.setInt(1, agency.getUserId());
            preparedStatement.setString(2, agency.getBusinessName());
            preparedStatement.setString(3, agency.getAddress());
            preparedStatement.setString(4, agency.getPhone());

            rowInserted = preparedStatement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return rowInserted;
    }

    /**
     * Ανάκτηση Agency με βάση το User ID
     */
    public Agency getAgencyByUserId(int userId) {
        Agency agency = null;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_AGENCY_BY_USER_ID)) {

            preparedStatement.setInt(1, userId);
            
            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    agency = new Agency(
                        rs.getInt("agency_id"),
                        rs.getInt("user_id"),
                        rs.getString("business_name"),
                        rs.getString("address"),
                        rs.getString("phone") // Στη βάση φαίνεται ως phone ή phone_number, προσαρμόστε ανάλογα
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return agency;
    }
}