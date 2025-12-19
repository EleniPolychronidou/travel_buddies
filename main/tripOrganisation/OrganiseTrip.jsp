<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
  <!DOCTYPE html>
  <html lang="en">
  <head>
    <meta charset="UTF-8" />
    <link rel="stylesheet" href="OrganiseTrip.css" />
    <link rel="stylesheet" href="../styleforcss/style.css" />
    <link
      href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap"
      rel="stylesheet"
    />

  <title>Organise A Trip </title>
  </head>

  <body>

    
  
    <header>
    <header>
        <jsp:include page="../home/header.jsp" />
  </header>
    </header>
  
    <form id="newTripForm">
      <h2 style="margin-top:0;margin-bottom:6px">Suggest a new trip</h2>
      <p style="margin-top:0;color:var(--muted);font-size:13px"></p>

      <label for="tripTitle">Trip Title:<span style="color: red">*</span></label>
      <input type="text" id="tripTitle" placeholder=" Fun Weekend in Paris " required>
      <label for="destination">Destination:<span style="color: red">*</span></label>
      <input type="text" id="destination" placeholder=" Paris, France " required>
      <label for="travelPurpose"> Travel Purpose:<span style="color: red">*</span></label>
      <select id="deviceType"  required>
      <div class="options">
        <option>Recreation</option>
          <option>Adventure</option>
          <option>Cultural</option>
          <option>Business</option>
          <option>Food & Wine</option>
      </div>
      </select>
      
      <div style="display:flex; gap:20px; justify-content: space-between; margin-bottom: 10px;">
          <div style="fleX :1;">
          <label for="start">Start date</label>
          <input id="start" type="date" style="width: 100%; padding: 8px; border-radius: 6px; border: 1px solid #546D79;">
          </div>
          <div style="flex:1;">
          <label for="end">End date</label>
          <input id="end" type="date" style="width: 100%; padding: 8px; border-radius: 6px; border: 1px solid #546D79;">
          </div>
      </div>
      
      <div>
          <label for="budget">Budget range (€)</label>
          <input id="budget" type="text" placeholder="200 - 600">
      </div>

      <label for="tripDescription">Trip description:</label>
      <textarea id="comments" name="comments" rows="4"></textarea>
      <button type="reset">Reset</button>
      <button type="submit">Publish Trip</button>



    </form>
    
    <script src="serialfields.js"></script>
    <script src="date.js"></script>
    <script src="confirmation.js"></script>

    <footer>
        <jsp:include page="../home/footer.jsp" />
      
    </footer>
  </body>
  </html>