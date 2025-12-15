package main;

public class User {

    // Ορίζω το Enum
    public enum Role {
        TRAVELER,
        AGENCY
    }
    
    private int userId;
    private String name;
	private String email;
	private int password;
    private Role role;

    /**
     * Full constuctor
     *   
     * @param title
     * @param name
     * @param email
     * @param password
     * @param role
     * Θεωρώ το budget δεν χρειάζεται λόγω διαφορετικών σκοπών σε κάθε ταξίδι
     */
    public User(int userId, String name, String email, int password, String interests) {
        
        this.userId = userId;
        this.name = name;
        this.email = email;
        this.password = password;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getPassword() {
        return password;
    }

    public void setPassword(int password) {
        this.password = password;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }
    
    // Βοηθητική μέθοδος για να επιστρέφει το enum ως String (π.χ. για τη βάση δεδομένων)
    public String getRoleString() {
        return role.toString(); 
    } 

}