<%@ page language="java" contentType="text/html; charset=UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head><title>Error</title></head>
<body>
    <h2>Oops! Something went wrong.</h2>
    <p style="color:red;">
        Error Message: <%= exception.getMessage() %>
    </p>
    <hr>
    <a href="signUporIn.jsp">Return to Login</a>
</body>
</html>