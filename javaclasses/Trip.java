package javaclasses;
import java.sql.Date;


public class Trip {
    
    private int tripId;
    private int creatorId;
    private String title;
	private String destination;
	private Date startDate;
    private Date endDate;
    private String purpose;
	private String description;
	private double avgCost;
    private String creatorUsername;
    

    /**
     * Full constuctor
     *   
     * @param title //Υποχρεωτικό πεδίο
     * @param destination //Υποχρεωτικό πεδίο
     */
    public Trip(int tripId,int creatorId, String title, String destination, Date startDate, Date endDate,String purpose, String description, double avgCost, String creatorUsername) {        
        if (title == null || destination == null) {
            throw new IllegalArgumentException("Title and Destination are mandatory fields.");
        }
        
        this.tripId = tripId;
        this.creatorId = creatorId;
        this.title = title;
        this.destination = destination;
        this.startDate = startDate;
        this.endDate = endDate;
        this.purpose = purpose;
        this.description = description;
        this.avgCost = avgCost;
        this.creatorUsername = creatorUsername;
        
    }

    // Δεύτερος Constructor για δημιουργία από τη Φόρμα (χωρίς ID ακόμα)
    public Trip(int creatorId, String title, String destination, Date startDate, Date endDate, String purpose, String description, double avgCost, String creatorUsername) {
        this(0, creatorId, title, destination, startDate, endDate, purpose, description, avgCost, creatorUsername);
    }

    public int getTripId() {
        return tripId;
    }

    public void setTripId(int tripId) {
        this.tripId = tripId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public  Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    
    public void setAvgCost(double avgCost) {
        this.avgCost = avgCost;        
    }  

    public double getAvgCost() {
        return avgCost;
    }
    public int getCreatorId() {
        return creatorId;
    }
    public void setCreatorId(int creatorId) {
        this.creatorId = creatorId;
    }
    public String getPurpose() {
        return purpose;
    }

    public void setPurpose(String purpose) {
        this.purpose = purpose;
    }
    public String getCreatorUsername() {
        return creatorUsername;
    }

}