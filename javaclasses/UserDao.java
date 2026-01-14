package javaclasses;

import java.sql.*;

public class UserDAO {

    private Connection getConnection() throws Exception {
        DB db = new DB();
        return db.getConnection();
    }

    // Queries
    private static final String INSERT_USER = "INSERT INTO user (username, email, password, role) VALUES (?, ?, ?, ?)";
    private static final String CHECK_LOGIN = "SELECT * FROM user WHERE email = ? AND password = ?";
    private static final String CHECK_EMAIL = "SELECT user_id FROM user WHERE email = ?";
    private static final String CHECK_USERNAME = "SELECT user_id FROM user WHERE username = ?";

    /**
     * Εγγραφή χρήστη. Επιστρέφει το ID που μόλις δημιουργήθηκε, ώστε να
     * χρησιμοποιηθεί για τη δημιουργία Traveler ή Agency. Επιστρέφει -1 σε
     * περίπτωση λάθους.
     */
    public int registerUser(User user) throws Exception {
        int generatedId = -1;

        // RETURN_GENERATED_KEYS για να πάρουμε το ID που μόλις φτιάχτηκε
        try (Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USER, Statement.RETURN_GENERATED_KEYS)) {

            preparedStatement.setString(1, user.getUsername());
            preparedStatement.setString(2, user.getEmail());
            preparedStatement.setString(3, user.getPassword());
            preparedStatement.setString(4, user.getRole()); // Χρήση της μεθόδου getRole()

            int affectedRows = preparedStatement.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet rs = preparedStatement.getGeneratedKeys()) {
                    if (rs.next()) {
                        generatedId = rs.getInt(1); // Παίρνουμε το user_id
                        user.setUserId(generatedId); // Ενημερώνουμε και το αντικείμενο user
                    }
                }
            }
        } catch (SQLException e) {
            // Έλεγχος αν υπάρχει ήδη το email (Duplicate entry - Error Code 1062 για MySQL)
            if (e.getErrorCode() == 1062) {
                throw new Exception("Το email χρησιμοποιείται ήδη.");
            }
            e.printStackTrace();
            throw new Exception("Σφάλμα βάσης δεδομένων: " + e.getMessage());
        }

        return generatedId;
    }

    /**
     * Έλεγχος Login
     */
    public User authenticate(String email, String password) throws Exception {
        User user = null;

        try (Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(CHECK_LOGIN)) {

            preparedStatement.setString(1, email);
            preparedStatement.setString(2, password);

            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    String roleStr = rs.getString("role");

                    user = new User(
                            rs.getInt("user_id"),
                            rs.getString("username"),
                            rs.getString("email"),
                            rs.getString("password"),
                            roleStr);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Αποτυχία σύνδεσης: " + e.getMessage());
        }
        return user;
    }

    /**
     * Έλεγχος αν υπάρχει το email
     */
    public boolean emailExists(String email) {
        try (Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(CHECK_EMAIL)) {

            preparedStatement.setString(1, email);
            ResultSet rs = preparedStatement.executeQuery();
            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean usernameExists(String username) {
    try (Connection connection = getConnection();
         PreparedStatement preparedStatement = connection.prepareStatement(CHECK_USERNAME)) {

        preparedStatement.setString(1, username);
        ResultSet rs = preparedStatement.executeQuery();
        return rs.next();

    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }
}
public String getUsernameById(int userId) {
    String username = null;

    String sql = "SELECT username FROM user WHERE user_id = ?";

    try (Connection conn = getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setInt(1, userId);

        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                username = rs.getString("username");
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return username;
}
}
