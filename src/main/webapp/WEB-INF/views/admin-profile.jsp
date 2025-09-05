<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.univoice.models.Department" %>
<%@ page import="com.univoice.models.Admin" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Univoice</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="../assets/css/deptprofile.css" rel="stylesheet" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css" referrerpolicy="no-referrer" />
</head>
<body>
<nav class="navbar navbar-expand-lg bg-white shadow-sm px-3">
    <div class="container-fluid d-flex justify-content-between align-items-center">
        
        <div class="fw-bold fs-5 text-dark">
           <a href="/department-dashboard" style="text-decoration:none;"></a>
        </div>

        <!-- Right-side icons and profile -->
        <div class="d-flex align-items-center gap-3">
        
          <%	Admin admin = (Admin)request.getAttribute("admin"); 
          
          %>
            
           <!-- Profile Dropdown -->
			<div class="dropdown">
			    <a href="#" class="d-flex align-items-center text-decoration-none dropdown-toggle" 
			       id="profileDropdown" data-bs-toggle="dropdown" aria-expanded="false">
			        <img src="<%= admin.getImage() != null ? admin.getImage() : "../assets/imgs/blank-profile.webp" %>" 
			             class="rounded-circle me-2" width="35" height="33" style="object-fit: cover;">
			        <span class="fw-bold text-dark"><%= admin.getName() %></span>
			    </a>
			    <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="profileDropdown">
			    	<li>
			            <a class="dropdown-item" href="/admin-dashboard">Dashboard</a>
			        </li>
			        <li>
			            <a class="dropdown-item" href="/admin-dashboard/profile">Profile</a>
			        </li>
			        <li>
			            <form action="/admin-dashboard/logout" method="get" class="m-0">
			                <button type="submit" class="dropdown-item text-danger">Logout</button>
			            </form>
			        </li>
			    </ul>
			</div>
           
        </div>
    </div>
</nav>
<!-- Profile Picture Update Card -->
<div class="container mt-5 d-flex justify-content-center">
    <div class="card shadow-lg border-0 rounded-4" style="max-width: 450px; width: 100%;">
        <div class="card-body p-4">
            <h4 class="text-center fw-bold mb-4">
                <i class="fa-solid fa-camera-retro text-primary me-2"></i>
                Update Profile Picture
            </h4>

			<div class="text-center mb-3">
    		<img id="previewImg" 
		         src="<%= admin.getImage() != null ? admin.getImage() : "../assets/imgs/blank-profile.webp" %>" 
		         alt="Profile Preview" 
		         class="rounded-circle shadow-sm border"
		         style="width:120px; height:120px; object-fit: cover;">
			</div>

            <!-- Upload Form -->
            <form action="/admin-dashboard/updateProfilePic" method="post" enctype="multipart/form-data">
                <div class="mb-4">
                    <label for="profilePic" class="form-label fw-semibold">Choose a new profile picture</label>
                    <input type="file" name="profilePic" id="profilePic" class="form-control" accept="image/*" required>
                </div>
                
                <input type="hidden" value="<%= admin.getId() %>" name="aID" />

                <div class="d-grid">
                    <button type="submit" class="btn btn-primary btn-lg rounded-3 shadow-sm">
                        <i class="fa-solid fa-upload me-2"></i> Upload
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" ></script>
<script>
    const fileInput = document.getElementById('profilePic');
    const previewImg = document.getElementById('previewImg');

    fileInput.addEventListener('change', function() {
        const file = this.files[0];
        if (file) {
            previewImg.src = URL.createObjectURL(file);
        }
    });
</script>	
</body>
</html>