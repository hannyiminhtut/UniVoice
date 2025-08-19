<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.univoice.models.Student" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UniVoice</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css" referrerpolicy="no-referrer" />
<style>
    body {
        background-color: #f0e9ff;
        font-family: 'Segoe UI', sans-serif;
    }

    /* Sidebar */
    .sidebar {
        background: linear-gradient(180deg, #8e2de2, #6c63ff);
        color: white;
        min-height: 100vh;
        padding-top: 30px;
        border-radius: 10px;
        position: fixed;
        margin-left:10px;
       
    }
    .sidebar a {
        color: white;
        text-decoration: none;
        display: block;
        padding: 12px 20px;
        border-radius: 15px;
        transition: background 0.3s ease;
    }
    .sidebar a:hover {
        background-color: rgba(255, 255, 255, 0.15);
    }
    .sidebar .menu-icon {
        margin-right: 10px;
    }
    
    .main-content{
    	margin-left:240px;
    	max-width:175vh;
    }

    /* Cards */
    .custom-card {
        border-radius: 15px;
        background: white;
        padding: 20px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        transition: transform 0.2s ease, box-shadow 0.2s ease;
    }
    .custom-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 6px 15px rgba(0,0,0,0.15);
    }

    /* Profile */
    .profile-img {
        width: 50px;
        height: 50px;
        border-radius: 50%;
        object-fit: cover;
        border: 2px solid #6c63ff;
    }

    /* Finance Cards */
    .finance-icon {
        font-size: 30px;
        color: #6c63ff;
        margin-bottom: 10px;
    }

    /* Smooth fade-in */
    .fade-in {
        opacity: 0;
        transform: translateY(20px);
        animation: fadeInUp 0.6s ease forwards;
    }
    @keyframes fadeInUp {
        to {
            opacity: 1;
            transform: translateY(0);
        }
 
    }
    
 
</style>
</head>
<body>
	<div class="container-fluid">
    <div class="row">
        
        <!-- Sidebar -->
        <div class="col-md-2 sidebar">
            <div class="text-center mb-4">
                <i class="fa-solid fa-graduation-cap fa-2x"></i>
            </div>
            <a href="#"><i class="fa-solid fa-gauge-high menu-icon"></i> Dashboard</a>
            <a href="#"><i class="fa-solid fa-user menu-icon"></i> Profile</a>
            <a href="student-dashboard/submitIssues"><i class="fa-solid fa-pen menu-icon"></i> Submit Issues </a>
            <a href="#"><i class="fa-solid fa-chart-line menu-icon"></i> Issues Result</a>
            <a href="#"><i class="fa-solid fa-book menu-icon"></i> Feedback</a>
            <a href="#"><i class="fa-solid fa-bullhorn menu-icon"></i> Contact Admin</a>
            <a href="student-dashboard/logout"><i class="fa-solid fa-right-from-bracket menu-icon"></i> Logout</a>
        </div>

        <!-- Main Content -->
        <div class="col-md-10 p-4 main-content">
        	<div class="container-fluid">

            <!-- Top Bar -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <input type="text" class="form-control w-50" placeholder="Search...">
                <div class="d-flex align-items-center gap-3">
                    <span>John Doe<br><small class="text-muted">3rd year</small></span>
                    <img src="https://i.pravatar.cc/50" alt="Profile" class="profile-img">
                </div>
            </div>
			<%
			    Student student = (Student) session.getAttribute("student");
			    String studentName = (student != null) ? student.getName() : "Guest";
			%>
            <!-- Welcome Card -->
            <div class="custom-card mb-4 fade-in" style="background: linear-gradient(90deg, #6c63ff, #8e2de2); color: white;">
                <h5><%= java.time.LocalDate.now() %></h5>
                <h4>Welcome back, <%=studentName %></h4>
                <p>Always stay updated in your student dashboard</p>
            </div>

            <!-- Finance Section -->
            <h4>Finance</h4>
            <div class="row g-3 mb-4">
                <div class="col-md-4 fade-in">
                    <div class="custom-card text-center">
                        <i class="fa-solid fa-sack-dollar finance-icon"></i>
                        <h5>$10,000</h5>
                        <p class="text-muted">Total Payable</p>
                    </div>
                </div>
                <div class="col-md-4 fade-in" style="animation-delay:0.1s">
                    <div class="custom-card text-center">
                        <i class="fa-solid fa-hand-holding-dollar finance-icon"></i>
                        <h5>$5,000</h5>
                        <p class="text-muted">Total Paid</p>
                    </div>
                </div>
                <div class="col-md-4 fade-in" style="animation-delay:0.2s">
                    <div class="custom-card text-center">
                        <i class="fa-solid fa-chart-column finance-icon"></i>
                        <h5>$300</h5>
                        <p class="text-muted">Others</p>
                    </div>
                </div>
            </div>

            <!-- Courses Section -->
            <h4>Enrolled Courses</h4>
            <div class="row g-3 mb-4">
                <div class="col-md-6 fade-in">
                    <div class="custom-card d-flex justify-content-between align-items-center">
                        <span>Object Oriented Programming</span>
                        <button class="btn btn-outline-primary">View</button>
                    </div>
                </div>
                <div class="col-md-6 fade-in" style="animation-delay:0.1s">
                    <div class="custom-card d-flex justify-content-between align-items-center">
                        <span>Fundamentals of Database Systems</span>
                        <button class="btn btn-outline-primary">View</button>
                    </div>
                </div>
            </div>

            <!-- Notice Section -->
            <div class="row g-3">
                <div class="col-md-6 fade-in">
                    <div class="custom-card">
                        <h6>Prelim Payment Due</h6>
                        <p class="text-muted">Sorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                        <a href="#">See more</a>
                    </div>
                </div>
                <div class="col-md-6 fade-in" style="animation-delay:0.1s">
                    <div class="custom-card">
                        <h6>Exam Schedule</h6>
                        <p class="text-muted">Nunc vulputate libero et velit interdum, ac aliquet odio mattis.</p>
                        <a href="#">See more</a>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- Animation Delay -->
<script>
    document.querySelectorAll('.fade-in').forEach((el, index) => {
        el.style.animationDelay = `${index * 0.1}s`;
    });
</script>
</body>
</html>