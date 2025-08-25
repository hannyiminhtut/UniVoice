<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Create Feedback</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-5">
  <div class="col-lg-6 mx-auto">
    <div class="card p-4">
      <h4 class="mb-3">Create Feedback Session</h4>
      <form action="/admin-dashboard/create-session" method="post">
        <div class="mb-3">
          <label class="form-label">Feedback Title</label>
          <input type="text" name="feedbackTitle" class="form-control" required>
        </div>
        <div class="mb-3">
          <label class="form-label">Deadline Date</label>
          <input type="date" name="deadlineDate" class="form-control" required>
        </div>
        <button class="btn btn-primary">Create & Continue</button>
      </form>
    </div>
  </div>
</div>
</body>
</html>
