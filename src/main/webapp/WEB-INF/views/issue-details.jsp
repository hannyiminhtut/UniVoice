<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.univoice.models.Issue" %>
<%@ page import="com.univoice.models.Department" %>
<%@ page import="com.univoice.models.Admin" %>
<%@ page import="java.util.List" %>
<%
    Issue issue = (Issue)request.getAttribute("issue");
    String title = issue.getTitle();
    String des = issue.getDescription();
    String location = issue.getLocation();
    String createdAt = issue.getCreated_at();
    String imagePath = issue.getImg();
    String flag = issue.getStatus();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UniVoice</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css" crossorigin="anonymous" referrerpolicy="no-referrer" />
<style>
  body { background-color:#f4f6fa; }
  .navbar { height:65px; border-bottom:1px solid #eee; font-family:'Segoe UI',sans-serif; }

  .issue-card{
    max-width:800px; margin:40px auto; background:#fff; border-radius:15px;
    box-shadow:0 4px 12px rgba(0,0,0,.1); overflow:hidden; transition:.3s;
    position:relative; /* needed so the trash can pin to top-right */
  }
  .issue-card:hover{ transform:translateY(-3px); box-shadow:0 6px 18px rgba(0,0,0,.15); }
  .issue-header{ background:linear-gradient(135deg,#0d6efd,#4dabf7); color:#fff; padding:20px; }
  .issue-body{ padding:20px; }
  .issue-body p{ font-size:1rem; color:#333; }
  .issue-footer{ padding:15px; background:#f9f9f9; border-top:1px solid #eee; text-align:right; }
  .issue-img{ max-width:100%; border-radius:10px; margin-top:15px; }

  /* BIG red trash button in the top-right of the card */
  .issue-trash-btn{
    position:absolute; top:12px; right:12px; z-index:5;
    width:36px; height:36px; border-radius:999px; border:none;
    display:flex; align-items:center; justify-content:center;
    background:#ef4444; color:#fff; box-shadow:0 4px 10px rgba(239,68,68,.25);
    cursor:pointer; transition:transform .1s ease, box-shadow .15s ease, background .15s ease;
    font-size:20px; line-height:1;
  }
  .issue-trash-btn:hover{ background:#dc2626; box-shadow:0 6px 14px rgba(220,38,38,.3); transform:translateY(-1px); }
  .issue-trash-btn:active{ transform:translateY(0); }
</style>
</head>
<body>
<!-- Top Navbar -->
<nav class="navbar navbar-expand-lg bg-white shadow-sm px-3">
  <div class="container-fluid d-flex justify-content-between align-items-center">
    <div class="d-flex align-items-center gap-3">
      <div class="fw-bold fs-5 text-dark"><a href="/admin-dashboard" style="text-decoration:none;">Admin Dashboard</a></div>
    </div>
    <div class="d-flex align-items-center gap-3">
      
    
      <div class="d-flex align-items-center">
        	<%
	     		Admin admin = (Admin)session.getAttribute("admin");
	     		String img = admin.getImage();
	     		%>
		     	<!-- Profile Link -->
				<a href="/admin-dashboard/profile" class="d-flex align-items-center text-decoration-none">
				    <img src="<%= img != null ? img : "../assets/imgs/blank-profile.webp" %>" 
				         class="rounded-circle me-2" width="35" height="33" style="object-fit: cover;">
				    <span class="fw-bold text-dark"><%= admin.getName() %></span>
				</a>
      
      </div>
    </div>
  </div>
</nav>

<div class="issue-card">
  <!-- Show big red trash only if resolved -->
  <% if ("resolved".equalsIgnoreCase(flag)) { %>
   
    <form id="deleteForm" action="<%= request.getContextPath() %>/admin-dashboard/issues/delete/<%= issue.getIssue_id() %>" method="post" style="display:none;"></form>
    <button type="button" class="issue-trash-btn" title="Delete issue"
            onclick="if(confirm('Delete this issue?')){ document.getElementById('deleteForm').submit(); }">
      <i class="fa-solid fa-trash"></i>
    </button>
    
  <% }else if("pending".equalsIgnoreCase(flag)){ %>
  
  	<form id="bannedForm" action="<%= request.getContextPath() %>/admin-dashboard/issues/banned/<%= issue.getIssue_id() %>" method="post" style="display:none;"></form>
    <button type="button" class="issue-trash-btn" title="Banned issue"
            onclick="if(confirm('Banned this issue?')){ document.getElementById('bannedForm').submit(); }">
      <i class="fa-solid fa-ban"></i>
    </button>
  
 <%	} %> 

  <div class="issue-header">
    <h3><i class="fa-solid fa-triangle-exclamation me-2"></i><%= title %></h3>
    <small><i class="fa-regular fa-calendar-alt me-1"></i> Submitted on <%= createdAt %></small>
  </div>

  <div class="issue-body">
    <p><i class="fa-solid fa-align-left me-2"></i> <strong>Description:</strong> <%= des %></p>
    <p><i class="fa-solid fa-location-dot me-2 text-danger"></i> <strong>Location:</strong> <%= location %></p>

    <% if (imagePath != null && !imagePath.isEmpty()) { %>
      <p><i class="fa-solid fa-image me-2"></i> <strong>Attached Image:</strong></p>
      <img src="<%= imagePath %>" class="issue-img" alt="Issue Image" width="200" height="250">
    <% } %>

    <%
      String note = issue.getNote();
      if (note != null && !note.trim().isEmpty()) {
    %>
      <div class="mt-4 p-3 border rounded bg-light">
        <h6><i class="fa-solid fa-check-circle text-success me-2"></i> Resolution Note</h6>
        <p class="mb-0"><%= note %></p>
      </div>
    <% } %>
  </div>

  <div class="issue-footer d-flex justify-content-between align-items-center">
    <a href="../issues" class="btn btn-secondary">
      <i class="fa-solid fa-arrow-left"></i> Back to Issues
    </a>

    <%
      String status = issue.getStatus();
      if (issue.getNote() == null) {
        if ("pending".equalsIgnoreCase(status)) {
    %>
      <!-- Assign form -->
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
          <button type="submit" class="btn btn-success"><i class="fa-solid fa-paper-plane"></i> Assign</button>
        </div>
      </form>
    <%
        } else if ("assigned".equalsIgnoreCase(status)) {
    %>
      <button class="badge bg-warning text-dark">Already assigned to <%=  request.getAttribute("deptName") %></button>
    <%
        }
      } else if ("resolved".equalsIgnoreCase(status)) {
    %>
      <span class="badge bg-success">
        <i class="fa-solid fa-circle-check me-1"></i> Issue is resolved by <%= request.getAttribute("deptName") %>
      </span>
    <%
      } else {
    %>
      <form action="resolve" method="POST" class="d-inline">
        <input type="hidden" name="issueId" value="<%= issue.getIssue_id() %>">
        <button type="submit" class="btn btn-success">
          <i class="fa-solid fa-check"></i> Mark as Resolved
        </button>
      </form>
    <%
      }
    %>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
