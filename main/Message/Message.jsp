<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="javaclasses.User" %>
<%@ page import="javaclasses.Message" %>
<%@ page import="javaclasses.MessageDao" %>
<%@ page import="javaclasses.Trip_memberService" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Trip Chat</title>

  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/css/bootstrap.min.css">

  <style>
    body { background:#f3f3f3; }
    .chat-box { max-width: 800px; margin: 20px auto; background:#fff; border-radius:12px; padding:20px; box-shadow:0 4px 10px rgba(0,0,0,.12); }
    .messages { max-height: 450px; overflow-y: auto; padding: 10px; background:#fafafa; border-radius:10px; border:1px solid #eee; margin-bottom: 15px; }
    .msg { padding:10px 12px; margin:8px 0; border-radius:12px; display:inline-block; max-width:75%; word-wrap: break-word; }
    .mine { background:#546D79; color:#fff; float:right; clear:both; }
    .theirs { background:#e9ecef; color:#333; float:left; clear:both; }
    .meta { font-size: 11px; opacity: .7; margin-top: 4px; }
    .clearfix { clear: both; }
  </style>
</head>
<body>

<%
try {
    User user = (User) session.getAttribute("authenticated_user");
    if (user == null) {
        response.sendRedirect("../register/signUporIn.jsp");
        return;
    }

    String tripIdStr = request.getParameter("tripId");
    if (tripIdStr == null || tripIdStr.trim().isEmpty()) {
%>
        <div class="container">
            <div class="alert alert-danger">Missing trip ID parameter.</div>
            <a href="../home/home.jsp" class="btn btn-default">← Back to Home</a>
        </div>
<%
        return;
    }

    int tripId = 0;
    try {
        tripId = Integer.parseInt(tripIdStr.trim());
    } catch (NumberFormatException e) {
%>
        <div class="container">
            <div class="alert alert-danger">Invalid trip ID format.</div>
            <a href="../home/home.jsp" class="btn btn-default">← Back to Home</a>
        </div>
<%
        return;
    }

    Trip_memberService memberService = new Trip_memberService();
    if (!memberService.isMember(tripId, user.getUserId())) {
%>
        <div class="container">
            <div class="alert alert-danger">Only trip members can access this chat.</div>
            <a href="../findatrip/viewdetails.jsp?tripId=<%= tripId %>" class="btn btn-default">← Back to Trip</a>
        </div>
<%
        return;
    }

    MessageDao dao = new MessageDao();
    List<Message> messages = dao.getMessagesByTrip(tripId);

    // 5. Λήψη error/success messages
    String errorMsg = (String) request.getAttribute("error_message");
    String successMsg = (String) request.getAttribute("successMessage");
%>

<div class="chat-box">
  <h3 style="margin-top:0; color:#546D79;">Trip Chat</h3>

  <% if (errorMsg != null) { %>
    <div class="alert alert-danger alert-dismissible">
      <button type="button" class="close" data-dismiss="alert">&times;</button>
      <%= errorMsg %>
    </div>
  <% } %>
  
  <% if (successMsg != null) { %>
    <div class="alert alert-success alert-dismissible">
      <button type="button" class="close" data-dismiss="alert">&times;</button>
      <%= successMsg %>
    </div>
  <% } %>

  <div class="messages" id="messagesContainer">
    <% 
    if (messages != null && !messages.isEmpty()) {
        for (Message msg : messages) {
            boolean isMine = (msg.getSender_id() == user.getUserId());
            String content = msg.getContent() != null ? msg.getContent() : "";
            String dateStr = "";
            if (msg.getSend_date() != null) {
                dateStr = msg.getSend_date().toString().replace("T", " ");
                if (dateStr.length() > 16) {
                    dateStr = dateStr.substring(0, 16);
                }
            }
    %>
      <div class="msg <%= isMine ? "mine" : "theirs" %>">
        <div><%= content %></div>
        <div class="meta"><%= dateStr %></div>
      </div>
      <div class="clearfix"></div>
    <% 
        }
    } else { 
    %>
      <div class="text-center text-muted" style="padding: 30px;">
        No messages yet. Start the conversation!
      </div>
    <% } %>
  </div>

  <form action="SendMessageController.jsp" method="POST" accept-charset="UTF-8" id="messageForm">
    <input type="hidden" name="tripId" value="<%= tripId %>">

    <div class="form-group" style="margin-bottom: 10px;">
      <input type="text" 
             name="message" 
             id="messageInput"
             class="form-control" 
             placeholder="Write a message..." 
             required 
             maxlength="500"
             autocomplete="off">
    </div>

    <button type="submit" class="btn btn-primary" style="background:#546D79; border-color:#546D79;">
      Send Message
    </button>
    
    <a class="btn btn-default" href="../findatrip/viewdetails.jsp?tripId=<%= tripId %>">
      ← Back to Trip
    </a>
  </form>
</div>

<script>
// Auto-scroll to bottom
window.addEventListener('DOMContentLoaded', function() {
    const container = document.getElementById('messagesContainer');
    if (container) {
        container.scrollTop = container.scrollHeight;
    }
    
    // Focus στο input field
    const input = document.getElementById('messageInput');
    if (input) {
        input.focus();
    }
});

// Αποτροπή double-submit
document.getElementById('messageForm').addEventListener('submit', function(e) {
    const btn = this.querySelector('button[type="submit"]');
    btn.disabled = true;
    btn.textContent = 'Sending...';
});
</script>

<%
} catch (Exception e) {
    e.printStackTrace();
%>
    <div class="container">
        <div class="alert alert-danger">
            <strong>Error:</strong> <%= e.getMessage() %>
        </div>
        <a href="../home/home.jsp" class="btn btn-default">← Back to Home</a>
    </div>
<%
}
%>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/js/bootstrap.min.js"></script>

</body>
</html>