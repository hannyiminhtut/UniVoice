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
  <style>
    body {
      background: #f8faff;
      color: #0f172a;
    }

    /* Header */
    h4 {
      font-weight: 700;
      color: #000066;  /* deep navy */
    }
    .header-sub {
      color: #334155;  /* muted gray-blue */
      font-size: 0.95rem;
    }
    .header-sub strong {
      color: #0000cc;  /* brighter blue */
    }

    /* Card styling */
    .card {
      border-radius: 16px;
      border: none;
      box-shadow: 0 6px 18px rgba(0,0,0,.08);
      transition: transform .2s ease, box-shadow .2s ease;
    }
    .card:hover {
      transform: translateY(-4px);
      box-shadow: 0 10px 28px rgba(0,0,0,.15);
    }

    /* Question list */
    ol li {
      background: #ffffff;
      border-radius: 8px;
      padding: 10px 14px;
      transition: background-color .2s ease;
    }
    ol li:hover {
      background-color: #f0f4ff;
    }
    ol .fw-semibold {
      color: #000066;
    }

    /* Buttons */
    .btn-outline-secondary {
      border-radius: 8px;
    }
    .btn-success {
      border-radius: 8px;
      font-weight: 600;
      padding: 0.55rem 1.2rem;
      box-shadow: 0 4px 10px rgba(0,128,0,.15);
      transition: transform .15s ease, box-shadow .15s ease;
    }
    .btn-success:hover {
      transform: translateY(-2px);
      box-shadow: 0 6px 16px rgba(0,128,0,.25);
    }
  </style>
</head>
<body>
<div class="container py-4">
  <div class="d-flex justify-content-between align-items-center mb-4">
    <div>
      <h4 class="mb-1">Review Feedback</h4>
      <div class="header-sub">
        Title: <strong><%= sessionObj.getTitle()%></strong> |
        Deadline: <strong><%= sessionObj.getDeadline_date() %></strong>
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
