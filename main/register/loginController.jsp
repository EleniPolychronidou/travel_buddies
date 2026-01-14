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
        request.setAttribute("error_message", "Λάθος email ή κωδικός.");
        request.getRequestDispatcher("signUporIn.jsp").forward(request, response);
        return;
    }

    session.setAttribute("authenticated_user", user);
        if ("AGENCY".equalsIgnoreCase(user.getRole())) {
        AgencyDAO aDao = new AgencyDAO();
        Agency agency = aDao.getAgencyByUserId(user.getUserId());

        if (agency == null) {
            throw new Exception("Ο λογαριασμός είναι AGENCY αλλά δεν βρέθηκε εγγραφή agency στη βάση.");
        }

        session.setAttribute("agencyId", agency.getAgencyId());
    } else if ("TRAVELER".equalsIgnoreCase(user.getRole())) {   // <-- ΔΙΟΡΘΩΣΗ (2 L)
        TravelerDAO tDao = new TravelerDAO();
        Traveler traveler = tDao.getTravelerByUserId(user.getUserId());

        if (traveler == null) {
            throw new Exception("Ο λογαριασμός είναι TRAVELLER αλλά δεν βρέθηκε εγγραφή traveler στη βάση.");
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