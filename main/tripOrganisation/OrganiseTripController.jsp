<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Date" %>
<%@ page import="javaclasses.Trip" %>

<%@ page import="javaclasses.TripService" %>

<%

 Integer agencyIdObj = (Integer) session.getAttribute("agencyId");
 if (agencyIdObj == null) {
   request.setAttribute("error_message", "Only agencies can create trips.");
     request.getRequestDispatcher("../tripOrganisation/OrganiseTrip.jsp").forward(request, response);
      return;
 }
int agencyId = agencyIdObj.intValue();

String title = request.getParameter("title");
String destination = request.getParameter("destination");
String purpose = request.getParameter("purpose");
String startStr = request.getParameter("start");
String endStr = request.getParameter("end");
String description = request.getParameter("description");
String avgCostStr = request.getParameter("avgCost");

Date startDate = null;
Date endDate = null;

if (startStr != null && !startStr.isEmpty()) {
    startDate = Date.valueOf(startStr);
}
if (endStr != null && !endStr.isEmpty()) {
    endDate = Date.valueOf(endStr);
}

double avgCost = 0.0;
if (avgCostStr != null && !avgCostStr.isEmpty()) {
    avgCost = Double.parseDouble(avgCostStr);
}




try {
    TripService service = new TripService();
    int newTripId = service.createTrip(agencyId, title, destination, startDate, endDate, purpose, description, avgCost);

    request.setAttribute("success_message", "Trip published successfully! Trip ID: " + newTripId);
    request.getRequestDispatcher("OrganiseTrip.jsp").forward(request, response);
    return;

} catch (Exception e) {
    request.setAttribute("error_message", e.getMessage());
    request.getRequestDispatcher("OrganiseTrip.jsp").forward(request, response);
}
%>
