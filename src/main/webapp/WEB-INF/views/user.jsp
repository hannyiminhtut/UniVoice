<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>signup</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="../assets/css/style.css" rel="stylesheet" />
<link href="../assets/imgs/univoice.jpg" rel="icon" />
</head>
<body>
<!--  nav bar -->
<div class="container-fluid nav-custom" >
	<nav class="navbar navbar-expand-lg nav-custom">
  <div class="container-fluid nav-custom">
    <a class="navbar-brand text-white" href="#">UniVoice</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
        <li class="nav-item ms-3">
          <a class="nav-link text-white " aria-current="page" href="#">Home</a>
        </li>
        <li class="nav-item  ms-3">
          <a class="nav-link text-white" href="#">About</a>
        </li>
        <li class="nav-item  ms-3">
          <a class="nav-link text-white" href="#">Contact</a>
        </li>
       
     
      </ul>
    </div>
  </div>
</nav>
</div>

<!-- Sign Up form -->
<div class="container d-flex justify-content-center align-items-center min-vh-100 ">
  <div class="sign-card p-4 " >
    <h4 class="text-center fw-bold text-primary mb-4" style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;">Create Student Account</h4>
    
    <form id="signupForm" method="post" action="../register" onsubmit="return validateForm()">
      <!-- Email -->
      <div class="mb-2">
        <label for="email" class="form-label">Email address</label>
        <input type="email" 
       class="form-control" 
       id="email" 
       name="email" 
       placeholder="your@uit.edu.mm" 
       pattern="^[a-zA-Z0-9._%+-]+@uit\.edu\.mm$" 
       required>
       
	  <div id="emailHelp" class="form-text text-danger d-none">Email must end with @uit.edu.mm</div>
      </div>

      <!-- Name -->
      <div class="mb-2">
        <label for="name" class="form-label">Fullname</label>
        <input type="text" class="form-control" id="name" name="name"   required>
      </div>

      <!-- Password -->
      <div class="mb-2">
        <label for="password" class="form-label">Password</label>
        <input type="password" class="form-control" id="password" name="password"  required>
        <div id="passwordHelp" class="form-text text-danger d-none">Password must be at least 8 characters, include uppercase, lowercase, digit, and symbol.</div>
      </div>

      <!-- Retype Password -->
      <div class="mb-3">
        <label for="repassword" class="form-label">Confirm Password</label>
        <input type="password" class="form-control" id="repassword" name="repassword" required>
        <div id="matchHelp" class="form-text text-danger d-none">Passwords do not match.</div>
      </div>

      <button type="submit" class="btn btn-primary w-100">Sign Up</button>
    </form>
  </div>
</div>

<!-- form validation -->
<script>
function validateForm() {
	  const email = document.getElementById('email').value.trim();
	  const emailHelp = document.getElementById('emailHelp');
	  const pwd = document.getElementById('password').value;
	  const repwd = document.getElementById('repassword').value;
	  const pwdHelp = document.getElementById('passwordHelp');
	  const matchHelp = document.getElementById('matchHelp');

	  const strongRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]{8,}$/;
	  const emailRegex = /^[a-zA-Z0-9._%+-]+@uit\.edu\.mm$/;

	  let isValid = true;

	  // Validate email domain
	  if (!emailRegex.test(email)) {
	    emailHelp.classList.remove('d-none');
	    isValid = false;
	  } else {
	    emailHelp.classList.add('d-none');
	  }

	  // Validate strong password
	  if (!strongRegex.test(pwd)) {
	    pwdHelp.classList.remove('d-none');
	    isValid = false;
	  } else {
	    pwdHelp.classList.add('d-none');
	  }

	  // Validate matching passwords
	  if (pwd !== repwd) {
	    matchHelp.classList.remove('d-none');
	    isValid = false;
	  } else {
	    matchHelp.classList.add('d-none');
	  }

	  return isValid;
	}
</script>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" ></script>
</body>
</html>