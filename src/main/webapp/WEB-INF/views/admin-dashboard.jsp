<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.time.*"%>
<%@ page import="java.time.format.*"%>
<%@ page import="com.univoice.models.FeedbackSession"%>
<%@ page import="com.univoice.models.Issue"%>
<%@ page import="com.univoice.models.Admin" %>

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

    <div class="d-flex align-items-center gap-3">
     	<a href="/admin-dashboard/issues" class="text-decoration-none position-relative" title="Pending issues">
		  <i class="fa-solid fa-bell"></i>
		  <%
		    Boolean pendingBell = (Boolean) request.getAttribute("pendingBell");
		    Integer unseenPen    = (Integer) request.getAttribute("unseenPen");
		    if (pendingBell != null && pendingBell) {
		  %>
		    <span class="notify-badge"><%= (unseenPen != null ? unseenPen : 0) %></span>
		  <%
		    }
		  %>
		</a>
     	
     	
     	<%
     		Admin admin = (Admin)session.getAttribute("admin");
     		String imagePath = admin.getImage();
     	%>
     	<!-- Profile Link -->
		<a href="/admin-dashboard/profile" class="d-flex align-items-center text-decoration-none">
		    <img src="<%= imagePath != null ? imagePath : "../assets/imgs/blank-profile.webp" %>" 
		         class="rounded-circle me-2" width="35" height="33" style="object-fit: cover;">
		    <span class="fw-bold text-dark"><%= admin.getName() %></span>
		</a>
     	
    </div>
  </div>
</nav>

<div class="sidebar">
  <a href="admin-dashboard/create">➕ Create Department</a><hr style="border-color:#457b9d;">
  <a href="admin-dashboard/issues">📋 View Issues</a><hr style="border-color:#457b9d;">
  <a href="admin-dashboard/questions">❓ Create Feedback Questions</a><hr style="border-color:#457b9d;">
  <a href="/admin-dashboard/viewfeedback">📝 View Feedback Answers</a><hr style="border-color:#457b9d;">
  <a href="admin-dashboard/logout"><i class="fa fa-sign-out" aria-hidden="true"></i> Logout</a>
</div>

<div class="main-content">
  <div class="container-fluid">
   <div class="row g-4">
   
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

  <!-- Sessions -->
  <div class="col-6 col-md-3 d-flex">
    <a class="circle-card"
       href="/admin-dashboard/viewfeedback"
       aria-label="View all sessions (total <%= request.getAttribute("totalSes") %>)">
      <div class="circle-icon" aria-hidden="true">
        <i class="fa-solid fa-list-check"></i>
      </div>
      <div class="circle-value"><%= request.getAttribute("totalSes") %></div>
      <div class="circle-label">Sessions</div>
    </a>
  </div>

  <!-- Pending Issues (red) -->
  <div class="col-6 col-md-3 d-flex">
    <a class="circle-card circle-card-danger"
       href="/admin-dashboard/issues"
       aria-label="View pending issues (total <%= request.getAttribute("totalPen") %>)">
      <div class="circle-icon" aria-hidden="true">
        <i class="fa-solid fa-triangle-exclamation"></i>
      </div>
      <div class="circle-value"><%= request.getAttribute("totalPen") %></div>
      <div class="circle-label">Pending Issues</div>
    </a>
  </div>

  <!-- Departments (info blue) -->
  <div class="col-6 col-md-3 d-flex">
    <a class="circle-card circle-card-info"
       href="admin-dashboard/viewDept"
       aria-label="Departments (total <%= request.getAttribute("totalDept") %>)">
      <div class="circle-icon" aria-hidden="true">
        <i class="fa-solid fa-building-user"></i>
      </div>
      <div class="circle-value"><%= request.getAttribute("totalDept") %></div>
      <div class="circle-label">Departments</div>
    </a>
  </div>

  <!-- Students (teal) -->
  <div class="col-6 col-md-3 d-flex">
    <a class="circle-card circle-card-teal"
       href="admindashboard/viewStud"
       aria-label="Students (total <%= request.getAttribute("totalStud") %>)">
      <div class="circle-icon" aria-hidden="true">
        <i class="fa-solid fa-chalkboard-user"></i>
      </div>
      <div class="circle-value"><%= request.getAttribute("totalStud") %></div>
      <div class="circle-label">Students</div>
    </a>
  </div>

</div>
   
  </div> <!-- /container-fluid -->
</div> <!-- /main-content -->



<!-- JS -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link href="https://cdn.datatables.net/1.13.8/css/dataTables.bootstrap5.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.datatables.net/1.13.8/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.8/js/dataTables.bootstrap5.min.js"></script>

<script>
  // DataTable inside modal (no search, no info)
  $(function () {
    $('#sessionsModal').on('shown.bs.modal', function () {
      // initialize once
      if (!$.fn.dataTable.isDataTable('#sessionsTable')) {
        const dt = $('#sessionsTable').DataTable({
          searching: false,     // ⛔ no search box
          info: false,          // ⛔ no "showing X of Y"
          lengthChange: false,  // ⛔ no "Show N entries"
          order: [[1, 'desc']], // Created desc
          pageLength: 8,
          pagingType: 'simple_numbers',
          language: {
            emptyTable: 'No sessions found.',
            paginate: { previous: '«', next: '»' }
          },
          dom: "<'table-responsive't><'d-flex justify-content-end pt-2'p>"
        });

        // Auto-hide pagination if only one page
        dt.on('draw', function() {
          const api = dt.api();
          const pages = api.page.info().pages;
          $(api.table().container()).find('.dataTables_paginate').toggle(pages > 1);
        }).trigger('draw');
      }
    });
  });
  
  $(function () {
	    // Instantly remove the badge when navigating to Issues
	    // Handles BOTH absolute and relative links used in your navbar & sidebar
	    $(document).on(
	      'click',
	      'a[href="/admin-dashboard/issues"], a[href="admin-dashboard/issues"]',
	      function () {
	        $('.notify-badge').remove();
	      }
	    );

	    // If the browser shows a cached dashboard when you hit Back,
	    // force a refresh so unseenPen/pendingBell are recomputed from the DB.
	    window.addEventListener('pageshow', function (e) {
	      if (e.persisted) {
	        // Page was restored from bfcache — reload to get fresh server state
	        location.reload();
	      }
	    });
	  });
  
  setTimeout(() => {
	    const alerts = document.querySelectorAll('.alert');
	    alerts.forEach(alert => alert.remove());
	}, 5000);
</script>
</body>
