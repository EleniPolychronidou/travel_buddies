<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% import java.util.*; %>
<% import main.findatrip.Trip; %>
<% import main.findatrip.TripService; %>

<!DOCTYPE html>
<html lang="el">
<head>
    <meta charset="UTF-8">
    <title>Join Group</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f3f3f3;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .box {
            background: white;
            padding: 30px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0px 4px 10px rgba(0,0,0,0.15);
            max-width: 450px;
        }
        h2 { color: #546D79; }
        .btn {
            margin-top: 20px;
            padding: 10px 15px;
            background-color: #546D79;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
    </style>
</head>

<body>

<%
try {
    Integer userId = (Integer) session.getAttribute("userId");
     if (userId == null) {
        userId = 1; // προσωρινός χρήστης
        session.setAttribute("userId", userId);
    }


    /*if (userId == null) {
        throw new Exception("You must log in to join a group");
    } Οταν φτιάξουμε το log in και σβηνω και το απο πάνω */

    int tripId = Integer.parseInt(request.getParameter("tripId"));


    TripService service = new TripService();
    Trip trip = service.joinTrip(tripId, userId);

    if (trip == null) {
        throw new Exception("Trip not found");
    }
%>

<div class="box">
    <h2>You are in the group!</h2>
    <p>User ID: <strong><%=userId%></strong></p>
    <p>Joined trip: <strong><%=trip.getTitle()%></strong></p>
    <p>Now the trip has <strong><%=trip.getParticipants()%></strong> people.</p>

    <a class="btn"
       href="<%=request.getContextPath()%>/viewdetails.jsp?tripId=<%=trip.getTripId()%>">
        Re
    </a>
</div>

<%
} catch (Exception e) {
%>

<div class="box">
    <h2> Error</h2>
    <p><%= e.getMessage() %></p>
    <a class="btn" href="<%=request.getContextPath()%>/login.jsp">Login</a>
</div>

<%
}
%>

</body>
</html>