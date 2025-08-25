<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="../assets/css/login.css" rel="stylesheet" />
<link href="../assets/imgs/univoice.jpg" rel="icon" />

</head>
<body>

<!--  Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top nav-custom">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">UniVoice</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
        <li class="nav-item ms-3">
          <a class="nav-link text-white" href="#">Home</a>
        </li>
        <li class="nav-item ms-3">
          <a class="nav-link text-white" href="#">About</a>
        </li>
        <li class="nav-item ms-3">
          <a class="nav-link text-white" href="#">Contact</a>
        </li>
        <li class="nav-item ms-3">
          <button type="button" class="btn btn-light ">Login</button>
        </li>
      </ul>
    </div>
  </div>
</nav>

<!-- Login Form -->
<div class="login-card mt-4">
    <h4 class="text-center fw-bold text-primary mb-4" style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;">Access Your Account</h4>
    <form method="POST" action="/check">
        <div class="mb-3">
            <label for="email" class="form-label">Email address</label>
            <input type="email" class="form-control" name="email" id="email" required>
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" name="password" id="password" required>
        </div>
		
		<!-- select user 
        <div class="mb-5">
            <label for="userType" class="form-label">Choose User :</label>
            <select class="form-select" name="userType" id="userType" required>
                <option value="">Select user</option>
                <option value="student">Student</option>
                <option value="admin">Admin</option>
                <option value="department">Department</option>
            </select>
        </div> -->

        <div class="d-grid">
            <button type="submit" class="btn btn-primary w-100">Login</button>
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
