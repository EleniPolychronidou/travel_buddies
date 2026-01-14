<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javaclasses.User" %>
<%@ page import="javaclasses.MessageDao" %>
<%@ page import="javaclasses.Trip_memberService" %>

<%

String tripIdStr = null;
int tripId = 0;

try {
    // === DEBUGGING - Εκτύπωση όλων των παραμέτρων ===
    System.out.println("\n=== SEND MESSAGE DEBUG ===");
    System.out.println("Method: " + request.getMethod());
    System.out.println("Content-Type: " + request.getContentType());
    System.out.println("Character Encoding: " + request.getCharacterEncoding());
    
    // Εκτύπωση ΟΛΩΝ των παραμέτρων
    java.util.Enumeration<String> paramNames = request.getParameterNames();
    while(paramNames.hasMoreElements()) {
        String paramName = paramNames.nextElement();
        System.out.println("Param: " + paramName + " = " + request.getParameter(paramName));
    }
    System.out.println("=========================\n");

    User user = (User) session.getAttribute("authenticated_user");
    if (user == null) {
        System.out.println("ERROR: User not authenticated");
        response.sendRedirect("../register/signUporIn.jsp");
        return;
    }
    System.out.println("User authenticated: " + user.getUserId());


    tripIdStr = request.getParameter("tripId");
    String content = request.getParameter("message");

 
    if (tripIdStr == null || tripIdStr.trim().isEmpty()) {
        System.out.println("ERROR: Missing tripId parameter");
        request.setAttribute("error_message", "Missing trip ID.");
        request.getRequestDispatcher("Message.jsp").forward(request, response);
        return;
    }

    try {
        tripId = Integer.parseInt(tripIdStr.trim());
        System.out.println("Trip ID parsed: " + tripId);
    } catch (NumberFormatException e) {
        System.out.println("ERROR: Invalid tripId format: " + tripIdStr);
        request.setAttribute("error_message", "Invalid trip ID format.");
        request.getRequestDispatcher("../home/home.jsp").forward(request, response);
        return;
    }

    
    if (content == null || content.trim().isEmpty()) {
        System.out.println("ERROR: Empty message content");
        request.setAttribute("error_message", "Message cannot be empty.");
        request.getRequestDispatcher("Message.jsp?tripId=" + tripId).forward(request, response);
        return;
    }
    System.out.println("Message content: " + content);

   
    Trip_memberService memberService = new Trip_memberService();
    if (!memberService.isMember(tripId, user.getUserId())) {
        System.out.println("ERROR: User is not a member of trip " + tripId);
        request.setAttribute("error_message", "Only trip members can send messages.");
        request.getRequestDispatcher("Message.jsp?tripId=" + tripId).forward(request, response);
        return;
    }
    System.out.println("User is member of trip");

    // 7. Αποθήκευση μηνύματος
    MessageDao dao = new MessageDao();
    dao.sendMessage(tripId, user.getUserId(), content);
    
    System.out.println("SUCCESS: Message sent!");

    response.sendRedirect("Message.jsp?tripId=" + tripId);
    return;

} catch (Exception e) {
    // Logging του error
    System.out.println("ERROR in SendMessageController.jsp:");
    e.printStackTrace();
    
    String errorMsg = "Could not send message: " + e.getMessage();
    request.setAttribute("error_message", errorMsg);
    
    
    if (tripIdStr != null && !tripIdStr.isEmpty()) {
        try {
            request.getRequestDispatcher("Message.jsp?tripId=" + tripIdStr).forward(request, response);
        } catch (Exception forwardEx) {
            System.out.println("ERROR: Could not forward to Message.jsp");
            forwardEx.printStackTrace();
            response.sendRedirect("../home/home.jsp");
        }
    } else {
        response.sendRedirect("../home/home.jsp");
    }
}
%>