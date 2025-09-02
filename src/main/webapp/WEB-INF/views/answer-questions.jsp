<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.univoice.models.FeedbackQuestions" %>
<%@ page import="com.univoice.models.FeedbackOptions" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Feedback Form</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    body {
        background-color: #f8f9fa;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
    .feedback-card {
        background: #fff;
        border-radius: 12px;
        box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        padding: 20px;
        margin-bottom: 20px;
        transition: transform 0.2s;
    }
    .feedback-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 12px 25px rgba(0,0,0,0.15);
    }
    .star-rating {
        font-size: 2rem;
        color: #ddd;
        cursor: pointer;
        transition: color 0.2s;
    }
    .star-rating .filled {
        color: #ffc107;
    }
    .btn-check:checked + .btn {
        background-color: #0d6efd;
        color: #fff;
    }
    .btn-check + .btn:hover {
        background-color: #0b5ed7;
        color: #fff;
    }
    h3 {
        color: #0d6efd;
        text-align: center;
        margin-bottom: 40px;
        font-weight: 700;
    }
    .question-number {
        color: #0d6efd;
        font-weight: bold;
        margin-right: 8px;
    }
</style>
</head>
<body>
<div class="container mt-5 mb-5">
<div class="noti" >
		<% if (request.getAttribute("success") != null) { %>
  			<div class="alert alert-success" role="alert">
   				 <%= request.getAttribute("success") %>
  			</div>
		<% } %>

</div>
    <h3>Answer Feedback</h3>
    <form action="submit" method="post">
        <input type="hidden" name="sessionId" value="${sessionId}">

        <%
            List<FeedbackQuestions> questions = (List<FeedbackQuestions>) request.getAttribute("questions");
            Map<Integer, List<FeedbackOptions>> optionsMap = (Map<Integer, List<FeedbackOptions>>) request.getAttribute("optionsMap");

            int qNo = 1;
            for (FeedbackQuestions q : questions) {
        %>
        <div class="feedback-card">
            <p class="fw-bold fs-5 mb-3">
                <span class="question-number"><%= qNo++ %>.</span> 
                <%= q.getQuestionText() %>
            </p>

            <% if ("multiple".equalsIgnoreCase(q.getQuestionType())) { 
                   List<FeedbackOptions> options = optionsMap.get(q.getId());
            %>
                <div class="row">
                    <% for (FeedbackOptions opt : options) { %>
                        <div class="col-md-4 mb-2">
                            <input type="radio" class="btn-check" name="q_<%= q.getId() %>" 
                                   id="q<%= q.getId() %>_<%= opt.getId() %>" 
                                   value="<%= opt.getOption_text() %>" autocomplete="off">
                            <label class="btn btn-outline-primary w-100 py-2" 
                                   for="q<%= q.getId() %>_<%= opt.getId() %>">
                                <%=  opt.getOption_text() %>
                            </label>
                        </div>
                    <% } %>
                </div>
            <% } else if ("rating".equalsIgnoreCase(q.getQuestionType())) { %>
                <div class="mt-2">
                    <div class="star-rating" data-question="q_<%= q.getId() %>">
                        <% for (int i = 1; i <= 5; i++) { %>
                            <span class="star" data-value="<%= i %>">&#9733;</span>
                        <% } %>
                    </div>
                    <input type="hidden" name="q_<%= q.getId() %>" id="q_<%= q.getId() %>_value">
                </div>
            <% } %>
        </div>
        <% } %>

        <div class="text-center mt-4">
            <button type="submit" class="btn btn-success btn-lg px-5">Submit Feedback</button>
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Star rating effect with hover
    document.querySelectorAll('.star-rating').forEach(function(starContainer) {
        const questionInputId = starContainer.getAttribute('data-question') + "_value";
        const stars = starContainer.querySelectorAll('.star');

        stars.forEach(star => {
            star.addEventListener('mouseenter', function() {
                stars.forEach(s => s.classList.remove('filled'));
                for (let i = 0; i < this.dataset.value; i++) {
                    stars[i].classList.add('filled');
                }
            });

            star.addEventListener('click', function() {
                document.getElementById(questionInputId).value = this.dataset.value;
            });

            starContainer.addEventListener('mouseleave', function() {
                const selectedValue = document.getElementById(questionInputId).value;
                stars.forEach(s => s.classList.remove('filled'));
                for (let i = 0; i < selectedValue; i++) {
                    stars[i].classList.add('filled');
                }
            });
        });
    });
</script>
</body>
</html>
