<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UniVoice</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css" />

<style>
  body {
  background:#f0fdf7; /* light green background */
  font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.issue-card {
  background:#fff;
  border-radius:16px;
  box-shadow:0 8px 24px rgba(0,0,0,0.08);
  max-width:650px;
  margin:40px auto;
  overflow:hidden;
}

.noti{
    max-width:650px;
    margin:40px auto;
}

/* Header */
.issue-header {
  background:linear-gradient(135deg,#10b981,#06b6d4); /* greenish gradient */
  color:#fff;
  padding:20px;
  display:flex;
  align-items:center;
  gap:15px;
}
.issue-header i {
  font-size:2rem;
}
.issue-header h4 {
  margin:0;
  font-weight:800;
  font-size:1.4rem;
}
.issue-header small {
  display:block;
  font-size:.9rem;
  opacity:.9;
}

/* Body */
.issue-body {
  padding:22px;
}

/* Form labels */
.form-label {
  font-weight:700;
  color:#10b981 !important;  /* green */
  margin-bottom:.4rem;
  display:flex;
  align-items:center;
  gap:6px;
}
.form-label i {
  color:#10b981 !important;
}

/* Inputs */
.input-group-text {
  background:#f3fdf9;
  border:none;
  color:#10b981;
  font-size:1.1rem;
}
.form-control, .form-select, textarea {
  border-radius:10px;
  padding:12px;
}
.form-control:focus, .form-select:focus {
  border-color:#06b6d4;
  box-shadow:0 0 0 3px rgba(6,182,212,0.25);
}

/* Upload box */
.upload-box {
  border:2px dashed #10b981;    /* green border */
  border-radius:12px;
  text-align:center;
  padding:40px 20px;
  min-height:160px;
  width:100%;
  color:#6b7280;
  cursor:pointer;
  transition:.2s ease;
  display:flex;
  flex-direction:column;
  align-items:center;
  justify-content:center;
}
.upload-box:hover {
  background:#f0fdf7;
  border-color:#06b6d4;
}
.upload-box i {
  font-size:2.2rem;
  color:#10b981;
  margin-bottom:8px;
}

/* Submit button */
.btn-submit {
  background:linear-gradient(135deg,#10b981,#06b6d4); /* green gradient */
  color:#fff;
  border:none;
  border-radius:10px;
  padding:12px;
  font-weight:700;
  width:100%;
  transition:.2s ease;
}
.btn-submit:hover {
  background:linear-gradient(135deg,#0e9f75,#0597ad); /* darker green hover */
  box-shadow:0 4px 12px rgba(6,182,212,.25);
  transform:translateY(-1px);
}
  
  
</style>
</head>
<body>

 <!-- Alerts -->
        <div class="noti">
          <% if (request.getAttribute("success") != null) { %>
            <div class="alert alert-success" role="alert"><%= request.getAttribute("success") %></div>
          <% } %>
          <% if (request.getAttribute("fail") != null) { %>
            <div class="alert alert-danger" role="alert"><%= request.getAttribute("fail") %></div>
          <% } %>
        </div>
<div class="issue-card">
  <!-- Header -->
  <div class="issue-header">
    <i class="fa-solid fa-bug"></i>
    <div>
      <h4>Submit an Issue</h4>
      <small>Help us improve by reporting problems</small>
    </div>
  </div>

  <!-- Body -->
  <div class="issue-body">
    <form method="POST" action="./sendIssue" enctype="multipart/form-data">
      
      <!-- Title -->
      <div class="mb-3">
        <label for="title" class="form-label"><i class="fa-regular fa-file-lines me-2"></i> Issue Title</label>
        <input type="text" class="form-control" id="title" name="title" placeholder="Enter issue title" required>
      </div>

      <!-- Description -->
      <div class="mb-3">
        <label for="description" class="form-label"><i class="fa-regular fa-clipboard me-2"></i> Issue Description</label>
        <textarea class="form-control" id="description" name="des" rows="3" placeholder="Describe the issue..." required></textarea>
      </div>

      <!-- Location -->
      <div class="mb-3">
        <label for="location" class="form-label"><i class="fa-solid fa-location-dot me-2"></i> Location</label>
        <input type="text" class="form-control" id="location" name="location" placeholder="e.g., Building 3, Room 325" required>
      </div>

    <div class="mb-3">
      <label for="image" class="form-label d-block text-primary fw-bold" style="color:#6c63ff;">
        <i class="fa-regular fa-image me-2"></i> Attach Image <small class="text-muted">(optional)</small>
      </label>

      <!-- Upload Box -->
      <label for="image" class="upload-box" id="uploadBox">
        <div id="uploadContent">
          <i class="fa-solid fa-upload"></i>
          <div>Drop your image here or click to browse</div>
          <small>PNG, JPG, GIF up to 10MB</small>
        </div>
        <img id="previewImage" src="#" alt="Image Preview"
             class="img-fluid rounded"
             style="max-height:160px; display:none;">
      </label>

      <!-- Hidden file input -->
      <input type="file" id="image" name="img" class="d-none" accept="image/*">
    </div>
</div>
      

      <!-- Submit -->
      <button type="submit" class="btn-submit">
        <i class="fa-solid fa-paper-plane me-2"></i> Submit Issue
      </button>
    </form>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
<script>
const fileInput = document.getElementById("image");
  const previewImage = document.getElementById("previewImage");
  const uploadContent = document.getElementById("uploadContent");

  fileInput.addEventListener("change", function () {
    const file = this.files[0];
    if (file) {
      const reader = new FileReader();
      reader.addEventListener("load", function () {
        // Hide upload icon + text
        uploadContent.style.display = "none";
        // Show image preview inside box
        previewImage.setAttribute("src", this.result);
        previewImage.style.display = "block";
      });
      reader.readAsDataURL(file);
    } else {
      // Reset back to original state
      uploadContent.style.display = "flex";
      previewImage.style.display = "none";
      previewImage.setAttribute("src", "#");
    }
  });

// Auto-dismiss alerts
  setTimeout(() => { document.querySelectorAll('.alert').forEach(a => a.remove()); }, 5000);
</script>
</body>
</html>
