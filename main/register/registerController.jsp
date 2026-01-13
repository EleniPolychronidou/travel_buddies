<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.SQLIntegrityConstraintViolationException" %>
<%@ page errorPage="appError.jsp" %>
<%@ page import="javaclasses.UserDAO" %>
<%@ page import="javaclasses.User" %>
<%@ page import="javaclasses.TravelerDAO" %>
<%@ page import="javaclasses.AgencyDAO" %>
<%@ page import="javaclasses.Agency" %>
<%@ page import="javaclasses.Traveler" %>

<%
    // FIX: Parameter names must match signUporIn.jsp exactly
    String type        = request.getParameter("userType"); // Matched name="userType" [cite: 108]
    String firstname   = request.getParameter("firstname");
    String lastname    = request.getParameter("lastname");
    String bday        = request.getParameter("birthDate");
    String gender      = request.getParameter("gender");
    String interests   = request.getParameter("interests");
    String business    = request.getParameter("businessName"); // Matched name="businessName" 
    String phone       = request.getParameter("phone");
    String address     = request.getParameter("address");
    String username    = request.getParameter("username");
    String password    = request.getParameter("password");
    String email       = request.getParameter("email"); // Matched name="email" 

    java.sql.Date birthDate = null;
    if (bday != null && !bday.isEmpty()) {
    birthDate = java.sql.Date.valueOf(bday); 
}
    if (type == null || password == null || email == null) {
        throw new Exception("Required parameters missing. Please visit the registration form.");
    }

    try {
        UserDAO uDAO = new UserDAO();

        // FIX: The method validateUser does not exist in UserDAO.java.
        // If you need validation, do it here or add it to UserDAO.
        if(email.isEmpty() || password.length() < 6) {
             throw new Exception("Invalid email or password length.");
        }
        
        if (uDAO.emailExists(email)) {
            request.setAttribute("error_message", "Το email χρησιμοποιείται ήδη.");
            request.getRequestDispatcher("signUporIn.jsp").forward(request, response);
            return;
        }

        if (uDAO.usernameExists(username)) {
            request.setAttribute("error_message", "Το username χρησιμοποιείται ήδη.");
            request.getRequestDispatcher("signUporIn.jsp").forward(request, response);
            return;
        }
        String userRole = type.toUpperCase();
        
        User user = new User(username, email, password, userRole);
        int newUserId = uDAO.registerUser(user);
        if (userRole.equals("TRAVELLER")) {
            TravelerDAO tDAO = new TravelerDAO();
            tDAO.insertTraveler(
                newUserId,
                gender,
                firstname,
                lastname,
                birthDate,
                
                interests
            );
        }

   if (userRole.equals("AGENCY")) {
    AgencyDAO aDAO = new AgencyDAO();

    Agency agency = new Agency();
    agency.setUserId(newUserId);
    agency.setBusinessName(business);
    agency.setAddress(address);
    agency.setPhone(phone);

    aDAO.insertAgency(agency);
}
    }

        // FIX: Use uDAO.registerUser(user) instead of the non-existent uService [cite: 127, 136]

        request.setAttribute("successMessage", "User with email " + email + " saved successfully!");
%>
    <jsp:forward page="signUporIn.jsp"/>
<%
    return;

    } catch(SQLIntegrityConstraintViolationException e) {
        request.setAttribute("error_message", "User already exists.");
%>
    <jsp:forward page="signUporIn.jsp"/>
<%
    return;

    } catch(Exception e) {
        request.setAttribute("error_message", e.getMessage());
%>
    <jsp:forward page="signUporIn.jsp"/>
<%
    return;
    }
%>