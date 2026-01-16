<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="appError.jsp" %>
<%@ page import="javaclasses.UserDAO" %>
<%@ page import="javaclasses.User" %>
<%@ page import="javaclasses.TravelerDAO" %>
<%@ page import="javaclasses.AgencyDAO" %>
<%@ page import="javaclasses.Agency" %>
<%@ page import="javaclasses.Traveler" %>

<%
String email = request.getParameter("email");
String password = request.getParameter("password");



try {
    UserDAO uDao = new UserDAO();

    if (email == null || password == null || email.trim().isEmpty() || password.isEmpty()) {
        request.setAttribute("error_message", "Βάλε email και κωδικό.");
        request.getRequestDispatcher("signUporIn.jsp").forward(request, response);
        return;
    }

    User user = uDao.authenticate(email.trim(), password);

    if (user == null) {
        request.setAttribute("error_message", "Wrong email or password.");
        request.getRequestDispatcher("signUporIn.jsp").forward(request, response);
        return;
    }

    session.setAttribute("authenticated_user", user);
        if ("AGENCY".equalsIgnoreCase(user.getRole())) {
        AgencyDAO aDao = new AgencyDAO();
        Agency agency = aDao.getAgencyByUserId(user.getUserId());

        if (agency == null) {
            throw new Exception("The account is AGENCY but no agency record was found in the database.");
        }

        session.setAttribute("agencyId", agency.getAgencyId());
    } else if ("TRAVELER".equalsIgnoreCase(user.getRole())) {   
        TravelerDAO tDao = new TravelerDAO();
        Traveler traveler = tDao.getTravelerByUserId(user.getUserId());

        if (traveler == null) {
            throw new Exception("The account is TRAVELER but no traveler record was found in the database.");
        }

        session.setAttribute("travelerId", traveler.getTravelerId());
    }
    response.sendRedirect("../home/home.jsp");
    return;
} catch(Exception e) {
    request.setAttribute("error_message", e.getMessage());
    
    %>
    <jsp:forward page="signUporIn.jsp" />
    <%
}
%>