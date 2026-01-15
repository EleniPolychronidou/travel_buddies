<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 1. Get the session if it exists
    HttpSession userSession = request.getSession(false);
    
    // 2. Clear all session data
    if (userSession != null) {
        userSession.invalidate();
    }
    
    // 3. Redirect back to the home page
    response.sendRedirect(request.getContextPath() + "/travel_buddy/main/home/home.jsp");
%>
