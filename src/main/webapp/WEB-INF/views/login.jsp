<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="../assets/css/login.css" rel="stylesheet" />
<link href="../assets/imgs/univoice.jpg" rel="icon" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" referrerpolicy="no-referrer" />


</head>
<body>

<!-- Navbar (same as signup) -->
<div class="container-fluid nav-custom p-0">
  <nav class="navbar navbar-expand-lg navbar-light bg-white py-3 w-100">
    <div class="container-fluid px-0">
      <a class="navbar-brand fw-bold text-primary d-flex align-items-center ms-3" href="<c:url value='/'/>">
        <i class="fa-solid fa-microphone-lines me-2"></i> UniVoice
      </a>

      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
          <li class="nav-item ms-3"><a class="nav-link text-dark fw-semibold" href="<c:url value='/'/>">Home</a></li>
          <li class="nav-item ms-3"><a class="nav-link text-dark fw-semibold" href="<c:url value='/about'/>">About</a></li>
          <li class="nav-item ms-3"><a class="nav-link text-dark fw-semibold" href="<c:url value='/contact'/>">Contact</a></li>
          <li class="nav-item ms-3">
            <a href="<c:url value='/login'/>" class="btn login-btn">Login</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
</div>

<!-- Split login card -->
<div class="container login-wrapper">
  <div class="auth-card">

    <!-- LEFT: form -->
    <div class="auth-form">

      <% String fail = (String) request.getAttribute("fail"); %>
      <% if (fail != null && !fail.isEmpty()) { %>
        <div class="alert alert-danger" role="alert"><%= fail %></div>
      <% } %>

      <h4 class="auth-title">Access Your Account</h4>

      <form method="POST" action="/check">
        <div class="mb-3">
          <label for="email" class="form-label">Email address</label>
          <input type="email" class="form-control" name="email" id="email" required>
        </div>

        <div class="mb-4">
          <label for="password" class="form-label">Password</label>
          <input type="password" class="form-control" name="password" id="password" required>
        </div>

        <button type="submit" class="btn btn-primary w-100 btn-auth">Login</button>
      </form>
    </div>

    <!-- RIGHT: gradient welcome (no image) -->
    <div class="auth-side">
      <div>
        <h3>Welcome back 👋</h3>
        <p>
          Together we build a safer, smarter, and better university.
        </p>
      </div>
    </div>

  </div>
</div>


<script>
  setTimeout(() => document.querySelectorAll('.alert').forEach(a => a.remove()), 3000);
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
