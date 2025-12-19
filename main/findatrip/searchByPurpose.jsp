<%@ page import="java.util.List" %>
<%@ page import="javaclasses.Trip" %>
<%@ page import="javaclasses.TripService" %>

<%
String purpose = request.getParameter("purpose");

TripService service = new TripService();
List<Trip> trips = service.searchTripsByPurpose(purpose);
request.setAttribute("purpose", purpose);
request.setAttribute("trips", trips);
request.getRequestDispatcher("searchresults.jsp").forward(request, response);
%>