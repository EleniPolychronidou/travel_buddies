package javaclasses;

public class Agency {
    private int agencyId;
    private int userId;
    private String businessName;
    private String address;
    private String phone;

    /**
     * Constructor για νέους agencies (πριν την εισαγωγή στη βάση, χωρίς agencyId)
     */
    public Agency(int userId, String businessName, String address, String phone) {
        this.userId = userId;
        this.businessName = businessName;
        this.address = address;
        this.phone = phone;
    }

    /**
     * Full Constructor (π.χ. για ανάκτηση από τη βάση)
     */
    public Agency(int agencyId, int userId, String businessName, String address, String phone) {
        this.agencyId = agencyId;
        this.userId = userId;
        this.businessName = businessName;
        this.address = address;
        this.phone = phone;
    }

    // --- Getters & Setters ---

    public int getAgencyId() {
        return agencyId;
    }

    public void setAgencyId(int agencyId) {
        this.agencyId = agencyId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getBusinessName() {
        return businessName;
    }

    public void setBusinessName(String businessName) {
        this.businessName = businessName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Override
    public String toString() {
        return "Agency [agencyId=" + agencyId + ", userId=" + userId + ", businessName=" + businessName + 
               ", address=" + address + ", phone=" + phone + "]";
    }
    
}
