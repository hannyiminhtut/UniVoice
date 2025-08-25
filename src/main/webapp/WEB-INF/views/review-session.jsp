<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.univoice.models.FeedbackQuestions, com.univoice.models.FeedbackSession" %>
<%
  FeedbackSession sessionObj = (FeedbackSession) request.getAttribute("session");
  List<FeedbackQuestions> questions = (List<FeedbackQuestions>) request.getAttribute("questions");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Review — <%= sessionObj.getTitle() %></title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-4">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <div>
      <h4 class="mb-0">Review Feedback</h4>
      <div class="text-muted">
        Title: <strong><%= sessionObj.getTitle()%></strong> |
        Deadline: <strong><%= sessionObj.getDeadlineDate()%></strong>
      </div>
    </div>
    <div>
      <a href="/admin-dashboard/add-question" class="btn btn-outline-secondary">Back to Edit</a>
    </div>
  </div>

  <div class="card p-4">
    <% if (questions.isEmpty()) { %>
      <div class="alert alert-warning">No questions added yet.</div>
    <% } else { %>
      <ol class="mb-0">
      <% for (FeedbackQuestions q : questions) { %>
        <li class="mb-3">
          <div class="fw-semibold"><%= q.getQuestionText()%></div>
          <div class="small text-muted mb-1">Type: <%= q.getQuestionType()%></div>
          <% if ("multiple".equals(q.getQuestionType()) && q.getOptions()!=null && !q.getOptions().isEmpty()) { %>
            <ul class="mb-0">
              <% for (String opt : q.getOptions()) { %>
                <li><%= opt %></li>
              <% } %>
            </ul>
          <% } %>
        </li>
      <% } %>
      </ol>
    <% } %>

    <div class="text-end mt-4">
      <form action="/admin-dashboard/publish-session" method="post">
        <button class="btn btn-success" <%= questions.isEmpty() ? "disabled" : "" %>>Publish</button>
      </form>
    </div>
  </div>
</div>
</body>
</html>
