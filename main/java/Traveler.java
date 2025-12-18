package main.java;

import java.sql.Date;

public class Traveler {
    private int travelerId;
    private int userId;
    private String gender;
    private Date birthDate;
    private String interests;
    private double budget;

    /**
     * Full constuctor
     * 
     * @param travelerId
     * @param userId
     * @param gender
     * @param birthDate
     * @param interests
     * @param budget
     */

     //travelers που ήδη υπάρχουν
    public Traveler(int userId, String gender, Date birthDate, String interests, double budget) {
        this.userId = userId;
        this.gender = gender;
        this.birthDate = birthDate;
        this.interests = interests;
        this.budget = budget;

    }
    //καινούργιοι travelers
    public Traveler (int travelerId, int userId, String gender, Date birthDate, String interests, double budget){
			this.travelerId=travelerId;
			this.userId = userId;
			this.gender = gender;
			this.birthDate = birthDate;
			this.interests = interests;
			this.budget = budget;
}

    public int getTravelerId() {
        return travelerId;
    }

public void setTravelerId(int travelerId){
	this.travelerId = travelerId;
}

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
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

    //δεν χρειαζεται ααααααα
    public double getBudget(){
        return budget;
    }

    public void setBudget(double budget) {
        this.budget = budget;
    }

    @Override
    public String toString() {
        return "Traveler:" + "travelerId=" + travelerId + "userId=" + userId + "gender=" + gender + "birthDate="
                + birthDate + "interests=" + interests + "budget" +budget;
    }

}
