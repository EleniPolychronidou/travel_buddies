<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="javaclasses.Trip" %>
<%@ page import="javaclasses.TripService" %>
<%@ page import="javaclasses.Trip_memberService" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Trip Details</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/css/bootstrap.min.css">
    <style>
        body { font-family: Arial, sans-serif; background-color: #f3f3f3; margin: 0; padding: 20px; }
        .details-card { max-width: 500px; margin: 0 auto; background: white; border-radius: 12px; padding: 20px; box-shadow: 0px 4px 10px rgba(0,0,0,0.15); }
        .details-card img { width: 100%; height: 250px; object-fit: cover; border-radius: 12px; margin-bottom: 15px; }
        h2 { margin-top: 2; color: #546D79; }
        .back-btn, .join-btn { margin-top: 10px; padding: 10px 15px; border: none; border-radius: 8px; cursor: pointer; color: white; }
        .back-btn { background-color: #546D79; }
        .back-btn:hover { background-color: #546D79; }
        .join-btn { background-color: #546D79; }
        .join-btn:hover { background-color: #546D79; }
    </style>
</head>
<body>
<header>
    <jsp:include page="../home/header.jsp" />
</header>
<%
  if (request.getAttribute("error_message") != null) {
%>
    <div class="alert alert-danger">
      <%= (String) request.getAttribute("error_message") %>
    </div>
<%
  }

  if (request.getAttribute("successMessage") != null) {
%>
    <div class="alert alert-success">
      <%= (String) request.getAttribute("successMessage") %>
    </div>
<%
  }
%>

<%
    String tripIdStr = request.getParameter("tripId");

    if (tripIdStr == null) {
%>
        <p>Invalid trip.</p>
<%
        return;
    }

    int tripId = Integer.parseInt(tripIdStr);

    TripService service = new TripService();
    Trip trip = service.findTripById(tripId);

    if (trip == null) {
%>
        <p>Trip not found.</p>
<%
        return;
    }
%>

<div class="details-card">
<% Trip_memberService memberService = new Trip_memberService();
   int participants = memberService.countMembers(trip.getTripId()); %>
    <h2><%=trip.getTitle()%></h2>
    <img src="https://images.unsplash.com/photo-1436491865332-7a61a109cc05?auto=format&fit=crop&w=600&q=80" alt="Trip Image">
    <p><strong>Destination:</strong> <%=trip.getDestination()%></p>
    <p><strong>Purpose:</strong> <%=trip.getPurpose()%></p>
    <p><strong>Budget:</strong> <%=trip.getAvgCost()%></p>
    <p><strong>Dates:</strong> <%=trip.getStartDate()%> to <%=trip.getEndDate()%></p>
    <p><strong>Details:</strong> <%=trip.getDescription()%></p>
    <p><strong>Created by:</strong> <%=trip.getCreatorUsername()%></p>
    <p><strong>Participants:</strong> <%=participants%></p>
    
    <form action="../findatrip/JoinTripController.jsp" method="post">

        <input type="hidden" name="tripId" value="<%= trip.getTripId() %>">
        <button class="join-btn" type="submit">Join Trip</button>
    </form>
    <%
    String successMessage = (String) request.getAttribute("successMessage");
%>

<% if (successMessage != null) { %>
    <div style="margin-top:12px;">
        <a href="../Message/Message.jsp?tripId=<%= trip.getTripId() %>"
           style="
               display:inline-block;
               padding:10px 18px;
               background:#546D79;
               color:white;
               border-radius:8px;
               text-decoration:none;
               font-weight:600;
           ">
            💬 Open Chat
        </a>
    </div>
    <% } %>

    <button class="back-btn" onclick="window.location.href='findaTrip.jsp'"">← Back</button>
</div>

</div>

<footer>
    <jsp:include page="../home/footer.jsp" />
</footer>

</body>
</html>
