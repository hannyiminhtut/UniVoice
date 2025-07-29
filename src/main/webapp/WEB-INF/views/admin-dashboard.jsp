<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="../assets/css/adminstyle.css" rel="stylesheet" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css" referrerpolicy="no-referrer" />
</head>
<body>
<!-- Top Navbar -->
<nav class="navbar navbar-expand-lg bg-white shadow-sm px-3">
    <div class="container-fluid d-flex justify-content-between align-items-center">
        
        <div class="fw-bold fs-5 text-dark">
           Admin Dashboard
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
   

    <a href="#createDepartment">➕ Create Department</a>
        <hr style="border-color: #457b9d;">
    <a href="#viewIssues">📋 View Issues</a>
        <hr style="border-color: #457b9d;">
    <a href="#createQuestions">❓ Create Feedback Questions</a>
        <hr style="border-color: #457b9d;">
    <a href="#createAnswers">📝 View Feedback Answers</a>
</div>

<div class="main-content">
    <div class="container-fluid">
        

        <div class="row g-4">
            <div class="col-md-6" id="createDepartment">
                <div class="card p-4">
                    <h5>Create Department</h5>
                    <form>
                        <div class="mb-3">
                            <label class="form-label">Department Name</label>
                            <input type="text" class="form-control" placeholder="Enter department name">
                        </div>
                        <button class="btn btn-primary">Create</button>
                    </form>
                </div>
            </div>

            <div class="col-md-6" id="viewIssues">
                <div class="card p-4">
                    <h5>View Reported Issues</h5>
                    <ul class="list-group mt-3">
                        <li class="list-group-item d-flex justify-content-between">
                            <span>Network issue in CS Lab</span> <span class="badge bg-warning">Pending</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between">
                            <span>Projector not working</span> <span class="badge bg-success">Resolved</span>
                        </li>
                        <!-- Dynamic list items from backend -->
                    </ul>
                </div>
            </div>

            <div class="col-md-6" id="createQuestions">
                <div class="card p-4">
                    <h5>Create Feedback Questions</h5>
                    <form>
                        <div class="mb-3">
                            <label class="form-label">Question</label>
                            <input type="text" class="form-control" placeholder="Enter question text">
                        </div>
                        <button class="btn btn-success">Add Question</button>
                    </form>
                </div>
            </div>

            <div class="col-md-6" id="createAnswers">
                <div class="card p-4">
                    <h5>Create Feedback Answers</h5>
                    <form>
                        <div class="mb-3">
                            <label class="form-label">Answer Option</label>
                            <input type="text" class="form-control" placeholder="Enter answer option">
                        </div>
                        <button class="btn btn-success">Add Answer</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" ></script>
</body>
</html>