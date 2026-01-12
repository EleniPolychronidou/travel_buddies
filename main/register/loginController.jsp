<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="appError.jsp" %>
<%@ page import="javaclasses.UserDAO" %>
<%@ page import="javaclasses.User" %>

<%
String email = request.getParameter("email");
String password = request.getParameter("password");

UserDAO uDao = new UserDAO();

try {
    User user = uDao.authenticate(email, password);
    session.setAttribute("authenticated_user", user);

    response.sendRedirect("../home/home.jsp"); 
} catch(Exception e) {
    request.setAttribute("error_message", e.getMessage());
    
    %>
    <jsp:forward page="signUporIn.jsp" />
    <%
}
%>