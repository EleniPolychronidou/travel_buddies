<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="appError.jsp" %>
<%@ page import="main.javaclasses.UserDAO.*" %>

<%
String email = request.getParameter("email");
String password = request.getParameter("password");

UserDAO uDao = new UserDAO();

try {

    User user = uDao.authenticate(email, password);

    session.setAttribute("authenticated_user", user);


%>    
    <jsp:forward page="home.jsp" />
<%
} catch(Exception e) {

    request.setAttribute("error_message", e.getMessage());

%>
    <jsp:forward page="signUporIn.jsp" />

<%
}
%>