<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- REMOVE the taglib line here --%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <%-- Use standard JSP EL for your CSS paths --%>
    <link rel="stylesheet" href="../home/home.css" />
    <link rel="stylesheet" href="../styleforcss/style.css" />

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet" />
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Nunito:ital,wght@0,200..1000;1,200..1000&display=swap');
    </style>
    <title>Travel Buddy</title>
</head>
<body class="home-page">
    <header class="header">
      <nav class="nav-container">
        <div class="title">Travel Buddy</div>
        <div class="contents">
          <ul class="contents-items">
            <li class="nav-button">
              <a href="home.jsp">Home</a>
            </li>
            <li class="nav-button">
              <a href="../tripOrganisation/OrganiseTrip.jsp">Organise a Trip</a>
            </li>
            <li class="nav-button">
              <a href="../findatrip/findaTrip.jsp">Find a Trip</a>
            </li>
            <li class="nav-button">
              <a href="../helpPage/HelpPageTravelBuddy.jsp">Contact Us</a>
            </li>
          </ul>
        </div>
<div class="auth">
  <% 
    // Match the key used in your login logic
    Object userObj = session.getAttribute("authenticated_user"); 
    
    if (userObj == null) { 
  %>
      <div class="login-button"><a href="../register/signUporIn.jsp">Sign In/Sign Up</a></div>
  <% 
    } else { 
  %>
      <div class="login-button"><a href="../logout/logoutservlet.jsp">Log Out</a></div>
  <% 
    } 
  %>
</div>
      </nav>
    </header>

<div class="col-xs-12">
<%
					if (request.getAttribute("error_message") != null) {
%>
						<div class="alert alert-danger">
							<%=(String)request.getAttribute("error_message") %>
						</div><%
					}
%>
</div>
    
<!-- Hero Section -->
<section class="hero">
  <div class="container">
    <div class="text">
      <h2>Find your next travel buddy</h2>
      <p class="description">Join trips, meet people, and explore new destinations together.</p>
      <div class="buttons">
        <a href="../tripOrganisation/OrganiseTrip.jsp" class="btn">Organise a Trip</a>
        <a href="../findatrip/findaTrip.jsp" class="btn">Find a Trip</a>
      </div>
    </div>
  </div>
</section>
      

<!-- Ratings Section -->
<section class="ratings-section">
  <h2>What Our Users Say </h2>

  <div class="ratings-container">
    <div class="rating-card">
      <div class="stars">★★★★★</div>
      <p>"I met my now-best friend through Travel Buddy — we connected in the chat and ended up exploring Bali together!"</p>
      <div class="user-info">
        Sarah W.
        <span>Traveled to Bali</span>
      </div>
    </div>

    <div class="rating-card">
      <div class="stars">★★★★★</div>
      <p>"Found two amazing people to backpack across Europe with. The chat made planning and meeting up super easy!"</p>
      <div class="user-info">
        David L.
        <span>Backpacked through Europe</span>
      </div>
    </div>

    <div class="rating-card">
      <div class="stars">★★★★☆</div>
      <p>"Matched with great travel buddies for my Japan trip. The chat helped us plan meetups and share tips on the go!"</p>
      <div class="user-info">
        Alicia K.
        <span>Visited Japan</span>
      </div>
    </div>

    <div class="rating-card">
      <div class="stars">★★★★★</div>
      <p>"We met another couple through Travel Buddy’s chat before our Italy trip — sharing the journey made it unforgettable!"</p>
      <div class="user-info">
        Mark & Emily
        <span>Traveled to Italy</span>
      </div>
    </div>
  </div>
</section>

 
    <footer>
      <div>
        <p>© 2025 TravelBuddy</p>
        <p>76 Patission Str., 104.34 ATHENS, GREECE</p>
        <p>Email: support@travelbuddy.com</p>
      </div>
      <nav>
        <a href="/faq">FAQ</a> | <a href="/support">Support</a> |
        <a href="/groups">Find Groups</a> |
        <a href="/trips">Upcoming Trips</a>
      </nav>
    </footer>

</body>
</html>