package main.findatrip;

public class Trip {
    
    private int tripId;
    private String title;
	private String destination;
	private  String startDate;
    private String endDate;
	private String description;
	private double avgCost;
    private int participants;
    private String createdBy;
    private String img;

    /**
     * Full constuctor
     *   
     * @param title //Υποχρεωτικό πεδίο
     * @param destination //Υποχρεωτικό πεδίο
     */
    public Trip(int tripId, String title, String destination, String startDate, String endDate, String description, double avgCost, int participants, String createdBy,  String img) {        
        if (title == null || destination == null) {
            throw new IllegalArgumentException("Title and Destination are mandatory fields.");
        }
        
        this.tripId = tripId;
        this.title = title;
        this.destination = destination;
        this.startDate = startDate;
        this.endDate = endDate;
        this.description = description;
        this.avgCost = avgCost;
        this.participants = participants ;
        this.createdBy = createdBy;
        this.img = img;
    }

    // Δεύτερος Constructor για δημιουργία από τη Φόρμα (χωρίς ID ακόμα)
    public Trip(String title, String destination, String startDate, String endDate, String description, double avgCost, int participants, String createdBy, String img) {
        this(0, title, destination, startDate, endDate, description, avgCost, participants, createdBy, img);
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

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public  String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
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
    public int getParticipants() {
        return participants;
    }
    public void setParticipants(int participants) {
        this.participants = participants;
    }
    public String getCreatedBy() {
        return createdBy;
    }
    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }
    public String getImg() {
        return img;
    }
    public void setImg(String img) {
        this.img = img;
    }



}