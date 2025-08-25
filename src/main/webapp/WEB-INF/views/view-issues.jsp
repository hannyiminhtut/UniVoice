<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.univoice.models.Issue" %>
<%@ page import="java.util.List" %>
<%
    List<Issue> issues = (List<Issue>) request.getAttribute("issues");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UniVoice</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css"  crossorigin="anonymous" referrerpolicy="no-referrer" />
<link href="../assets/css/view-issues.css" rel="stylesheet" />
</head>
<body>
<!-- Top Navbar -->
<%
    // Count issues that have resolution notes
    int noteCount = 0;
    if (issues != null) {
        for (Issue i : issues) {
            if (i.getNote() != null && !i.getNote().trim().isEmpty() && !i.getNote_read()) {
                noteCount++;
            }
        }
    }
%>
<nav class="navbar navbar-expand-lg bg-white shadow-sm px-3">
    <div class="container-fluid d-flex justify-content-between align-items-center">

        <!-- Left: Title -->
        <div class="fw-bold fs-5 text-dark">
            <a href="/admin-dashboard" style="text-decoration:none;">Admin Dashboard</a>
        </div>

        <!-- Right-side icons and profile -->
        <div class="d-flex align-items-center gap-4">

            <!-- Envelope -->
            <a href="<%= request.getContextPath() %>/admin-dashboard/issues/notes" 
               class="text-decoration-none position-relative d-flex align-items-center">
                <i class="fa-solid fa-envelopes-bulk fs-5"></i>
            </a>

			<a href="#" id="bellBtn" class="text-decoration-none position-relative d-flex align-items-center">
			    <i class="fa-solid fa-bell fs-5"></i>
			    <% if (noteCount > 0) { %>
			        <span id="bellCount" class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
			            <%= noteCount %>
			        </span>
			    <% } %>
			</a>


            <!-- Profile -->
            <div class="d-flex align-items-center">
                <img src="../assets/imgs/blank-profile.webp" 
                     class="rounded-circle" width="35" height="35" style="object-fit: cover;">
                <div class="ms-2">
                    <div class="fw-bold">Admin</div>
                </div>
            </div>
        </div>
    </div>
</nav>


<div class="container my-4">
    <h4 class="text-center page-title mb-4">
        <i class="fa-solid fa-list-check me-2 text-primary"></i> Submitted Issues
    </h4>
    
    <!-- noti -->
	<div class="row">
		<div class="col-md-12">
			
		<% if (request.getAttribute("success") != null) { %>
  			<div class="alert alert-success" role="alert">
   				 <%= request.getAttribute("success") %>
  			</div>
		<% } %>

		<% if (request.getAttribute("fail") != null) { %>
		  <div class="alert alert-danger" role="alert">
		    <%= request.getAttribute("fail") %>
		  </div>
		<% } %>
		
		</div>
	
	</div>
    <div class="row">
        <%
            if (issues != null && !issues.isEmpty()) {
                int delay = 0;
                for (Issue issue : issues) {
        %>
 <div class="col-md-4 mb-4 fade-in" style="animation-delay: <%= delay %>ms;">
    <a href="<%= request.getContextPath() %>/admin-dashboard/issues/<%= issue.getIssue_id() %>" 
       style="text-decoration: none; color: inherit;" 
       class="issue-card-link position-relative" data-issue-id="<%= issue.getIssue_id() %>">

        <div class="issue-card p-3 position-relative">
            <h5 class="issue-title">
                <i class="fa-solid fa-bug text-danger me-2"></i> <%= issue.getTitle() %>
            </h5>
            <p class="issue-date mt-2">
                <i class="fa-regular fa-calendar-days me-1"></i> <%= issue.getCreated_at() %>
            </p>
            <p class="issue-status mt-2">
                <% if ("pending".equalsIgnoreCase(issue.getStatus())) { %>
                    <span class="badge bg-danger"><i class="fa-solid fa-clock me-1"></i> Pending</span>
                <% } else if ("assigned".equalsIgnoreCase(issue.getStatus())) { %>
                    <span class="badge bg-warning text-dark"><i class="fa-solid fa-user-check me-1"></i> Assigned</span>
                <% } else if ("resolved".equalsIgnoreCase(issue.getStatus())) { %>
                    <span class="badge bg-success"><i class="fa-solid fa-circle-check me-1"></i> Resolved</span>
                <% } %>
            </p>

            <% if (issue.getNote() != null && !issue.getNote().trim().isEmpty() && !issue.getNote_read()) { %>
    			 <span class="unread-dot position-absolute"></span>
			<% } %>
        </div>
    </a>
</div>
        <%
                    delay += 150; // staggered animation effect
                }
            } else {
        %>
            <p class="text-center text-muted">No issues submitted yet.</p>
        <%
            }
        %>
    </div>
</div>

<script>

setTimeout(() => {
    const alerts = document.querySelectorAll('.alert');
    alerts.forEach(alert => alert.remove());
}, 5000);

document.addEventListener("DOMContentLoaded", function () {
    const bellBtn = document.getElementById("bellBtn");
    const bellCount = document.getElementById("bellCount");

    // When 🔔 clicked -> show red dots
    bellBtn.addEventListener("click", function (e) {
        e.preventDefault();
        document.querySelectorAll(".unread-dot").forEach(dot => {
            dot.style.display = "block";
        });
    });

    // When issue is clicked -> remove dot + decrease bell count
    document.querySelectorAll(".issue-card-link").forEach(link => {
        link.addEventListener("click", function () {
            const dot = this.querySelector(".unread-dot");
            if (dot) {
                dot.remove();

                if (bellCount) {
                    let count = parseInt(bellCount.textContent);
                    if (count > 0) {
                        count--;
                        bellCount.textContent = count;
                        if (count === 0) {
                            bellCount.remove();
                        }
                    }
                }
            }
        });
    });
});

</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" ></script>
</body>
</html>