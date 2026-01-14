package javaclasses;

import java.sql.*;

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
    public int insertAgency(Agency agency) {
        int generatedId = -1;
        String INSERT_AGENCY = "INSERT INTO agency (userId, businessName, address, phone) VALUES (?, ?, ?, ?)";

    // ΠΡΟΣΟΧΗ: Το try ξεκινάει ΠΡΙΝ το getConnection()
    try {
        Connection connection = getConnection(); // Εδώ ήταν το πρόβλημα

        try (PreparedStatement preparedStatement = connection.prepareStatement(INSERT_AGENCY, Statement.RETURN_GENERATED_KEYS)) {

            preparedStatement.setInt(1, agency.getUserId());
            preparedStatement.setString(2, agency.getBusinessName());
            preparedStatement.setString(3, agency.getAddress());
            preparedStatement.setString(4, agency.getPhone());

            int affectedRows = preparedStatement.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet rs = preparedStatement.getGeneratedKeys()) {
                    if (rs.next()) {
                        generatedId = rs.getInt(1);
                        agency.setAgencyId(generatedId);
                    }
                }
            }
        } finally {
            if (connection != null) {
                connection.close();
            }
        }

    } catch (Exception e) { // Πιάνει το Exception του getConnection()
        e.printStackTrace();
    }

        return generatedId;
    }

    /**
     * Ανάκτηση Agency με βάση το User ID
     */
    public Agency getAgencyByUserId(int userId) {
        Agency agency = null;
        try (Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(SELECT_AGENCY_BY_USER_ID)) {

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
