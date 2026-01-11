<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.SQLIntegrityConstraintViolationException" %>
<%@ page errorPage="appError.jsp" %>
<%@ page import="main.javaclasses.UserDAO.*" %>

<%
String type        = request.getParameter("user_type");
String firstname   = request.getParameter("firstname");
String lastname    = request.getParameter("lastname");
String bday        = request.getParameter("birthDate");
String gender      = request.getParameter("gender");
String[] interests = request.getParameterValues("interests");
String business    = request.getParameter("businessname");
String phone       = request.getParameter("phone");
String address     = request.getParameter("address");
String password    = request.getParameter("password");
String email       = request.getParameter("student_email");


if (type == null && password == null && email == null) {
    throw new Exception("No parameters specified, please visit <a href='signUporIn.jsp'>registration form</a>");
}

try {
    
    uDAO.validateUser(type, firstname, lastname, bday, gender, business, phone, address, password, email);

    
    User user = new User(email, password, type);
    uService.insertUser(user);

    request.setAttribute("successMessage", "User with email " + email + " saved successfully!");
    %>
    <jsp:forward page="signUporIn.jsp"/>
    <%
    return;

} catch(SQLIntegrityConstraintViolationException e) {

    request.setAttribute("errorMessage", "User already exists.");
    %>
    <jsp:forward page="addstudent_lesson6.jsp"/>
    <%
    return;

} catch(Exception e) {

    request.setAttribute("errorMessage", e.getMessage());
    %>
    <jsp:forward page="addstudent_lesson6.jsp"/>
    <%
    return;

}
%>
