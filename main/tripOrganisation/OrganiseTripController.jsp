<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Date" %>
<%@ page import="javaclasses.Trip" %>
<%@ page import="javaclasses.TripService" %>
<%@ page import="javaclasses.Trip_memberService" %>
<%@ page import="javaclasses.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<%
User user = (User) session.getAttribute("authenticated_user");
List<String> errors = new ArrayList<String>();

// Authentication and role checks
if (user == null) {
    errors.add("You must log in to create a trip.");
} else if (!"AGENCY".equalsIgnoreCase(user.getRole())) {
    errors.add("Only agencies can create trips.");
}

Integer agencyIdObj = (Integer) session.getAttribute("agencyId");
if (agencyIdObj == null) {
    errors.add("Agency ID not found in session.");
}
String title = request.getParameter("title");
String destination = request.getParameter("destination");
String purpose = request.getParameter("purpose");
String startStr = request.getParameter("start");
String endStr = request.getParameter("end");
String description = request.getParameter("description");
String avgCostStr = request.getParameter("avgCost");

// Validate required fields
if (title == null || title.isEmpty()) {
    errors.add("Title cannot be empty");
}
if (destination == null || destination.isEmpty()) {
    errors.add("Destination cannot be empty");
}
if (startStr == null || startStr.isEmpty()) {
    errors.add("Start date cannot be empty");
}
if (endStr == null || endStr.isEmpty()) {
    errors.add("End date cannot be empty");
}
if (avgCostStr == null || avgCostStr.isEmpty()) {
    errors.add("Average cost cannot be empty");
}
if (purpose == null || purpose.isEmpty()) {
    errors.add("Purpose cannot be empty");
}
if (description == null || description.isEmpty()) {
    errors.add("Description cannot be empty");
}
if (!errors.isEmpty()) {
    request.setAttribute("error_list", errors);
    request.getRequestDispatcher("../tripOrganisation/OrganiseTrip.jsp").forward(request, response);
    return;
}

Date startDate = null;
Date endDate = null;
double avgCost = 0.0;

try {
    startDate = Date.valueOf(startStr);
    endDate = Date.valueOf(endStr);
    avgCost = Double.parseDouble(avgCostStr);
    Date today = new Date(System.currentTimeMillis());
    
    if (startDate.before(today)) {
        errors.add("Start date must be today or in the future");
    }
    if (startDate.after(endDate)) {
        errors.add("Start date cannot be after end date");
    }
    if (avgCost <= 0) {
        errors.add("Average cost must be greater than zero");
    }
    
} catch (IllegalArgumentException e) {
    errors.add("Invalid date or cost format");
}

// If validation errors exist, display them
if (!errors.isEmpty()) {
    request.setAttribute("error_list", errors);
    request.getRequestDispatcher("../tripOrganisation/OrganiseTrip.jsp").forward(request, response);
    return;
}

try {
    int agencyId = agencyIdObj.intValue();
    TripService service = new TripService();
    int newTripId = service.createTrip(agencyId, title, destination, startDate, endDate, purpose, description, avgCost);
    
    int organiserUserId;
    Object uObj = session.getAttribute("authenticated_user");
    if (uObj instanceof Integer) {
        organiserUserId = (Integer) uObj;
    } else {
        organiserUserId = ((User) uObj).getUserId(); 
    }
  
    Trip_memberService ms = new Trip_memberService();
    ms.addMember(newTripId, organiserUserId, true);

    request.setAttribute("success_message", "Trip published successfully!");
    request.getRequestDispatcher("OrganiseTrip.jsp").forward(request, response);
    return;

} catch (Exception e) {
    errors.add("Error creating trip: " + e.getMessage());
    request.setAttribute("error_list", errors);
    request.getRequestDispatcher("OrganiseTrip.jsp").forward(request, response);
}
%>