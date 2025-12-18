<<<<<<< HEAD:main/java/Traveler.java
package main.java;
=======
package main.traveler;
>>>>>>> 9e032ab72dbf652a9d93e1f1f90fb9da51e69938:main/Traveler.java

import java.sql.Date;

public class Traveler {
    private int travelerId;
    private int userId;
    private String gender;
    private Date birthDate;
    private String interests;

    /**
     * Full constuctor
     * 
     * @param travelerId
     * @param userId
     * @param gender
     * @param birthDate
     * @param interests
     */

    // travelers που ήδη υπάρχουν
    public Traveler(int userId, String gender, Date birthDate, String interests) {
        this.userId = userId;
        this.gender = gender;
        this.birthDate = birthDate;
        this.interests = interests;

    }

    // καινούργιοι travelers
    public Traveler(int travelerId, int userId, String gender, Date birthDate, String interests) {
        this.travelerId = travelerId;
        this.userId = userId;
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

