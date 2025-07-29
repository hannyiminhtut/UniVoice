<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UniVoice</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="./assets/css/style.css" rel="stylesheet" />
<link href="./assets/imgs/univoice.jpg" rel="icon" />
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
          <a class="nav-link text-white" aria-current="page" href="#">Home</a>
        </li>
        <li class="nav-item  ms-3">
          <a class="nav-link text-white" href="#">About</a>
        </li>
        <li class="nav-item  ms-3">
          <a class="nav-link text-white" href="#">Contact</a>
        </li>
        <li class="nav-item  ms-3">
        	<a href="/login"><button type="button" class="btn btn-light">Login</button></a>
        </li>
     
      </ul>
    </div>
  </div>
</nav>
</div>

<!--  Introduction -->
<div class="container my-5">
  <div class="row align-items-center">
    <!-- Left Side Image -->
    <div class="col-md-6 text-center">
      <img src="./assets/imgs/communication.png" alt="Feedback Icon" class="img-fluid" style="max-width: 300px;">
    </div>

    <!-- Right Side Text and Button -->
    <div class="col-md-6">
      <h2 class="mb-3 intro">Your Voice Matters</h2>
      <p class="lead">Streamline university feedback and issue reporting with our comprehensive management system.</p>
      <a href="/user/" class="btn btn-primary btn-lg mt-3 started">Get Started</a>
    </div>
  </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" ></script>
</body>
</html>