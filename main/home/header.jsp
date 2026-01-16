<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <link rel="stylesheet" href="../styleforcss/style.css" />
    <link
      href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap"
      rel="stylesheet"
    />

    <title>Travel Buddy</title>
  </head>
  <body>
    <header class="header">
      <nav class="nav-container">
        <div class="title">Travel Buddy</div>
        <div class="contents">
          <ul class="contents-items">
            <li class="nav-button">
              <a href="../home/home.jsp">Home</a>
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
   
  </body>
</html>
