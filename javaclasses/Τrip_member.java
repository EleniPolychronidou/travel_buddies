package javaclasses;

public class Τrip_member {

    private int trip_memberId;   // auto_increment (δεν μπαίνει στον constructor)
    private int tripId;
    private int userId;
    private boolean organiser;

    // Constructor για INSERT (χωρίς id)
    public Τrip_member(int tripId, int userId, boolean organiser) {
        this.tripId = tripId;
        this.userId = userId;
        this.organiser = organiser;
    }

    // Optional constructor (αν θες object από SELECT)
    public Τrip_member(int tripMemberId, int tripId, int userId, boolean organiser) {
        this.trip_memberId = tripMemberId;
        this.tripId = tripId;
        this.userId = userId;
        this.organiser = organiser;
    }

    public int getTripMemberId() {
        return trip_memberId;

    }
    public void setTripMemberId(int trip_memberId) {
        this.trip_memberId = trip_memberId;
    }


    public int getTripId() {
        return tripId;
    }
    public void setTripId(int tripId) {
        this.tripId = tripId;
    }

    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
    }

    public boolean isOrganiser() {
        return organiser;
    }
    public void setOrganiser(boolean organiser) {
        this.organiser = organiser;
    }
}