<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% import java.util.*; %>
<% import main.findatrip.Trip; %>
<% import main.findatrip.TripService; %>
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
            margin: 5px;       
            padding: 5px 10px;     
            background-color: #43555f;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            align-items: left;
            margin-left: 20px;
            margin-right:2200px ;
}
        .back-btn:hover { background-color:  #43555f; }
    </style>
</head>
<body>
<header>
        <jsp:include page="../home/header.jsp" />
</header>
<h2>Search Results</h2>

<button class="back-btn" onclick="window.location.href='findaTrip.html'">← Back</button>

<div class="results-grid" id="resultsGrid"></div>
<%
    List<Trip> trips = request.getAttribute("trips");

    if (trips == null || trips.isEmpty()) {
%>
        <p style="text-align:center;">No trips found.</p>
<%
        return;
    }
%>




<div class="results-grid">
<%
    for (Trip trip : trips) {
%>
    <div class="result-card">
        <img src="<%=trip.img%>" alt="<%=trip.title%>">
        <h3><%=trip.title%></h3>
        <p><strong>Destination:</strong> <%=trip.destination%></p>
        <p><strong>Date:</strong> <%=trip.startDate%> to <%=trip.endDate%></p>

        <form action="viewdetails.jsp" method="get">
            <input type="hidden" name="title" value="<%=trip.title%>">
            <input type="hidden" name="destination" value="<%=trip.destination%>">
            <input type="hidden" name="purpose" value="<%=trip.purpose%>">
            <input type="hidden" name="budget" value="<%=trip.budget%>">
            <input type="hidden" name="start" value="<%=trip.startDate%>">
            <input type="hidden" name="end" value="<%=trip.endDate%>">
            <input type="hidden" name="details" value="<%=trip.details%>">
            <input type="hidden" name="createdBy" value="<%=trip.createdBy%>">
            <input type="hidden" name="participants" value="<%=trip.participants%>">
            <input type="hidden" name="img" value="<%=trip.img%>">

            <button class="details-btn" type="submit">View Details</button>
        </form>
    </div>
<%
    }
%>
</div>

<footer>
        <jsp:include page="../home/footer.jsp" />
      
</footer>

</body>
</html>
