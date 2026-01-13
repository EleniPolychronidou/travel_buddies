<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="appError.jsp" %>
<%@ page import="javaclasses.UserDAO" %>
<%@ page import="javaclasses.User" %>

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
    response.sendRedirect("../home/home.jsp");
    return;
} catch(Exception e) {
    request.setAttribute("error_message", e.getMessage());
    
    %>
    <jsp:forward page="signUporIn.jsp" />
    <%
}
%>