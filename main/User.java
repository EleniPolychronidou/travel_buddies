package main;

public class User {
    
    private int userId;
    private String name;
	private String email;
	private int password;
	private String interests;

    /**
     * Full constuctor
     *   
     * @param title
     * @param destination
     * @param name
     * @param email
     * @param password
     * @param interests
     * Θεωρώ το budget δεν χρειάζεται λόγω διαφορετικών σκοπών σε κάθε ταξίδι
     */
    public User(int userId, String name, String email, int password, String interests) {
        
        this.userId = userId;
        this.name = name;
        this.email = email;
        this.password = password;
        this.interests = interests;
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

    public String getInterests() {
        return interests;
    }

    public void setInterests(String interests) {
        this.interests = interests;
    }
    

}