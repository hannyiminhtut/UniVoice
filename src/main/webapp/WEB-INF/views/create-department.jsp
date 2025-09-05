<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.univoice.models.Admin" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UniVoice</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css" integrity="sha512-DxV+EoADOkOygM4IR9yXP8Sb2qwgidEmeqAEmDKIOfPRQZOWbXCzLC6vjbZyy0vPisbH2SyW27+ddLVCN+OMzQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<style>

body {
            background-color: #f4f6fa 
        }
        
.login-card {
        background-color: #fff;
        padding: 30px;
        border-radius: 15px;
        box-shadow: 0 10px 25px rgba(0, 0, 139, 0.4); 
        width: 100%;
        max-width: 400px;
    }
    
 .form-label {
        font-weight: 500;
    }
    
  .navbar {
		    height: 65px;
		    border-bottom: 1px solid #eee;
		    font-family: 'Segoe UI', sans-serif;
		}
    
.main-content {
            margin-left: 400px;
            padding: 30px;
        }

.noti{
	width:100%;
	max-width:400px;
	
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
        
            
            <!-- Profile -->
            <div class="d-flex align-items-center">
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
    </div>
</nav>

<div class="main-content">
	<div class="container-fluid">
	  <div class="noti" >
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
		
		
		<div class="login-card ">
		    <h5 class="text-center fw-bold text-primary mb-3" style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;">Create Department</h5>
		    <form method="POST" action="../create-department" onsubmit="return validateForm()">
		        <div class="mb-3">
		            <label for="email" class="form-label">Email address</label>
		            <input type="email" class="form-control" name="email" id="email" required>
		        </div>
		        
		        <div class="mb-3">
		        	<label for="name" class="form-label">Name</label>
		        	<input type="text" class="form-control" name="name" id="name" required />
		        </div>
		
		        <div class="mb-3">
		            <label for="password" class="form-label">Password</label>
		            <input type="password" class="form-control" name="password" id="password" required>
		             <div id="passwordHelp" class="form-text text-danger d-none">Password must be at least 8 characters, include uppercase, lowercase, digit, and symbol.</div>
		        </div>
		        
		        <div class="mb-3">
				        <label for="repassword" class="form-label">Confirm Password</label>
				        <input type="password" class="form-control" id="repassword" name="repassword" required>
				        <div id="matchHelp" class="form-text text-danger d-none">Passwords do not match.</div>
      			</div>
		
		        <div class="d-grid">
		            <button type="submit" class="btn btn-primary w-100">Save</button>
		        </div>
		    </form>
		</div>
	</div>
</div>


<script>

function validateForm() {
	  const email = document.getElementById('email').value.trim();
	  const pwd = document.getElementById('password').value;
	  const repwd = document.getElementById('repassword').value;

	  const pwdHelp = document.getElementById('passwordHelp');
	  const matchHelp = document.getElementById('matchHelp');

	  // Create / show a help div for email if not already
	  let emailHelp = document.getElementById('emailHelp');
	  if (!emailHelp) {
	    const el = document.createElement('div');
	    el.id = "emailHelp";
	    el.className = "form-text text-danger d-none";
	    document.getElementById('email').insertAdjacentElement('afterend', el);
	    emailHelp = el;
	  }

	  // Patterns
	  const strongRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]{8,}$/;
	  const emailRegex = /^[A-Za-z0-9._%+-]+@uit\.edu\.mm$/i;

	  let isValid = true;

	  // Email check
	  if (!emailRegex.test(email)) {
	    emailHelp.textContent = "Email must end with @uit.edu.mm";
	    emailHelp.classList.remove('d-none');
	    isValid = false;
	  } else {
	    emailHelp.classList.add('d-none');
	  }

	  // Password strength
	  if (!strongRegex.test(pwd)) {
	    pwdHelp.classList.remove('d-none');
	    isValid = false;
	  } else {
	    pwdHelp.classList.add('d-none');
	  }

	  // Password match
	  if (pwd !== repwd) {
	    matchHelp.classList.remove('d-none');
	    isValid = false;
	  } else {
	    matchHelp.classList.add('d-none');
	  }

	  return isValid;
	}

	setTimeout(() => {
	  const alerts = document.querySelectorAll('.alert');
	  alerts.forEach(alert => alert.remove());
	}, 5000);
	
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" ></script>
</body>
</html>