<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Help Page</title>
  <link rel="stylesheet" href="helppage.css" />
  <link rel="stylesheet" href="../style.css" />
  

</head>
<body>

 
<header>
        <jsp:include page="../home/header.jsp" />
  </header>
 

  <div class="container">
    <h2>Frequently Asked Questions</h2>

    <div class="faq">
      <button class="question">How do I access the system?</button>
      <div class="answer">To create an account, select Sign up.</div>
    </div>

    <div class="faq">
      <button class="question">How do I log in to my account?</button>
      <div class="answer">Enter your username and your password in the login form.</div>
    </div>

    <div class="faq">
      <button class="question">How do I create a trip?</button>
      <div class="answer">Fill in the required details in the Make a Trip form. Once published, the trip becomes visible to the community.</div>
    </div>

    <div class="faq">
      <button class="question">How can I report a user action?</button>
      <div class="answer">You can report inappropriate actions through the report section in your account.</div>
    </div>

    <div class="faq">
      <button class="question">My problem isn't listed. What can I do?</button>
      <div class="answer">You can write your issue in the complaint box below.</div>
    </div>

    <a class="download-link" href="odigies_xrisis.docx" download>Download full user instructions</a>

    <div class="complaint-box">
      <h3>Complaint Box</h3>
      <p>Write your problem or question here:</p>
      <form>
        <textarea placeholder="Type your message here..."></textarea>
        <button type="submit" class="submit">Submit</button>
      </form>
    </div>
  </div>

      <footer>
        <jsp:include page="../home/footer.jsp" />
      
    </footer>
  <script>
    const questions = document.querySelectorAll('.question');
    questions.forEach(btn => {
      btn.addEventListener('click', () => {
        const answer = btn.nextElementSibling;
        document.querySelectorAll('.answer').forEach(a => {
          if (a !== answer) a.style.display = 'none';
        });
        answer.style.display = (answer.style.display === 'block') ? 'none' : 'block';
      });
    });
  </script>

</body>
</html>

