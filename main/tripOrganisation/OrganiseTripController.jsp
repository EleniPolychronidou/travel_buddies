<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Date" %>
<%@ page import="javaclasses.Trip" %>

<%@ page import="javaclasses.TripService" %>
<%@ page import="javaclasses.Trip_memberService" %>
<%@ page import="javaclasses.User" %>

<%
User user = (User) session.getAttribute("authenticated_user");
    if (user == null) {
        request.setAttribute("error_message", "You must log in to join a trip.");
        request.getRequestDispatcher("../tripOrganisation/OrganiseTrip.jsp").forward(request, response);
        return;
    }
    if (!"AGENCY".equalsIgnoreCase(user.getRole())) { 
        request.setAttribute("error_message", "Only agencies can create trips.");
        request.getRequestDispatcher("../tripOrganisation/OrganiseTrip.jsp").forward(request, response);
        return;
    }

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
    double avgCost = 0.0;

    if (title == null || title.isEmpty()) {
        request.setAttribute("error_message", "Title cannot be empty");
        request.getRequestDispatcher("../tripOrganisation/OrganiseTrip.jsp").forward(request, response);
        return;}
        if (startStr == null || startStr.isEmpty()) {
        request.setAttribute("error_message", "Start date cannot be empty");
        request.getRequestDispatcher("../tripOrganisation/OrganiseTrip.jsp").forward(request, response);
        return;
    }
    if (endStr == null || endStr.isEmpty()) {
        request.setAttribute("error_message", "End date cannot be empty");
        request.getRequestDispatcher("../tripOrganisation/OrganiseTrip.jsp").forward(request, response);
        return;
    }
    if (avgCostStr == null || avgCostStr.isEmpty()) {
        request.setAttribute("error_message", "Average cost cannot be empty");
        request.getRequestDispatcher("../tripOrganisation/OrganiseTrip.jsp").forward(request, response);
        return;
    }
    if (purpose == null || purpose.isEmpty()) {
        request.setAttribute("error_message", "Purpose cannot be empty");
        request.getRequestDispatcher("../tripOrganisation/OrganiseTrip.jsp").forward(request, response);
        return;
    }
    if (description == null || description.isEmpty()) {
        request.setAttribute("error_message", "Description cannot be empty");
        request.getRequestDispatcher("../tripOrganisation/OrganiseTrip.jsp").forward(request, response);
        return;
    }


    Date startDate = Date.valueOf(startStr);
    Date endDate = Date.valueOf(endStr);
    avgCost = Double.parseDouble(avgCostStr);
    

    if (startDate.after(endDate)) {
        request.setAttribute("error_message", "Start date cannot be after end date");
        request.getRequestDispatcher("../tripOrganisation/OrganiseTrip.jsp").forward(request, response);
        return;
    }




try {
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


    request.setAttribute("success_message", "Trip published successfully! Trip ID: " + newTripId);
    request.getRequestDispatcher("OrganiseTrip.jsp").forward(request, response);
    return;

} catch (Exception e) {
    request.setAttribute("error_message", e.getMessage());
    request.getRequestDispatcher("OrganiseTrip.jsp").forward(request, response);
}
%>
