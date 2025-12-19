<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javaclasses.findatrip.Trip, javaclasses.TripService, java.util.List" %>
<%@ page errorPage="appError.jsp" %>

<%
String destination = request.getParameter("destination");
String start = request.getParameter("start");
String end = request.getParameter("end");

TripService tripService = new TripService();

try {
    List<Trip> trips = tripService.searchTrips(destination, start, end);
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
