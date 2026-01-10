package javaclasses;

public class User {

    public enum Role {
        TRAVELER,
        AGENCY
    }
    
    // Αντιστοίχιση με τις στήλες της βάσης: user_id, username, email, password, role
    private int userId;
    private String username; // Αντί για name
    private String email;
    private String password; // String επειδή η βάση είναι VARCHAR(255)
    private Role role;

    /**
     * Constructor με ID
     */
    public User(int userId, String username, String email, String password, Role role) {
        this.userId = userId;
        this.username = username;
        this.email = email;
        this.password = password;
        this.role = role;
    }

    /**
     * Constructor χωρίς ID
     */
    public User(String username, String email, String password, Role role) {
        this(0, username, email, password, role);
    }

    // --- Getters & Setters ---

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public Role getRole() { return role; }
    public void setRole(Role role) { this.role = role; }
    
    // Βοηθητική: Επιστρέφει το ρόλο σε πεζά γράμματα για τη βάση ('traveler' αντί 'TRAVELER')
    public String getRoleForDB() {
        return role != null ? role.toString().toLowerCase() : "traveler"; 
    } 
}