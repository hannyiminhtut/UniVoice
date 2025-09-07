<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.univoice.models.Admin" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UniVoice</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css" referrerpolicy="no-referrer" />
<link href="../assets/css/deptprofile.css" rel="stylesheet" />

<style>
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

  .notify-badge{
    position:absolute; top:-6px; right:-8px;
    background:#ef4444; color:#fff;
    border-radius:999px; min-width:18px; height:18px;
    font-size:11px; line-height:18px;
    text-align:center; padding:0 4px;
    box-shadow:0 0 0 2px #fff;
  }

  /* === Profile card style === */
  .card{
    background:#fff;
    border:0;
    border-radius:16px;
    box-shadow:0 8px 22px rgba(0,0,0,.08);
  }
  .card h4{
    color:#002080; /* Deep blue like your screenshot */
    font-weight:800;
  }
  .btn-primary{
    background:#002080; /* same deep blue */
    border:none;
    font-weight:600;
  }
  .btn-primary:hover{
    background:#00125c; /* darker shade on hover */
  }
</style>
</head>
<body>

<%
  Admin admin = (Admin) session.getAttribute("admin");
  String imagePath = (admin != null ? admin.getImage() : null);
  String adminName = (admin != null ? admin.getName()  : "Admin");

  Boolean pendingBell = (Boolean) request.getAttribute("pendingBell");
  Integer unseenPen   = (Integer) request.getAttribute("unseenPen");
%>

<!-- Top Navbar (same as dashboard) -->
<nav class="navbar navbar-expand-lg bg-white shadow-sm px-3">
  <div class="container-fluid d-flex justify-content-between align-items-center">

    <div class="fw-bold fs-5 text-dark">
      <a href="/admin-dashboard" style="text-decoration:none;">Admin Dashboard</a>
    </div>

    <div class="d-flex align-items-center gap-3">
      <a href="/admin-dashboard/issues" class="text-decoration-none position-relative" title="Pending issues">
        <i class="fa-solid fa-bell"></i>
        <% if (pendingBell != null && pendingBell) { %>
          <span class="notify-badge"><%= (unseenPen != null ? unseenPen : 0) %></span>
        <% } %>
      </a>
      <a href="/admin-dashboard/profile" class="d-flex align-items-center text-decoration-none">
        <img src="<%= imagePath != null ? imagePath : "../assets/imgs/blank-profile.webp" %>"
             class="rounded-circle me-2" width="35" height="33" style="object-fit:cover;">
        <span class="fw-bold text-dark"><%= adminName %></span>
      </a>
    </div>

  </div>
</nav>

<!-- Profile Picture Update Card -->
<div class="container mt-5 d-flex justify-content-center">
  <div class="card p-4" style="max-width: 450px; width: 100%;">
    <h4 class="text-center mb-4">
      <i class="fa-solid fa-camera-retro me-2"></i> Update Profile Picture
    </h4>

    <div class="text-center mb-3">
      <img id="previewImg"
           src="<%= imagePath != null ? imagePath : "../assets/imgs/blank-profile.webp" %>"
           alt="Profile Preview"
           class="rounded-circle shadow border"
           style="width:120px; height:120px; object-fit: cover;">
    </div>

    <form action="/admin-dashboard/updateProfilePic" method="post" enctype="multipart/form-data">
      <div class="mb-4">
        <label for="profilePic" class="form-label fw-semibold">Choose a new profile picture</label>
        <input type="file" name="profilePic" id="profilePic" class="form-control" accept="image/*" required>
      </div>
      <input type="hidden" value="<%= (admin != null ? admin.getId() : 0) %>" name="aID" />
      <div class="d-grid">
        <button type="submit" class="btn btn-primary btn-lg rounded-3 shadow">
          <i class="fa-solid fa-upload me-2"></i> Upload
        </button>
      </div>
    </form>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
<script>
  const fileInput = document.getElementById('profilePic');
  const previewImg = document.getElementById('previewImg');
  fileInput.addEventListener('change', function() {
    const file = this.files && this.files[0];
    if (file) previewImg.src = URL.createObjectURL(file);
  });
</script>
</body>
</html>
