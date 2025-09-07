<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.univoice.models.Department" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Univoice</title>

  <!-- Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">

  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

  <!-- ==== UI Styles for the new profile form ==== -->
  <style>
      body { 
    background:#f0fdf7; 
    font-family: system-ui,-apple-system,"Segoe UI",Roboto,Arial,sans-serif; 
  }

  nav.navbar{ 
    backdrop-filter: blur(6px); 
    background:#10b981 !important; 
  }
  nav.navbar .text-dark, 
  nav.navbar a, 
  nav.navbar span { color:#fff !important; }

  /* ===== Profile Update Panel ===== */
  .pf-wrap{ 
    display:flex; 
    justify-content:center; 
    padding:40px 16px; 
  }
  .pf-modal{
    width:100%; max-width:560px;
    background:#fff; border-radius:20px; border:1px solid #e2f5ed;
    box-shadow: 0 24px 60px rgba(0,0,0,.12);
    overflow:hidden;
  }
  .pf-body{ 
    padding:28px 26px 24px; 
    background:#ffffff; 
    position:relative; 
  }

  /* Header icon + title */
  .pf-header-icon{
    width:56px; height:56px; border-radius:50%;
    display:grid; place-items:center; margin:10px auto 12px;
    background: linear-gradient(180deg,#d1fae5,#a7f3d0);
    color:#065f46; font-size:22px; box-shadow: inset 0 1px 0 #fff;
  }
  .pf-title{
    text-align:center; font-weight:800; font-size:1.6rem;
    color:#065f46; margin:0;
  }
  .pf-sub{
    text-align:center; color:#16a34a; margin-top:8px; margin-bottom:18px;
  }

  /* Circular preview */
  .pf-avatar{
    width:120px; height:120px; border-radius:50%;
    margin:6px auto 18px; display:block; object-fit:cover;
    background:#f3f4f6; border:6px solid #dcfce7;
    box-shadow:0 10px 30px rgba(16,185,129,.25);
  }

  /* Dropzone */
  .pf-drop{
    position:relative; border:2px dashed #a7f3d0; border-radius:16px;
    padding:24px; text-align:center; background:#ecfdf5;
    transition: border-color .2s, box-shadow .2s, background .2s;
    margin:0 auto 18px auto; cursor:pointer; 
    display:block; width:100%; max-width:360px;
  }
  .pf-drop:hover{
    border-color:#34d399; background:#f0fdf7;
    box-shadow:0 6px 16px rgba(16,185,129,.18);
  }
  .pf-drop .pf-drop-icon{
    width:48px; height:48px; border-radius:50%; margin:0 auto 10px;
    display:grid; place-items:center; background:#dcfce7; color:#059669;
    font-size:20px;
  }
  .pf-drop p{ margin:6px 0; color:#374151; }
  .pf-browse{ color:#059669; text-decoration:underline; cursor:pointer; }

  /* Hide native input */
  .pf-input{ position:absolute; inset:0; opacity:0; cursor:pointer; }

  /* Buttons row */
  .pf-actions{ 
    display:flex; 
    gap:12px; 
    justify-content:center;   /* center buttons under drop box */
    padding-top:8px; 
  }
  .pf-btn{ 
    flex:0 0 auto; 
    min-width:120px;
    border-radius:12px; 
    padding:.8rem 1rem; 
    font-weight:700; 
    border:2px solid transparent; 
    transition:transform .15s ease, box-shadow .15s ease, background .15s ease, color .15s ease; 
  }
  .pf-btn:active{ transform: translateY(1px); }

  .pf-btn-cancel{
    background:#fff; color:#065f46; border-color:#bbf7d0;
    box-shadow:0 4px 10px rgba(0,0,0,.05);
  }
  .pf-btn-cancel:hover{ background:#f0fdf7; border-color:#34d399; }

  .pf-btn-upload{
    background: linear-gradient(135deg,#10b981,#06b6d4); color:#fff; border:0;
    box-shadow:0 10px 22px rgba(5,150,105,.25);
  }
  .pf-btn-upload:hover{ filter:brightness(.98); box-shadow:0 16px 28px rgba(6,182,212,.28); }

  /* Small helper text */
  .pf-hint{ color:#16a34a; font-size:.9rem; margin-top:2px; }

  /* Dropdown menu */
  .dropdown-menu {
    border-radius:12px; border:1px solid #bbf7d0;
    padding:6px 0; box-shadow:0 8px 24px rgba(0,0,0,0.08); min-width:180px;
  }
  .dropdown-item{
    padding:10px 16px; font-weight:500; color:#065f46;
    transition: background .2s, color .2s, padding-left .2s;
    border-radius:8px; margin:2px 6px; display:flex; align-items:center; gap:8px;
  }
  .dropdown-item:hover{
    background:#ecfdf5; color:#059669; padding-left:20px;
  }
  .dropdown-item.text-danger{ color:#dc2626; font-weight:600; }
  .dropdown-item.text-danger:hover{ background:#fee2e2; color:#b91c1c; }

  /* Center the form contents */
  form {
    display:flex;
    flex-direction:column;
    align-items:center;
  }

  /* Navbar sizing */
  .navbar {
    padding-top:1rem;     
    padding-bottom:1rem;  
    min-height:70px;      
  }
    
  </style>
</head>
<body>
<%
  Department dept = (Department) request.getAttribute("dept");
%>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg shadow-sm px-3">
  <div class="container-fluid d-flex justify-content-between align-items-center">
    <div class="fw-bold fs-5">
      <a href="/department-dashboard" style="text-decoration:none;color:white;">Department Dashboard</a>
    </div>
    <div class="d-flex align-items-center gap-3">
      <!-- Profile Dropdown -->
      <div class="dropdown">
        <a href="#" class="d-flex align-items-center text-decoration-none dropdown-toggle text-white"
           id="profileDropdown" data-bs-toggle="dropdown" aria-expanded="false">
          <img src="<%= (dept != null && dept.getImage()!=null) ? dept.getImage() : "../assets/imgs/blank-profile.webp" %>"
               class="rounded-circle me-2" width="35" height="33" style="object-fit: cover;">
          <span class="fw-bold"><%= dept != null ? dept.getName() : "" %></span>
        </a>
        <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="profileDropdown">
          <li>
            <a class="dropdown-item d-flex align-items-center gap-2" href="/department-dashboard">
              <i class="fa-solid fa-gauge"></i> Dashboard
            </a>
          </li>
          <li>
            <a class="dropdown-item d-flex align-items-center gap-2" href="/department-dashboard/profile">
              <i class="fa-regular fa-user"></i> Profile
            </a>
          </li>
          <li>
            <form action="/department-dashboard/logout" method="get" class="m-0">
              <button type="submit" class="dropdown-item d-flex align-items-center gap-2 text-danger">
                <i class="fa-solid fa-right-from-bracket"></i> Logout
              </button>
            </form>
          </li>
        </ul>
      </div>
    </div>
  </div>
</nav>

<!-- ===== Profile Picture Update Panel ===== -->
<div class="pf-wrap">
  <div class="pf-modal">
    <div class="pf-body">
      <div class="pf-header-icon"><i class="fa-solid fa-camera"></i></div>
      <h4 class="pf-title">Update Profile Picture</h4>
      <p class="pf-sub">Choose a new profile picture to personalize your account</p>

      <img id="previewImg"
           src="<%= (dept != null && dept.getImage()!=null) ? dept.getImage() : "../assets/imgs/blank-profile.webp" %>"
           alt="Profile Preview" class="pf-avatar">

      <form action="/department-dashboard/updateProfilePic" method="post" enctype="multipart/form-data">
        <input type="hidden" value="<%= dept != null ? dept.getId() : 0 %>" name="dID" />

        <label class="pf-drop" for="profilePic">
          <input type="file" name="profilePic" id="profilePic" class="pf-input" accept="image/*" required>
          <div class="pf-drop-icon"><i class="fa-regular fa-image"></i></div>
          <p>Drop your image here, or <span class="pf-browse">browse files</span></p>
          <div class="pf-hint">PNG, JPG, GIF up to 10MB</div>
        </label>

        <div class="pf-actions">
          <button type="button" class="pf-btn pf-btn-cancel" onclick="history.back()">Cancel</button>
          <button type="submit" class="pf-btn pf-btn-upload">
            <i class="fa-solid fa-upload me-1"></i> Upload
          </button>
        </div>
      </form>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
<script>
  const fileInput = document.getElementById('profilePic');
  const previewImg = document.getElementById('previewImg');
  if (fileInput && previewImg) {
    fileInput.addEventListener('change', function () {
      const file = this.files && this.files[0];
      if (file) previewImg.src = URL.createObjectURL(file);
    });
  }
</script>
</body>
</html>
