<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.univoice.models.Department" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Edit Department — UniVoice</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="../assets/css/adminstyle.css" rel="stylesheet" />
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet"/>
  <style>
    .page-card { border:0; border-radius:14px; box-shadow:0 10px 26px rgba(0,0,0,.08); }
    .page-card .card-header { background:#fff; border-bottom:1px solid #eef2f7; }
    .avatar-lg {
      width: 72px; height: 72px; border-radius: 50%;
      object-fit: cover; border: 3px solid #e5e7eb;
    }
    .form-label { font-weight:600; }
  </style>
</head>
<body>

<nav class="navbar navbar-expand-lg bg-white shadow-sm px-3">
  <div class="container-fluid d-flex justify-content-between align-items-center">
    <div class="fw-bold fs-5">
      <a href="/admin-dashboard" class="text-decoration-none">Admin Dashboard</a>
    </div>
    <a href="/admin-dashboard/viewDept" class="btn btn-outline-secondary btn-sm">
      &larr; Back to list
    </a>
  </div>
</nav>

<div class="main-content">
  <div class="container py-4">

<%
  Department dept = (Department) request.getAttribute("dept");
  if (dept == null) {
%>
    <div class="alert alert-danger">Department not found.</div>
<%
  } else {
    String ctx = request.getContextPath();
    String action = ctx + "/admin-dashboard/departments/edit/" + dept.getId();
    String nameVal = dept.getName() != null ? dept.getName() : "";
    String emailVal = dept.getEmail() != null ? dept.getEmail() : "";
    String passVal = dept.getPassword() != null ? dept.getPassword() : "";
    String imageVal = dept.getImage() != null ? dept.getImage() : "../assets/imgs/blank-profile.webp";
%>
	<div class="noti" >

		<% if (request.getAttribute("fail") != null) { %>
		  <div class="alert alert-danger" role="alert">
		    <%= request.getAttribute("fail") %>
		  </div>
		<% } %>
		
		</div>
    <div class="card page-card">
    
    
      <div class="card-header d-flex align-items-center justify-content-between">
        <div>
          <h5 class="mb-0 fw-semibold">Edit Department</h5>
          <small class="text-muted">ID: <%= dept.getId() %></small>
        </div>
        <img class="avatar-lg" src="<%= imageVal %>" alt="Department image"
             onerror="this.src='../assets/imgs/blank-profile.webp'">
      </div>

      <div class="card-body">
        <form class="needs-validation" novalidate action="<%= action %>" method="post">
          <div class="row g-4">
            <div class="col-12 col-md-6">
              <label for="name" class="form-label">Department Name</label>
              <input type="text" id="name" name="name" class="form-control" required
                     value="<%= nameVal %>" placeholder="e.g., Computer Science">
              <div class="invalid-feedback">Please enter a department name.</div>
            </div>

            <div class="col-12 col-md-6">
              <label for="email" class="form-label">Email</label>
              <input type="email" id="email" name="email" class="form-control" required
                     value="<%= emailVal %>" placeholder="dept@example.com">
              <div class="invalid-feedback">Please provide a valid email.</div>
            </div>

            <!-- Password with eye toggle -->
            <div class="col-12 col-md-6">
              <label for="password" class="form-label">Password</label>
              <div class="input-group">
                <input type="password" id="password" name="password" class="form-control"
                       value="<%= passVal %>" placeholder="Enter new password or keep current">
                <button class="btn btn-outline-secondary" type="button" id="togglePwd"
                        aria-label="Show password">
                  <i class="fa-solid fa-eye"></i>
                </button>
              </div>
              <div class="form-text">Click the eye to view the current password.</div>
            </div>

            <!-- Image field removed intentionally (admin cannot change profile image) -->

          </div>

          <div class="d-flex gap-2 mt-4">
            <button type="submit" class="btn btn-primary">
              Save Changes
            </button>
            <a href="<%= ctx %>/admin-dashboard/viewDept" class="btn btn-outline-secondary">Cancel</a>
          </div>
        </form>
      </div>
    </div>

<% } %>

  </div>
</div>

<script>
  // Bootstrap validation
  (function () {
    'use strict';
    var forms = document.querySelectorAll('.needs-validation');
    Array.prototype.forEach.call(forms, function (form) {
      form.addEventListener('submit', function (event) {
        if (!form.checkValidity()) { event.preventDefault(); event.stopPropagation(); }
        form.classList.add('was-validated');
      }, false);
    });
  })();

  // Password eye toggle
  (function () {
    var btn = document.getElementById('togglePwd');
    var input = document.getElementById('password');
    if (btn && input) {
      btn.addEventListener('click', function () {
        var isHidden = input.getAttribute('type') === 'password';
        input.setAttribute('type', isHidden ? 'text' : 'password');
        btn.innerHTML = isHidden ? '<i class="fa-solid fa-eye-slash"></i>' : '<i class="fa-solid fa-eye"></i>';
        btn.setAttribute('aria-label', isHidden ? 'Hide password' : 'Show password');
      });
    }
  })();
  
  setTimeout(() => {
	    const alerts = document.querySelectorAll('.alert');
	    alerts.forEach(alert => alert.remove());
	}, 5000);
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
