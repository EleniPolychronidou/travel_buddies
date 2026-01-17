<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="models.Message" %>
<%@ page import="services.MessageService" %>

<%
    int tripId = Integer.parseInt(request.getParameter("trip_id"));
    int currentUserId = (Integer) session.getAttribute("user_id"); 
    
    MessageService messageService = new MessageService();
    
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String content = request.getParameter("content");
        messageService.sendMessage(currentUserId, tripId, content);
    }
    
    List<Message> messages = messageService.getTripChatHistory(tripId);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Trip Chat</title>
    <style>
        .chat-box { width: 400px; height: 300px; border: 1px solid #ccc; overflow-y: scroll; padding: 10px; }
        .message { margin-bottom: 10px; padding: 5px; border-radius: 5px; }
        .sent { background-color: #e1ffc7; text-align: right; }
        .received { background-color: #f1f1f1; }
    </style>
</head>
<body>

    <h2>Trip #<%= tripId %> Chat</h2>

    <div class="chat-box">
        <% for (Message m : messages) { %>
            <div class="message <%= (m.getSender_id() == currentUserId) ? "sent" : "received" %>">
                <strong>User <%= m.getSender_id() %>:</strong>
                <p><%= m.getContent() %></p>
                <small><%= m.getSend_date() %></small>
            </div>
        <% } %>
    </div>

    <form method="post">
        <input type="hidden" name="trip_id" value="<%= tripId %>">
        <textarea name="content" placeholder="Type a message..." required></textarea>
        <button type="submit">Send</button>
    </form>

</body>
</html>
