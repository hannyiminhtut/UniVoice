<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UniVoice</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="../assets/css/adminstyle.css" rel="stylesheet" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css" referrerpolicy="no-referrer" />
</head>
<body>
<!-- Top Navbar -->
<nav class="navbar navbar-expand-lg bg-white shadow-sm px-3">
    <div class="container-fluid d-flex justify-content-between align-items-center">
        
        <div class="fw-bold fs-5 text-dark">
           <a href="/admin-dashboard" style="text-decoration:none;">Admin Dashboard</a>
        </div>

        <!-- Right-side icons and profile -->
        <div class="d-flex align-items-center gap-3">
            <!-- Message icon -->
            <a href="#" class="text-decoration-none position-relative">
                <i class="fa-solid fa-envelopes-bulk"></i>
            </a>
            <!-- Notification icon -->
            <a href="#" class="text-decoration-none position-relative">
                <i class="fa-solid fa-bell"></i>
            </a>
            <!-- Profile -->
            <div class="d-flex align-items-center">
                <img src="../assets/imgs/blank-profile.webp" class="rounded-circle me-2" width="35" height="33" style="object-fit: cover;">
                <div class="text-end">
                    <div class="fw-bold">Admin</div>
                   
                </div>
            </div>
        </div>
    </div>
</nav>


<div class="sidebar">
   

    <a href="admin-dashboard/create">➕ Create Department</a>
        <hr style="border-color: #457b9d;">
    <a href="admin-dashboard/issues">📋 View Issues</a>
        <hr style="border-color: #457b9d;">
    <a href="admin-dashboard/questions">❓ Create Feedback Questions</a>
        <hr style="border-color: #457b9d;">
    <a href="#createAnswers">📝 View Feedback Answers</a>
    	 <hr style="border-color: #457b9d;">
    <a href="admin-dashboard/logout"><i class="fa fa-sign-out" aria-hidden="true"></i>  Logout</a>
</div>

<div class="main-content">
    <div class="container-fluid">
        <div class="row">

            <!-- Department Card -->
            <div class="col-md-6 custom-box mb-4">
                <div class="dashboard-card border-info">
                    <i class="fa-solid fa-building-user fa-2x me-3 text-info"></i>
                    <div>
                        <h4 class="mb-0 fw-bold text-dark"><%= request.getAttribute("totalDept") %></h4>
                        <small class="text-dark text-muted">Departments</small>
                    </div>
                </div>
            </div>

            <!-- Student Card -->
            <div class="col-md-6 custom-box mb-4">
                <div class="dashboard-card border-teal">
                    <i class="fa-solid fa-chalkboard-user fa-2x me-3" style="color:#008080;"></i>
                    <div>
                        <h4 class="mb-0 fw-bold text-dark"><%= request.getAttribute("totalStud") %></h4>
                        <small class="text-dark text-muted">Students</small>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" ></script>
</body>
</html>