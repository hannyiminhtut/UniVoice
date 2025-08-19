<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UniVoice</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css" referrerpolicy="no-referrer" />
<style>
    body {
        background: #f5f7fb;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .issue-card {
        background: #fff;
        border-radius: 15px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        padding: 30px;
        max-width: 650px;
        margin: auto;
        margin-top: 40px;
        animation: fadeInUp 0.6s ease;
    }

    .form-label {
        font-weight: 600;
    }

    .input-group-text {
        background-color: #f1f3f8;
        border: none;
        font-size: 1.2rem;
        color: #6c63ff;
    }

    .form-control, .form-select {
        border-radius: 10px;
        padding: 12px;
    }

    .btn-submit {
        background: linear-gradient(90deg, #6c63ff, #8e2de2);
        color: white;
        border: none;
        border-radius: 10px;
        padding: 12px 20px;
        font-size: 1rem;
        font-weight: 600;
        transition: all 0.3s ease;
    }
    .btn-submit:hover {
        background: linear-gradient(90deg, #8e2de2, #6c63ff);
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    }

    .img-preview {
        max-width: 100%;
        max-height: 200px;
        border-radius: 10px;
        margin-top: 10px;
        display: none;
    }

    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    .noti{
    	max-width: 650px;
    	margin:auto;
    }
</style>
</head>
<body>


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
<div class="issue-card">
    <h3 class="mb-4 text-center">
        <i class="fa-solid fa-bug text-danger me-2"></i> 
        Submit an Issue
    </h3>
    <form id="issueForm" method="POST" action="./sendIssue" enctype="multipart/form-data">
    <!-- hidden form to send student' id -->
    	
        <!-- Issue Title -->
        <div class="mb-3">
            <label for="title" class="form-label">Issue Title</label>
            <div class="input-group">
                <span class="input-group-text"><i class="fa-solid fa-heading"></i></span>
                <input type="text" class="form-control" id="title" name="title" placeholder="Enter issue title" required>
            </div>
        </div>

        <!-- Issue Description -->
        <div class="mb-3">
            <label for="description" class="form-label">Issue Description</label>
            <div class="input-group">
                <span class="input-group-text"><i class="fa-solid fa-align-left"></i></span>
                <textarea class="form-control" id="description" name="des" rows="4" placeholder="Describe the issue..." required></textarea>
            </div>
        </div>

        <!-- Location -->
        <div class="mb-3">
            <label for="location" class="form-label">Location</label>
            <div class="input-group">
                <span class="input-group-text"><i class="fa-solid fa-location-dot"></i></span>
                <input type="text" class="form-control" id="location" name="location" placeholder="e.g, Building 3, Room 325" required>
            </div>
        </div>

        <!-- Image Upload -->
        <div class="mb-3">
            <label for="image" class="form-label">Attach Image (optional)</label>
            <div class="input-group">
                <span class="input-group-text"><i class="fa-solid fa-image"></i></span>
                <input class="form-control" type="file" id="image" name="img" accept="image/*">
            </div>
            <img id="preview" class="img-preview" alt="Preview">
        </div>

        <!-- Submit -->
        <div class="text-center">
            <button type="submit" class="btn-submit">
                <i class="fa-solid fa-paper-plane me-2"></i> 
                Submit Issue
            </button>
        </div>
    </form>
</div>
<script>
    const imageInput = document.getElementById('image');
    const preview = document.getElementById('preview');

    imageInput.addEventListener('change', () => {
        const file = imageInput.files[0];
        if (file) {
            preview.src = URL.createObjectURL(file);
            preview.style.display = 'block';
        } else {
            preview.style.display = 'none';
        }
    });

    setTimeout(() => {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(alert => alert.remove());
    }, 5000);
  
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>