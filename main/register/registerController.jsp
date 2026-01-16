<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.SQLIntegrityConstraintViolationException" %>
<%@ page errorPage="appError.jsp" %>
<%@ page import="javaclasses.*" %>



<%
 
    String type        = request.getParameter("userType");
    String firstname   = request.getParameter("firstname");
    String lastname    = request.getParameter("lastname");
    String bday        = request.getParameter("birthDate");
    String gender      = request.getParameter("gender");
    String interests   = request.getParameter("interests");
    String business    = request.getParameter("businessName"); 
    String phone       = request.getParameter("phone");
    String address     = request.getParameter("address");
    String username    = request.getParameter("username");
    String password    = request.getParameter("password");
    String email       = request.getParameter("email"); 

  
    java.sql.Date birthDate = null;
    if (bday != null && !bday.isEmpty()) {
        birthDate = java.sql.Date.valueOf(bday); 
    }


    if (type == null || password == null || email == null) {
        throw new Exception("Required parameters missing.");
    }
        
    try {
        UserDAO uDAO = new UserDAO();

    
        if (uDAO.emailExists(email)) {
            request.setAttribute("error_message", "This email is already used.");
            request.getRequestDispatcher("signUporIn.jsp").forward(request, response);
            return;
        }

        if (uDAO.usernameExists(username)) {
            request.setAttribute("error_message", "This username is already used.");
            request.getRequestDispatcher("signUporIn.jsp").forward(request, response);
            return;
        }

        String userRole = type.toUpperCase();
        User user = new User(username, email, password, userRole);
        
 
        int newUserId = uDAO.registerUser(user);

        if (userRole.equalsIgnoreCase("TRAVELER")) {
            TravelerDAO tDAO = new TravelerDAO();
            Traveler newTraveler = new Traveler(newUserId, firstname, lastname, gender, birthDate, interests);
            tDAO.insertTraveler(newTraveler);
        } else if (userRole.equals("AGENCY")) {
            AgencyDAO aDAO = new AgencyDAO();
            Agency agency = new Agency(newUserId, business, address, phone);
            aDAO.insertAgency(agency);
        }


        request.setAttribute("successMessage", "User with email " + email + " saved successfully!");
        request.getRequestDispatcher("signUporIn.jsp").forward(request, response);

    } catch (SQLIntegrityConstraintViolationException e) {
        request.setAttribute("error_message", "User already exists (Constraint Violation).");
        request.getRequestDispatcher("signUporIn.jsp").forward(request, response);
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("error_message", "Error: " + e.getMessage());
        request.getRequestDispatcher("signUporIn.jsp").forward(request, response);
    }
%>