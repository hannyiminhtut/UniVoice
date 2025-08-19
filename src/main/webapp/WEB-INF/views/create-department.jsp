<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	  const pwd = document.getElementById('password').value;
	  const repwd = document.getElementById('repassword').value;
	  const pwdHelp = document.getElementById('passwordHelp');
	  const matchHelp = document.getElementById('matchHelp');

	  // Strong password pattern
	  const strongRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]{8,}$/;

	  let isValid = true;

	  if (!strongRegex.test(pwd)) {
	    pwdHelp.classList.remove('d-none');
	    isValid = false;
	  } else {
	    pwdHelp.classList.add('d-none');
	  }

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