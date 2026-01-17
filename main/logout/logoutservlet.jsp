<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
   
    HttpSession userSession = request.getSession(false);
    
   
    if (userSession != null) {
        userSession.invalidate();
    }
    
    
    response.sendRedirect(request.getContextPath() + "/travel_buddy/main/home/home.jsp");
%>
