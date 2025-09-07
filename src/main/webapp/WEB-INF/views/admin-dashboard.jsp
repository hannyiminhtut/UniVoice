<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
  <!-- Font Awesome (match your newer page) -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css" referrerpolicy="no-referrer" />

  <style>
    /* ===== Navbar (same look) ===== */
    .navbar{
      height:65px;
      border-bottom:1px solid #eee;
      background:#fff;
      font-family:system-ui,-apple-system,"Segoe UI",Roboto,"Helvetica Neue",Arial;
    }
    .navbar .fw-bold a{
      font-size:25px;
      font-weight:700;
      color:#000066;
      text-decoration:none;
    }
    .navbar i{ color:#0f156d; font-size:1.2rem; }

    /* Small red circular counter for bell */
    .notify-badge{
      position:absolute;
      top:-6px; right:-8px;
      background:#ef4444;
      color:#fff;
      border-radius:999px;
      min-width:18px; height:18px;
      font-size:11px; line-height:18px;
      text-align:center;
      padding:0 4px;
      box-shadow:0 0 0 2px #fff;
    }

    /* ===== Sidebar ===== */
    .sidebar{
      position:fixed; top:64px; left:0; bottom:0;
      width:280px; padding:12px 8px;
      overflow-y:auto;
      background:#0d1694 !important; /* same as your other page */
      border-right:1px solid rgba(255,255,255,0.06);
    }
    .sidebar a{
      display:block;
      color:#cbd5e1;
      text-decoration:none;
      padding:10px 8px;
      margin:4px 6px;
      border-radius:8px;
      font-weight:600;
      white-space:nowrap; overflow:hidden; text-overflow:ellipsis;
      transition:background .2s ease,color .2s ease,transform .15s ease,box-shadow .2s ease;
    }
    .sidebar a:hover{
      background:#6666ff;
      color:#e6ffff;
      transform:translateX(3px);
      box-shadow:inset 3px 0 0 #3b82f6;
    }
    .sidebar hr{ border-color:rgba(255,255,255,0.08) !important; margin:6px 12px; }

    /* ===== Main content offset ===== */
    .main-content{ margin-left:280px; padding-top:90px; }

    /* ===== Circle Cards (same style + shadows) ===== */
    .circle-card{
      flex:0 0 auto;
      text-align:center;
      text-decoration:none;
      background:#ffffff;
      border-radius:50%;
      width:160px; height:160px;
      display:flex; flex-direction:column; align-items:center; justify-content:center;
      margin:auto;
      border:4px solid #3b82f6; /* default border */
      color:#111827; font-weight:600;
      transition:transform .25s ease, box-shadow .25s ease;
      box-shadow:0 6px 12px rgba(59,130,246,.3);
    }
    .circle-card:hover{ transform:translateY(-6px) scale(1.03); }
    .circle-card .circle-icon{ font-size:26px; margin-bottom:6px; }
    .circle-card .circle-value{ font-size:22px; font-weight:700; }
    .circle-card .circle-label{ font-size:14px; font-weight:500; opacity:.85; }

    /* Variants */
    .circle-card-danger{ border-color:#dc2626; box-shadow:0 6px 12px rgba(220,38,38,.3); }
    .circle-card-info  { border-color:#9333ea; box-shadow:0 6px 12px rgba(147,51,234,.3); }
    .circle-card-teal  { border-color:#14b8a6; box-shadow:0 6px 12px rgba(20,184,166,.3); }
    .circle-card-safe  { border-color:#b800e6; box-shadow:0 6px 12px rgba(184,0,230,.3); }
    .circle-card-safe .circle-icon{ color:#b800e6; } /* purple icon */
  </style>
</head>
<body>

<!-- Top Navbar (message icon removed; bell + profile kept) -->
<nav class="navbar navbar-expand-lg bg-white shadow-sm px-3">
  <div class="container-fluid d-flex justify-content-between align-items-center">

    <div class="fw-bold fs-5 text-dark">
      <a href="/admin-dashboard" style="text-decoration:none;">Admin Dashboard</a>
    </div>

    <div class="d-flex align-items-center gap-3">
      <!-- Bell (with unseen count) -->
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

      <!-- Profile (name + avatar) -->
      <%
        Admin admin = (Admin) session.getAttribute("admin");
        String imagePath = (admin != null ? admin.getImage() : null);
        String adminName = (admin != null ? admin.getName()  : "Admin");
      %>
      <a href="/admin-dashboard/profile" class="d-flex align-items-center text-decoration-none">
        <img src="<%= imagePath != null ? imagePath : "../assets/imgs/blank-profile.webp" %>"
             class="rounded-circle me-2" width="35" height="33" style="object-fit:cover;">
        <span class="fw-bold text-dark"><%= adminName %></span>
      </a>
    </div>

  </div>
</nav>

<!-- Sidebar (same as reference) -->
<div class="sidebar">
  <a href="admin-dashboard/create">➕ Create Department</a><hr>
  <a href="admin-dashboard/issues">📋 View Issues</a><hr>
  <a href="admin-dashboard/questions">❓ Create Feedback Questions</a><hr>
  <a href="/admin-dashboard/viewfeedback">📝 View Feedback Answers</a><hr>
  <a href="admin-dashboard/logout"><i class="fa fa-sign-out" aria-hidden="true"></i> Logout</a>
</div>

<!-- Main content -->
<div class="main-content">
  <div class="container-fluid">
    <div class="row g-4">

      <% if (request.getAttribute("success") != null) { %>
        <div class="alert alert-success" role="alert"><%= request.getAttribute("success") %></div>
      <% } %>

      <% if (request.getAttribute("fail") != null) { %>
        <div class="alert alert-danger" role="alert"><%= request.getAttribute("fail") %></div>
      <% } %>

      <!-- Sessions -->
      <div class="col-6 col-md-3 d-flex">
        <a class="circle-card circle-card-safe"
           href="/admin-dashboard/viewfeedback"
           aria-label="View all sessions (total <%= request.getAttribute("totalSes") %>)">
          <div class="circle-icon"><i class="fa-solid fa-list-check"></i></div>
          <div class="circle-value"><%= request.getAttribute("totalSes") %></div>
          <div class="circle-label">Sessions</div>
        </a>
      </div>

      <!-- Pending Issues (red) -->
      <div class="col-6 col-md-3 d-flex">
        <a class="circle-card circle-card-danger"
           href="/admin-dashboard/issues"
           aria-label="View pending issues (total <%= request.getAttribute("totalPen") %>)">
          <div class="circle-icon"><i class="fa-solid fa-triangle-exclamation"></i></div>
          <div class="circle-value"><%= request.getAttribute("totalPen") %></div>
          <div class="circle-label">Pending Issues</div>
        </a>
      </div>

      <!-- Departments (info/purple) -->
      <div class="col-6 col-md-3 d-flex">
        <a class="circle-card circle-card-info"
           href="admin-dashboard/viewDept"
           aria-label="Departments (total <%= request.getAttribute("totalDept") %>)">
          <div class="circle-icon"><i class="fa-solid fa-building-user"></i></div>
          <div class="circle-value"><%= request.getAttribute("totalDept") %></div>
          <div class="circle-label">Departments</div>
        </a>
      </div>

      <!-- Students (teal) -->
      <div class="col-6 col-md-3 d-flex">
        <a class="circle-card circle-card-teal"
           href="admindashboard/viewStud"
           aria-label="Students (total <%= request.getAttribute("totalStud") %>)">
          <div class="circle-icon"><i class="fa-solid fa-chalkboard-user"></i></div>
          <div class="circle-value"><%= request.getAttribute("totalStud") %></div>
          <div class="circle-label">Students</div>
        </a>
      </div>

    </div>
  </div>
</div>

<!-- JS -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link href="https://cdn.datatables.net/1.13.8/css/dataTables.bootstrap5.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.datatables.net/1.13.8/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.8/js/dataTables.bootstrap5.min.js"></script>

<script>
  // Remove the badge instantly when going to Issues (absolute or relative hrefs)
  $(function () {
    $(document).on('click','a[href="/admin-dashboard/issues"], a[href="admin-dashboard/issues"]',function () {
      $('.notify-badge').remove();
    });

    // Handle back/forward cache showing stale badge counts
    window.addEventListener('pageshow', function (e) {
      if (e.persisted) location.reload();
    });

    // Auto-dismiss alerts
    setTimeout(() => document.querySelectorAll('.alert').forEach(a => a.remove()), 5000);
  });
</script>
</body>
</html>
