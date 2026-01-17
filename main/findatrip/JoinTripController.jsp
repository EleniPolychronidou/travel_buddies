<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javaclasses.TripService" %>
<%@ page import="javaclasses.User" %>

<%
String tripIdStr = request.getParameter("tripId");
int tripId = -1;

try {
    if (tripIdStr == null || tripIdStr.trim().isEmpty()) {
        request.setAttribute("error_message", "Missing tripId.");
        request.getRequestDispatcher("viewdetails.jsp").forward(request, response);
        return;
    }

    tripId = Integer.parseInt(tripIdStr);

    User user = (User) session.getAttribute("authenticated_user");
    if (user == null) {
        request.setAttribute("error_message", "You must log in to join a trip.");
        request.getRequestDispatcher("viewdetails.jsp?tripId=" + tripId).forward(request, response);
        return;
    }

    int userId = user.getUserId();

    Traveler traveler = (Traveler) session.getAttribute("traveler");
    if (travelerId == null) {
        request.setAttribute("error_message", "Only travelers can join trips.");
        request.getRequestDispatcher("viewdetails.jsp?tripId=" + tripId).forward(request, response);
        return;
    }

    TripService service = new TripService();
    boolean joinedNow = service.joinTrip(tripId, userId);

    request.setAttribute("successMessage",
        joinedNow ? "You successfully joined the trip!" : "You are already a member of this trip."
    );

    request.getRequestDispatcher("viewdetails.jsp?tripId=" + tripId).forward(request, response);
    return;

} catch (Exception e) {
    request.setAttribute("error_message", "Could not join the trip: " + e.getMessage());
    if (tripId != -1) {
        request.getRequestDispatcher("viewdetails.jsp?tripId=" + tripId).forward(request,response);
    } else {
        request.getRequestDispatcher("viewdetails.jsp").forward(request, response);
    }
    return;
}

%>
