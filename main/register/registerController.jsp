<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.SQLIntegrityConstraintViolationException" %>
<%@ page errorPage="appError.jsp" %>
<%@ page import="javaclasses.UserDAO" %>
<%@ page import="javaclasses.User" %>

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
    String password    = request.getParameter("password");
    String email       = request.getParameter("email"); // Matched name="email" 

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
        
        String userRole = type.toUpperCase();
        
        User user = new User(email, email, password, userRole);

        // FIX: Use uDAO.registerUser(user) instead of the non-existent uService [cite: 127, 136]
        int newUserId = uDAO.registerUser(user);

        request.setAttribute("successMessage", "User with email " + email + " saved successfully!");
%>
    <jsp:forward page="signUporIn.jsp"/>
<%
    return;

    } catch(SQLIntegrityConstraintViolationException e) {
        request.setAttribute("errorMessage", "User already exists.");
%>
    <jsp:forward page="signUporIn.jsp"/>
<%
    return;

    } catch(Exception e) {
        request.setAttribute("errorMessage", e.getMessage());
%>
    <jsp:forward page="signUporIn.jsp"/>
<%
    return;
    }
%>