<%@ page import="java.util.List" %>
<%@ page import="javaclasses.Trip" %>
<%@ page import="javaclasses.TripService" %>

<%
String purpose = request.getParameter("purpose");
String dbPurpose;

if ("FOOD_WINE".equals(purpose)) {
    dbPurpose = "Food & Wine";

} else {
    dbPurpose = purpose;
}


TripService service = new TripService();
List<Trip> trips = service.searchTripsByPurpose(dbPurpose);
request.setAttribute("purpose", dbPurpose);
request.setAttribute("trips", trips);
request.getRequestDispatcher("searchresults.jsp").forward(request, response);
%>