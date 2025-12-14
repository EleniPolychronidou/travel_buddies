package main.findatrip;

public class Trip {
    
    private int tripId;
    private String title;
	private String destination;
	private int startDate;
    private int endDate;
	private String description;
	private double avgCost; //average_cost

    /**
     * Full constuctor
     *   
     * @param title //Υποχρεωτικό πεδίο
     * @param destination //Υποχρεωτικό πεδίο
     */
    public Trip(int tripId, String title, String destination, int startDate, int endDate, String description, double avgCost) {        
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
    }

    // Δεύτερος Constructor για δημιουργία από τη Φόρμα (χωρίς ID ακόμα)
    public Trip(String title, String destination, int startDate, int endDate, String description, double avgCost) {
        this(0, title, destination, startDate, endDate, description, avgCost);
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

    public int getStartDate() {
        return startDate;
    }

    public void setStartDate(int startDate) {
        this.startDate = startDate;
    }

    public int getEndDate() {
        return endDate;
    }

    public void setEndDate(int endDate) {
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


}