<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>signup</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="../assets/css/style.css" rel="stylesheet" />
<link href="../assets/imgs/univoice.jpg" rel="icon" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<style>
  /* --- Auth Card --- */
  /* Wrap max width reduced */
/* Wrap smaller overall */
.auth-wrap { 
  max-width: 720px;   /* narrower */
}

/* Card */
.auth-card {
  border-radius: 16px;
  overflow: hidden;
  box-shadow: 0 12px 30px rgba(0,0,0,0.25);
  
  border: 1px solid rgba(0,0,0,.05);
}

/* Form side smaller padding */
.auth-form {
  padding: 24px 22px;
}

/* Title smaller */
.auth-title {
  font-size: 1.3rem;
  margin-bottom: 12px;
}

/* Input + button slimmer */
.form-control {
  height: 40px;       /* smaller than 46px */
  font-size: 0.9rem;
  border-radius: 8px;
}
.btn-primary {
  height: 42px;
  font-size: 0.9rem;
  border-radius: 10px;
}

/* Image panel smaller vertically */
.auth-illustration {
  position: relative;
  min-height: 340px;   /* reduced from 520px */
}
.auth-illustration img {
  position:absolute; inset:0;
  width:100%; height:100%;
  object-fit: cover;
}

  .auth-sub { color:#6c757d; margin-bottom: 24px; }

 
  .form-label { font-weight: 600; }

  

  /* Small screens: stack, keep clean spacing */
  @media (max-width: 767.98px) {
    .auth-form { padding: 28px 22px; }
    .auth-illustration { min-height: 280px; }
  }
  /* Center header and sub header text */
.auth-title,
.auth-sub {
  text-align: center
 ;
}

.auth-title {
  text-align: center;
  font-size: 1.5rem;
  font-weight: 700 !important;   /* stronger than Bootstrap default */
  color: #2765e3 !important;     /* force color override */
}



</style>
</head>
<body>

<!-- Navbar (same as index.jsp) -->
<div class="container-fluid nav-custom p-0">
  <nav class="navbar navbar-expand-lg navbar-light bg-white py-3 w-100">
    <div class="container-fluid px-0">
      <a class="navbar-brand fw-bold text-primary d-flex align-items-center ms-3" href="/">
        <i class="fa-solid fa-microphone-lines me-2"></i> UniVoice
      </a>

      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
          <li class="nav-item ms-3"><a class="nav-link text-dark fw-semibold" href="/">Home</a></li>
          <li class="nav-item ms-3"><a class="nav-link text-dark fw-semibold" href="/about">About</a></li>
          <li class="nav-item ms-3"><a class="nav-link text-dark fw-semibold" href="/contact">Contact</a></li>
          <li class="nav-item ms-3">
            <a href="/login" class="btn login-btn">Login</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
</div>

<!-- Auth Split Card -->
<div class="container d-flex justify-content-center align-items-center min-vh-100">
  <div class="auth-wrap w-100">
    <div class="auth-card row g-0 bg-white">
      
      <!-- Left: form -->
      <div class="col-12 col-md-6">
        <div class="auth-form">
          <h4 class="auth-title" text-center">Create Student Account</h4>
          
          <p class="auth-sub">Welcome! Please enter your details.</p>

          <form id="signupForm" method="post" action="../register" onsubmit="return validateForm()">
            <!-- Email -->
            <div class="mb-3">
              <label for="email" class="form-label">Email address</label>
              <input type="email" class="form-control" id="email" name="email" placeholder="your@uit.edu.mm" required>
            </div>

            <!-- Name -->
            <div class="mb-3">
              <label for="name" class="form-label">Fullname</label>
              <input type="text" class="form-control" id="name" name="name" required>
            </div>

            <!-- Password -->
            <div class="mb-2">
              <label for="password" class="form-label">Password</label>
              <input type="password" class="form-control" id="password" name="password" required>
              <div id="passwordHelp" class="form-text text-danger d-none">
                Password must be at least 8 characters, include uppercase, lowercase, digit, and symbol.
              </div>
            </div>

            <!-- Confirm -->
            <div class="mb-4">
              <label for="repassword" class="form-label">Confirm Password</label>
              <input type="password" class="form-control" id="repassword" name="repassword" required>
              <div id="matchHelp" class="form-text text-danger d-none">Passwords do not match.</div>
            </div>

            <button type="submit" class="btn btn-primary w-100">Sign Up</button>
          </form>
        </div>
      </div>

      <!-- Right: image -->
      <div class="col-12 col-md-6 auth-illustration">
        <!-- Use your image path -->
        <img src="../assets/imgs/signup.png" alt="Welcome" />
      </div>

    </div>
  </div>
</div>

<!-- Validation (unchanged) -->
<script>
function validateForm() {
  const email = document.getElementById('email').value;
  const pwd = document.getElementById('password').value;
  const repwd = document.getElementById('repassword').value;

  const pwdHelp = document.getElementById('passwordHelp');
  const matchHelp = document.getElementById('matchHelp');

  const strongRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]{8,}$/;
  let isValid = true;

  // Password strength check
  if (!strongRegex.test(pwd)) {
    pwdHelp.classList.remove('d-none');
    isValid = false;
  } else {
    pwdHelp.classList.add('d-none');
  }

  // Password match check
  if (pwd !== repwd) {
    matchHelp.classList.remove('d-none');
    isValid = false;
  } else {
    matchHelp.classList.add('d-none');
  }

  // Email domain check (@uit.edu.mm)
  if (!email.endsWith('@uit.edu.mm')) {
    alert('Email must be a valid @uit.edu.mm address.');
    isValid = false;
  }

  return isValid;
}
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
