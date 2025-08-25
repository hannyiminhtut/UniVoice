<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.univoice.models.FeedbackQuestions, com.univoice.models.FeedbackSession" %>
<%
  FeedbackSession sessionObj = (FeedbackSession) request.getAttribute("session");
  List<FeedbackQuestions> questions = (List<FeedbackQuestions>) request.getAttribute("questions");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Add Questions - <%= sessionObj.getTitle() %></title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <style>
    .card { border-radius: 16px; box-shadow: 0 10px 25px rgba(0,0,139,.1);}
    .star-rating i { font-size: 1.5rem; color:#ccc; cursor:pointer; }
    .star-rating .checked { color: gold; }
  </style>
</head>
<body class="bg-light">
<div class="container py-4">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h4 class="mb-0">Add Questions — <span class="text-primary"><%= sessionObj.getTitle()%></span> (Deadline: <%= sessionObj.getDeadlineDate()%>)</h4>
    <div>
      <a href="/admin-dashboard/review-session" class="btn btn-outline-primary">Review</a>
    </div>
  </div>

  <div class="row g-4">
    <!-- Form -->
    <div class="col-lg-6">
      <div class="card p-4">
        <h5 class="mb-3">New Question</h5>
        <form action="/admin-dashboard/save-question" method="post" id="qForm">
          <div class="mb-3">
            <label class="form-label">Question</label>
            <textarea name="questionText" class="form-control" rows="3" required></textarea>
          </div>

          <div class="mb-3">
            <label class="form-label">Question Type</label>
            <select name="questionType" class="form-select" id="questionType" required>
              <option value="">Select Question Type</option>
              <option value="multiple">Multiple Choice</option>
              <option value="rating">Rating</option>
            </select>
          </div>

          <!-- MCQ options -->
          <div class="mb-3" id="multipleChoiceOptions" style="display:none;">
            <label class="form-label">Options</label>
            <div id="optionsContainer"></div>
            <button type="button" class="btn btn-sm btn-outline-secondary mt-2" id="addOptBtn">➕ Add Option</button>
          </div>

          <!-- Rating advisory (kept just for info) -->
          <div class="mb-3" id="ratingInfo" style="display:none;">
            <small class="text-muted">Students will rate from 1 (Poor) to 5 (Excellent).</small>
          </div>

          <div class="text-end">
            <button class="btn btn-primary">Add Question</button>
          </div>
        </form>
      </div>
    </div>

    <!-- Current questions list -->
    <div class="col-lg-6">
      <div class="card p-4">
        <h5 class="mb-3">Current Questions (<%= questions.size()%>)</h5>
        <div class="list-group">
          <% for (FeedbackQuestions q : questions) { %>
            <div class="list-group-item">
              <div class="d-flex justify-content-between">
                <div>
                  <div class="fw-semibold"><%= q.getQuestionText() %></div>
                  <div class="small text-muted">Type: <%= q.getQuestionType()%></div>
                  <% if ("multiple".equals(q.getQuestionType()) && q.getOptions()!=null && !q.getOptions().isEmpty()) { %>
                    <ul class="mt-2 mb-0">
                      <% for (String opt : q.getOptions()) { %>
                        <li><%= opt %></li>
                      <% } %>
                    </ul>
                  <% } %>
                </div>
                <form action="/admin-dashboard/delete-question" method="post" onsubmit="return confirm('Delete this question?')">
                  <input type="hidden" name="questionId" value="<%= q.getId()%>">
                  <button class="btn btn-sm btn-outline-danger">Delete</button>
                </form>
              </div>
            </div>
          <% } %>
        </div>
        <div class="text-end mt-3">
          <a href="/admin-dashboard/review-session" class="btn btn-success">Review & Publish</a>
        </div>
      </div>
    </div>
  </div>
</div>

<script>
  const typeSel = document.getElementById('questionType');
  const mcqDiv = document.getElementById('multipleChoiceOptions');
  const ratingInfo = document.getElementById('ratingInfo');
  const container = document.getElementById('optionsContainer');
  const addBtn = document.getElementById('addOptBtn');

  typeSel.addEventListener('change', () => {
    const t = typeSel.value;
    mcqDiv.style.display = (t === 'multiple') ? 'block' : 'none';
    ratingInfo.style.display = (t === 'rating') ? 'block' : 'none';
  });

  if (addBtn) {
    addBtn.addEventListener('click', () => {
      const idx = container.children.length + 1;
      container.insertAdjacentHTML('beforeend',
        `<div class="input-group mb-2">
           <span class="input-group-text">Option ${idx}</span>
           <input type="text" name="options" class="form-control" required>
         </div>`);
    });
  }
</script>
</body>
</html>
