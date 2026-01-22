<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="javaclasses.Trip" %>
<%@ page import="java.util.List" %>
<%@ page import="javaclasses.TripService" %>
<%@ page import="javaclasses.Agency" %>
<%@ page import="javaclasses.AgencyDAO" %>
<%@ page import= "javaclasses.Traveler" %>
<%@ page import= "javaclasses.TravelerDAO" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.sql.Date" %>


<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Find a Trip</title>
    <link rel="stylesheet" href="../styleforcss/style.css" />
    <link rel="stylesheet" href="findaTrip.css" />
  </head>

  <body>
    <header>
        <jsp:include page="../home/header.jsp" />
    </header>
    <div class="desc">
      <p >
        Are your suitcases ready? Let the adventure begin! 
      </p>
  </div>

    
<div class="filters">
    <form action="findaTripController.jsp" method="get">
        <label style="margin-left:10px;">Destination</label>
        <input name="destination" type="text" placeholder="Paris">

        <label for="start">Start date</label>
        <input name="start" type="date">

        <label for="end">End date</label>
        <input name="end" type="date">

        <button type="submit" class="searchBtn">Search</button>
    </form>
</div>
 
   

    <!-- Popular Destinations Section -->
    <section class="popular-destinations">
      <h2>Popular Destinations</h2>
      <div class="destinations-grid" >
        <div class="destination-card" onclick="window.location.href='findaTripController.jsp?destination=Greece'">
          <div class="destination-image">
            <img src="https://images.unsplash.com/photo-1555881400-74d7acaacd8b?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Greece">
          </div>
          <h3>Greece</h3>
          <p>Island hopping & ancient history</p>
          
        </div>
        <div class="destination-card" onclick="window.location.href='findaTripController.jsp?destination=Italy'">
          <div class="destination-image">
            <img src="https://images.unsplash.com/photo-1515542622106-78bda8ba0e5b?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Italy">
          </div>
          <h3>Italy</h3>
          <p>Food, art & romantic cities</p>

        </div>
        <div class="destination-card" onclick="window.location.href='findaTripController.jsp?destination=Spain'">
          <div class="destination-image">
            <img src="https://images.unsplash.com/photo-1543785734-4b6e564642f8?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Spain">
          </div>
          <h3>Spain</h3>
          <p>Beaches & vibrant culture</p>
          
        </div>
        <div class="destination-card" onclick="window.location.href='findaTripController.jsp?destination=France'">
            <div class="destination-image">
                <img src="https://images.unsplash.com/photo-1549144511-f099e773c147?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="France">
            </div>
            <h3>France</h3>
            <p>Romance, wine & landmarks</p>
            
        </div>
        <div class="destination-card" onclick="window.location.href='findaTripController.jsp?destination=Portugal'">
          <div class="destination-image">
            <img src="https://images.unsplash.com/photo-1523531294919-4bcd7c65e216?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Portugal">
          </div>
          <h3>Portugal</h3>
          <p>Coastal charm & heritage</p>
          
        </div>
      </div>
    </section>

    <!-- Trip Types Section -->
    <section class="trip-types">
      <h2> Browse by Trip Type</h2>
      
        
      <div class="types-grid">
        <div class="type-card recreation" onclick="window.location.href='searchByPurpose.jsp?purpose=Recreation'">
          <h3>Recreation</h3>
          <p>Relaxation, fun activities, and leisure time</p>
        </div>
        <div class="type-card adventure" onclick="window.location.href='searchByPurpose.jsp?purpose=Adventure'">
          <h3>Adventure</h3>
          <p>Hiking, camping & outdoor activities</p>
        </div>
        <div class="type-card cultural" onclick="window.location.href='searchByPurpose.jsp?purpose=Cultural'">
          <h3>Cultural</h3>
          <p>Museums, history & local experiences</p>
        </div>
        <div class="type-card business" onclick="window.location.href='searchByPurpose.jsp?purpose=Business'">
          <h3>Business</h3>
          <p>Corporate events & meetings</p>
        </div>
        <div class="type-card foodwine" onclick="window.location.href='searchByPurpose.jsp?purpose=FOOD_WINE'">
          <h3>Food & Wine</h3>
          <p>Epicurean journeys & tastings</p>
        </div>
      </div>
    </section>


    <section class="quick-stats">
      <div class="stat">
        <% TripService tripService = new TripService();
            List<Trip> tripList = tripService.getAllTrips();
            LocalDate today = LocalDate.now();
            List<Trip> trips =new java.util.ArrayList<Trip>();
            if (tripList != null) {  
              for (Trip trip : tripList) {
                  Date sd = trip.getStartDate();
                  if (sd == null) continue;
                  LocalDate tripStartDate = sd.toLocalDate();
                    if (tripStartDate.isAfter(today)) {
                        trips.add(trip);
                    }
                  }
                }
              
          int tripCount = 0;
      if (trips != null && !trips.isEmpty()) {
          tripCount = trips.size(); }
        %>
        <span class="stat-number"><%= tripCount %></span>
        <span class="stat-label" style="white-space: nowrap;">Trips Available  </span>
      </div>
      <div class="stat">
        <% 
          TravelerDAO travelerDao = new TravelerDAO();
          List<Traveler> travelerList = travelerDao.selectAllTravelers();
          int travelerCount = 0;
          if (travelerList != null) {
              travelerCount = travelerList.size();
          } %>
        
        <span class="stat-number"><%= travelerCount %></span>
        <span class="stat-label" style="white-space: nowrap;">Active Travelers  </span>
      </div>
      <div class="stat">
        <% 
          AgencyDAO agencyDao = new AgencyDAO();
          List<Agency> agencyList = agencyDao.getAllAgencies();
          int agencyCount = 0;
          if (agencyList != null) {
              agencyCount = agencyList.size();
          } %>
        
        <span class="stat-number"><%= agencyCount %></span>
        <span class="stat-label"  style="white-space: nowrap;">Active agencies  </span>
      </div>
    </section>

    <footer>
        <jsp:include page="../home/footer.jsp" />
      
    </footer>
  </body>
</html>
