<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
  <html lang="en">
  <head>
    <meta charset="UTF-8" />
    <link rel="stylesheet" href="OrganiseTrip.css" />
    <link rel="stylesheet" href="../styleforcss/style.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link
      href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap"
      rel="stylesheet"
    />

  <title class="title">Organise A Trip </title>
  </head>

  <body>

    
  
    <header>
    <header>
        <jsp:include page="../home/header.jsp" />
  </header>
    </header>
   <% if (request.getAttribute("success_message") != null) { %>
    <div class="alert alert-success">
        <%= request.getAttribute("success_message") %>
    </div>
<% } %>

<% if (request.getAttribute("error_message") != null) { %>
    <div class="alert alert-danger">
        <%= request.getAttribute("error_message") %>
    </div>
<% } %>
  
    <form id="newTripForm" action="OrganiseTripController.jsp" method="post">
      <h2 style="margin-top:0;margin-bottom:6px">Organise a new trip</h2>
      <p style="margin-top:0;color:var(--muted);font-size:13px"></p>

      <label for="tripTitle">Trip Title:<span style="color: red">*</span></label>
      <input type="text" id="tripTitle" name="title" placeholder=" Fun Weekend in Paris " required>
      <label for="destination">Destination:<span style="color: red">*</span></label>
      <input type="text" id="destination" name="destination" placeholder=" Paris, France " required>

      <label for="travelPurpose"> Travel Purpose:<span style="color: red">*</span></label>
      <select id="travelPurpose" name="purpose" required>
      <option style=" color: black;">-- Select purpose --</option>
      <option style=" color: black;"value="Recreation">Recreation</option>
      <option style=" color: black;" value="Adventure">Adventure</option>
      <option style=" color: black;" value="Cultural">Cultural</option>
      <option style=" color: black;" value="Business">Business</option>
      <option style=" color: black;" value="Food & Wine">Food & Wine</option>
    </select>
      
      <div style="display:flex; gap:20px; justify-content: space-between; margin-bottom: 10px;">
          <div style="fleX :1;">
          <label for="start">Start date</label>
          <input id="start" name="start" type="date" style="width: 100%; padding: 8px; border-radius: 6px; border: 1px solid #546D79;">
          </div>
          <div style="flex:1;">
          <label for="end">End date</label>
          <input id="end" name="end" type="date" style="width: 100%; padding: 8px; border-radius: 6px; border: 1px solid #546D79;">
          </div>
      </div>
      
      <div>
          <label for="budget">Budget range (€)</label>
          <input id="budget" name="avgCost" type="number" step="0.01" min="0" type="text" placeholder="200">
      </div>

      <label for="tripDescription">Trip description:</label>
      <textarea id="tripDescription" name="description" rows="4"></textarea>
      <button  class= button type="reset">Reset</button>
      <button class= button type="submit">Publish Trip</button>



    </form>
    
    <script src="serialfields.js"></script>
    <script src="date.js"></script>
    <script src="confirmation.js"></script>

    <footer>
        <jsp:include page="../home/footer.jsp" />
      
    </footer>
  </body>
  </html>
