<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.SQLIntegrityConstraintViolationException" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
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


    List<String> errors = new ArrayList<String>();

    if (type == null || type.trim().isEmpty()) {
        errors.add("You must choose a role!");
    }

    if (username == null || username.trim().isEmpty()) {
        errors.add("Username is required!");
    } else if (username.trim().length() < 3) {
        errors.add("Username must be at least 3 characters long!");
    } else if (username.trim().length() > 50) {
        errors.add("Username cannot exceed 50 characters!");
    }

    if (email == null || email.trim().isEmpty()) {
        errors.add("Email is required!");
    } else if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
        errors.add("Invalid email format!");
    } else if (email.trim().length() > 100) {
        errors.add("Email cannot exceed 100 characters!");
    }

    if (password == null || password.trim().isEmpty()) {
        errors.add("Password is required!");
    } else if (password.length() < 6) {
        errors.add("Password must be at least 6 characters long!");
    } else if (password.length() > 100) {
        errors.add("Password cannot exceed 100 characters!");
    }

    if (type != null && type.equalsIgnoreCase("TRAVELER")) {
        
        if (firstname == null || firstname.trim().isEmpty()) {
            errors.add("First name is required!");
        } else if (firstname.trim().length() > 50) {
            errors.add("First name cannot exceed 50 characters!");
        }

        if (lastname == null || lastname.trim().isEmpty()) {
            errors.add("Last name is required!");
        } else if (lastname.trim().length() > 50) {
            errors.add("Last name cannot exceed 50 characters!");
        }

        if (gender == null || gender.trim().isEmpty()) {
            errors.add("Gender is required!");
        }

        if (bday == null || bday.trim().isEmpty()) {
            errors.add("Birth date is required!");
        }

        if (interests != null && interests.trim().length() > 500) {
            errors.add("Interests cannot exceed 500 characters!");
        }
    }
    if (type != null && type.equalsIgnoreCase("AGENCY")) {
        
        if (business == null || business.trim().isEmpty()) {
            errors.add("Business name is required!");
        } else if (business.trim().length() > 100) {
            errors.add("Business name cannot exceed 100 characters!");
        }

        if (phone == null || phone.trim().isEmpty()) {
            errors.add("Phone number is required!");
        } else if (phone.trim().length() > 20) {
            errors.add("Phone number cannot exceed 20 characters!");
        } else if (!phone.matches("^[0-9+\\-\\s()]+$")) {
            errors.add("Invalid phone number format!");
        }

        if (address == null || address.trim().isEmpty()) {
            errors.add("Address is required!");
        } else if (address.trim().length() > 200) {
            errors.add("Address cannot exceed 200 characters!");
        }
    }


    if (!errors.isEmpty()) {
        request.setAttribute("error_message", errors);
        request.setAttribute("show_signup", true);
        request.getRequestDispatcher("signUporIn.jsp").forward(request, response);
        return;
    }

    java.sql.Date birthDate = null;
    if (bday != null && !bday.isEmpty()) {
        try {
            birthDate = java.sql.Date.valueOf(bday);
        } catch (IllegalArgumentException e) {
            errors.add("Invalid date format!");
            request.setAttribute("error_message", errors);
            request.setAttribute("show_signup", true);
            request.getRequestDispatcher("signUporIn.jsp").forward(request, response);
            return;
        }
    }
    
    try {
        UserDAO uDAO = new UserDAO();

        if (uDAO.emailExists(email)) {
            errors.add("This email is already in use.");
            request.setAttribute("error_message", errors);
            request.setAttribute("show_signup", true);
            request.getRequestDispatcher("signUporIn.jsp").forward(request, response);
            return;
        }

        if (uDAO.usernameExists(username)) {
            errors.add("This username is already taken.");
            request.setAttribute("error_message", errors);
            request.setAttribute("show_signup", true);
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

        request.setAttribute("successMessage", "User with email " + email + " registered successfully!");
        request.setAttribute("show_signup", true);
        request.getRequestDispatcher("signUporIn.jsp").forward(request, response);

    } catch (SQLIntegrityConstraintViolationException e) {
        errors.add("User already exists (Constraint Violation).");
        request.setAttribute("error_message", errors);
        request.setAttribute("show_signup", true);
        request.getRequestDispatcher("signUporIn.jsp").forward(request, response);
    } catch (Exception e) {
        e.printStackTrace();
        errors.add("Error: " + e.getMessage());
        request.setAttribute("error_message", errors);
        request.setAttribute("show_signup", true);
        request.getRequestDispatcher("signUporIn.jsp").forward(request, response);
    }
%>