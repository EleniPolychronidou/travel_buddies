package main.java;

public class Τrip_member {
    private int tripId;
    private int trip_member_id;
    private int user_id;
    private boolean isOrganizer;

    public Τrip_member(int tripId, int trip_member_id, int user_id, boolean isOrganizer) {
        this.tripId = tripId;
        this.trip_member_id = trip_member_id;
        this.user_id = user_id;
        this.isOrganizer = isOrganizer;
    }
    public int getTripId() {
        return tripId;
    }
    public void setTripId(int tripId) {
        this.tripId = tripId;
    }
    public int getTrip_member_id() {
        return trip_member_id;
    }
    public void setTrip_member_id(int trip_member_id) {
        this.trip_member_id = trip_member_id;
    }
    public int getUser_id() {
        return user_id;
    }
    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }
    public boolean getIsOrganizer() {
        return isOrganizer;
    }
    public void setIsOrganizer(boolean isOrganizer) {
        this.isOrganizer = isOrganizer;
    }
}