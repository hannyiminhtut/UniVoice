<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.univoice.models.Issue" %>
<%@ page import="com.univoice.models.Department" %>
<%@ page import="java.util.List" %>
<%
	Issue issue = (Issue)request.getAttribute("issue");
	String title = issue.getTitle();
	String des = issue.getDescription();
	String location = issue.getLocation();
	String createdAt = issue.getCreated_at();
	String imagePath = issue.getImg();
	

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UniVoice</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css"  crossorigin="anonymous" referrerpolicy="no-referrer" />
<style>
body {
            background-color: #f4f6fa 
        }
        
	.navbar {
		    height: 65px;
		    border-bottom: 1px solid #eee;
		    font-family: 'Segoe UI', sans-serif;
		}
		
	.issue-card {
            max-width: 800px;
            margin: 40px auto;
            background: #fff;
            border-radius: 15px;
            box-shadow: 0px 4px 12px rgba(0,0,0,0.1);
            overflow: hidden;
            transition: 0.3s;
        }
        .issue-card:hover {
            transform: translateY(-3px);
            box-shadow: 0px 6px 18px rgba(0,0,0,0.15);
        }
        .issue-header {
            background: linear-gradient(135deg, #0d6efd, #4dabf7);
            color: white;
            padding: 20px;
        }
        .issue-body {
            padding: 20px;
        }
        .issue-body p {
            font-size: 1rem;
            color: #333;
        }
        .issue-footer {
            padding: 15px;
            background: #f9f9f9;
            border-top: 1px solid #eee;
            text-align: right;
        }
        .issue-img {
            max-width: 100%;
            border-radius: 10px;
            margin-top: 15px;
        }

</style>
</head>
<body>
<!-- Top Navbar -->
<nav class="navbar navbar-expand-lg bg-white shadow-sm px-3">
    <div class="container-fluid d-flex justify-content-between align-items-center">
        
     <div class="d-flex align-items-center gap-3">
	    <div class="fw-bold fs-5 text-dark"><a href="/admin-dashboard" style="text-decoration:none;">Admin Dashboard</a></div>
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
                <img src="../../assets/imgs/blank-profile.webp" class="rounded-circle me-2" width="35" height="33" style="object-fit: cover;">
                <div class="text-end">
                    <div class="fw-bold">Admin</div>
                   
                </div>
            </div>
        </div>
    </div>
</nav>

<div class="issue-card">
    <div class="issue-header">
        <h3><i class="fa-solid fa-triangle-exclamation me-2"></i><%= title %></h3>
        <small><i class="fa-regular fa-calendar-alt me-1"></i> Submitted on <%= createdAt %></small>
    </div>
    <div class="issue-body">
        <p><i class="fa-solid fa-align-left me-2"></i> <strong>Description:</strong> <%= des %></p>
        

        <p><i class="fa-solid fa-location-dot me-2 text-danger"></i> <strong>Location:</strong> <%= location %></p>

        <% if (imagePath != null && !imagePath.isEmpty()) { %>
            <p><i class="fa-solid fa-image me-2"></i> <strong>Attached Image:</strong></p>
            <img src="<%=imagePath  %>" class="issue-img" alt="Issue Image">
        <% } %>
    </div>
   <div class="issue-footer d-flex justify-content-between align-items-center">
    <a href="../issues" class="btn btn-secondary">
        <i class="fa-solid fa-arrow-left"></i> Back to Issues
    </a>

    <form action="<%= request.getContextPath() %>/admin/issues/assign" method="POST" class="d-inline">
        <input type="hidden" name="issueId" value="<%= issue.getIssue_id() %>">
        
        <div class="input-group">
            <select class="form-select" name="departmentId" required>
                <option value="" disabled selected>Select Department</option>
                <%
                    List<Department> departments = (List<Department>)request.getAttribute("departments");
                    if (departments != null) {
                        for (Department dept : departments) {
                %>
                    <option value="<%= dept.getId() %>"><%= dept.getName() %></option>
                <%
                        }
                    }
                %>
            </select>
            <button type="submit" class="btn btn-success">
                <i class="fa-solid fa-paper-plane"></i> Assign
            </button>
        </div>
    </form>
</div>
   
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" ></script>
</body>
</html>