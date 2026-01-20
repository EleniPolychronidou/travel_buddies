<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="javaclasses.Trip" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.time.LocalDate" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Search Results</title>
    <style>
        body { font-family: Arial, sans-serif; }
        h2 { text-align: center; margin-top: 20px; color: #546D79; }
        .results-grid { display: flex; flex-wrap: wrap; gap: 20px; margin: 20px; justify-content: center; }
        .result-card {
            border: 1px solid #ccc; border-radius: 10px; overflow: hidden;
            width: 300px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); padding-bottom: 10px;
        }
        .result-card img { width: 100%; height: 180px; object-fit: cover; }
        .result-card h3 { margin: 10px; }
        .result-card p { margin: 5px 10px; }
        .details-btn { margin: 10px; padding: 8px 12px; background-color: #546D79; color: white; border: none; border-radius: 6px; cursor: pointer; }
        .details-btn:hover { background-color: #43555f; }
        .back-btn {
            position: fixed;
            top: 120px;
            left: 20px;
            padding: 5px 10px;
            background-color: #43555f;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            z-index: 1000;
        }
        .back-btn:hover { background-color: #546D79; }
    </style>
</head>
<body>

<header>
    <jsp:include page="../home/header.jsp" />
</header>

<h2>Search Results</h2>
<button class="back-btn" onclick="window.location.href='findaTrip.jsp'">← Back</button>

<%
String purpose = (String) request.getAttribute("purpose");
if (purpose != null) {
%>
    <p style="text-align:center; color:#546D79;">
        Showing trips for: <strong><%= purpose %></strong>
    </p>
<%
}
%>

<%
LocalDate today = LocalDate.now();
List<Trip> trips = (List<Trip>) request.getAttribute("trips");

if (trips == null || trips.isEmpty()) {
%>
    <div style="display:flex;justify-content:center;align-items:center;height:50vh;">
        <p>No trips found.</p>
    </div>
<%
} else {
%>

<div class="results-grid">
<%
    for (Trip trip : trips) {

        Date sd = trip.getStartDate();
        if (sd == null) continue;

        LocalDate tripStartDate = sd.toLocalDate();
        if (!tripStartDate.isAfter(today)) continue;

        boolean isLastChance = tripStartDate.isEqual(today.plusDays(1));
%>
    <div class="result-card">
        <img src="https://images.unsplash.com/photo-1436491865332-7a61a109cc05?auto=format&fit=crop&w=600&q=80" alt="Trip Image">
        <h3><%= trip.getTitle() %></h3>

        <% if (isLastChance) { %>
            <p style="color: red; font-weight: bold; margin: 5px 10px;">Last Chance!</p>
        <% } %>

        <p><strong>Destination:</strong> <%= trip.getDestination() %></p>
        <p><strong>Date:</strong> <%= trip.getStartDate() %> to <%= trip.getEndDate() %></p>

        <form action="viewdetails.jsp" method="get">
            <input type="hidden" name="tripId" value="<%= trip.getTripId() %>">
            <button class="details-btn" type="submit">View Details</button>
        </form>
    </div>
<%
    }
%>
</div>

<%
}
%>

<footer>
    <jsp:include page="../home/footer.jsp" />
</footer>

</body>
</html>
