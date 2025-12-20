<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javaclasses.Trip, javaclasses.TripService, java.util.List" %>
<%@ page import="java.sql.Date" %>
<%@ page errorPage="appError.jsp" %>

<%
String destination = request.getParameter("destination");
String start = request.getParameter("start");
String end = request.getParameter("end");
Date startDate = null;
Date endDate = null;

if (start != null && !start.isEmpty()) {
    startDate = Date.valueOf(start); 
}

if (end != null && !end.isEmpty()) {
    endDate = Date.valueOf(end);
}

TripService tripService = new TripService();

try {
    List<Trip> trips = tripService.searchTrips(destination, startDate, endDate);
    request.setAttribute("trips", trips);

%>
    <jsp:forward page="searchresults.jsp" />
<%
} catch(Exception e) {
    request.setAttribute("error_message", e.getMessage());
%>
    <jsp:forward page="findatrip.jsp" />
<%
}
%>
