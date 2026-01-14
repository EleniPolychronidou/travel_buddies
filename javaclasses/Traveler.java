package javaclasses;

import java.sql.Date;

public class Traveler {

    private int travelerId;
    private int userId;
    private String firstName;
    private String lastName;
    private String gender;
    private Date birthDate;
    private String interests;

    /**
     * Full constuctor
     *
     * @param travelerId
     * @param userId
     * @param firstName
     * @param lastName
     * @param gender
     * @param birthDate
     * @param interests
     */
    // travelers που ήδη υπάρχουν
    public Traveler(int userId, String firstName, String lastName, String gender, Date birthDate, String interests) {
        this.userId = userId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.gender = gender;
        this.birthDate = birthDate;
        this.interests = interests;

    }

    // καινούργιοι travelers
    public Traveler(int travelerId, int userId, String firstName, String lastName, String gender, Date birthDate, String interests) {
        this.travelerId = travelerId;
        this.userId = userId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.gender = gender;
        this.birthDate = birthDate;
        this.interests = interests;
    }

    public int getTravelerId() {
        return travelerId;
    }

    public void setTravelerId(int travelerId) {
        this.travelerId = travelerId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    public String getInterests() {
        return interests;
    }

    public void setInterests(String interests) {
        this.interests = interests;
    }

    @Override
    public String toString() {
        return "Traveler:" + "travelerId=" + travelerId + "userId=" + userId + "gender=" + gender + "birthDate="
                + birthDate + "interests=" + interests;
    }

}
