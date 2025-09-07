<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.univoice.models.Student" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Profile — UniVoice</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css" referrerpolicy="no-referrer" />

<style>
  body {
  background: #f6fdf9; /* light green background */
  font-family: 'Segoe UI', sans-serif;
}

.page-wrap {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 24px;
}

.card-uv {
  border: 0;
  border-radius: 18px;
  overflow: hidden;
  box-shadow: 0 18px 40px rgba(30,41,59,.12);
  max-width: 980px;
  width: 100%;
}

/* Header Hero */
.card-uv .hero {
  background: linear-gradient(135deg, #10b981, #06b6d4); /* greenish gradient */
  color: #fff;
  padding: 28px 28px;
}

.card-uv .hero .title {
  margin: 0;
  font-weight: 800;
  letter-spacing: .2px;
  color: #fff;
}

.card-uv .hero .subtitle {
  opacity: .95;
  margin: 6px 0 0 0;
}

/* Profile Pill */
.pill {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 6px 12px;
  font-weight: 600;
  border-radius: 999px;
  background: rgba(255,255,255,.14);
  color: #fff;
}

/* Content */
.content {
  background: #fff;
  padding: 28px;
}

/* Avatar */
.avatar-wrap {
  position: relative;
  width: 132px;
  height: 132px;
}
.avatar {
  width: 132px;
  height: 132px;
  border-radius: 50%;
  object-fit: cover;
  border: 4px solid #fff;
  box-shadow: 0 8px 18px rgba(0,0,0,.12);
}

/* Edit avatar button */
.avatar-edit {
  position: absolute;
  right: 4px;
  bottom: 4px;
  border: 0;
  width: 40px;
  height: 40px;
  border-radius: 999px;
  background: linear-gradient(135deg, #10b981, #06b6d4); /* greenish */
  color: #fff;
  display: grid;
  place-items: center;
  box-shadow: 0 8px 18px rgba(16,185,129,.4);
}
.avatar-edit:hover {
  background: linear-gradient(135deg, #0e9f75, #0597ad); /* darker green hover */
}

/* Labels & Inputs */
.form-label {
  font-weight: 700;
  color: #1f2937;
}
.form-control, .form-select {
  border-radius: 14px;
  padding: 12px 14px;
  border: 1px solid #e5e7eb;
}
.form-control:focus {
  border-color: #10b981;
  box-shadow: 0 0 0 .2rem rgba(16,185,129,.25);
}

/* Save button */
.btn-save {
  background: linear-gradient(135deg, #10b981, #06b6d4); /* green gradient */
  border: 0;
  color: #fff;
  font-weight: 800;
  border-radius: 14px;
  padding: 12px 18px;
  box-shadow: 0 10px 22px rgba(16,185,129,.35);
  transition: transform .2s ease;
}
.btn-save:hover {
  transform: translateY(-1px);
  background: linear-gradient(135deg, #0e9f75, #0597ad);
  box-shadow: 0 10px 22px rgba(6,182,212,.35);
  color: #fff;
}

/* Cancel button */
.btn-cancel {
  border-radius: 14px;
  padding: 12px 18px;
  border: 2px solid #10b981;
  color: #10b981;
  font-weight: 600;
  background: #fff;
  transition: all .2s ease;
}
.btn-cancel:hover {
  background: #10b981;
  color: #fff;
}

/* Helper text */
.small-hint { color: #6b7280; font-size: .9rem; }

/* Alerts */
.uv-alert {
  border-radius: 14px;
  border: 0;
  box-shadow: 0 10px 24px rgba(0,0,0,.08);
}

/* Fade animation */
.fade-in {
  opacity: 0;
  transform: translateY(16px);
  animation: fadeUp .5s ease forwards;
}
@keyframes fadeUp { to { opacity: 1; transform: none; } }
  
  
</style>
</head>
<body>
<%
  Student s = (Student) request.getAttribute("student");
  if (s == null) { s = (Student) session.getAttribute("student"); }
  String currentName = (s != null && s.getName()!=null) ? s.getName() : "";
  String currentEmail = (s != null && s.getEmail()!=null) ? s.getEmail() : "";
  String currentPass = (s != null && s.getPassword()!=null) ? s.getPassword() : "";
  String currentImg  = (s != null && s.getImage()!=null && !s.getImage().isEmpty())
                       ? s.getImage()
                       : "../../assets/imgs/blank-profile.webp";
  int currentId = (s != null) ? s.getUser_id() : 0;

  String msgSuccess = (String) request.getAttribute("success");
  String msgFail    = (String) request.getAttribute("fail");
%>

<div class="page-wrap">

  <div class="card card-uv fade-in">

    <!-- Header -->
    <div class="hero d-flex align-items-center justify-content-between">
      <div>
        <h2 class="title">Edit Profile</h2>
        <p class="subtitle mb-0">Update your personal information and profile picture</p>
      </div>
      <span class="pill"><i class="fa-solid fa-user-pen"></i> Profile Settings</span>
    </div>

    <!-- Alerts -->
    <div class="content pt-3 pb-0">
      <%
        if (msgSuccess != null) {
      %>
        <div class="alert alert-success uv-alert" role="alert">
          <i class="fa-solid fa-circle-check me-2"></i><%= msgSuccess %>
        </div>
      <%
        } else if (msgFail != null) {
      %>
        <div class="alert alert-danger uv-alert" role="alert">
          <i class="fa-solid fa-triangle-exclamation me-2"></i><%= msgFail %>
        </div>
      <%
        }
      %>
    </div>

    <!-- Body -->
    <div class="content pt-2">

      <form action="/student-dashboard/updateProfile" method="post" enctype="multipart/form-data" class="row g-4">

        <!-- Left: Avatar -->
        <div class="col-12 col-md-4 d-flex flex-column align-items-center">
          <div class="avatar-wrap mb-3">
            <img id="avatarPreview" src="<%= currentImg %>" alt="Profile Image" class="avatar">
            <label for="imageInput" class="avatar-edit" title="Change photo">
              <i class="fa-solid fa-camera"></i>
            </label>
            <input id="imageInput" name="image" type="file" class="d-none" accept="image/*">
          </div>

        </div>

        <!-- Right: Form Fields -->
        <div class="col-12 col-md-8">
          <input type="hidden" name="student_id" value="<%= currentId %>">

          <div class="mb-3">
            <label class="form-label" for="name"><i class="fa-solid fa-id-card-clip me-2"></i>Name</label>
            <input type="text" id="name" name="name" class="form-control" value="<%= currentName %>" placeholder="Your full name" required>
          </div>

          <div class="mb-3">
            <label class="form-label" for="email"><i class="fa-solid fa-envelope me-2"></i>Email</label>
            <input type="email" id="email" name="email" class="form-control" value="<%= currentEmail %>" placeholder="name@example.com" required>
          </div>

         <div class="mb-3 position-relative">
			  <label class="form-label" for="password">
			    <i class="fa-solid fa-lock me-2"></i>Password
			  </label>
			  <input type="password" id="password" name="password" 
			         class="form-control pe-5" 
			         value="<%= currentPass %>" 
			         placeholder="Your password" required>
			
			  <!-- Eye toggle -->
			  <button type="button" id="togglePassword" 
			          class="btn btn-sm btn-link position-absolute top-50 end-0 translate-middle-y me-2 p-0"
			          tabindex="-1">
			    <i id="eyeIcon" class="fa-solid fa-eye-slash text-muted"></i>
			  </button>
			
			  <div class="form-text small-hint">This shows your current password as requested.</div>
		</div>
         

          <div class="d-flex gap-3">
            <button type="submit" class="btn btn-save">
              <i class="fa-solid fa-floppy-disk me-2"></i>Save Changes
            </button>
            <a href="/student-dashboard" class="btn btn-outline-secondary btn-cancel">
              <i class="fa-solid fa-arrow-left me-2"></i>Back
            </a>
          </div>
        </div>

      </form>

    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
<script>
  // Image preview + basic validation
  const input = document.getElementById('imageInput');
  const preview = document.getElementById('avatarPreview');

  input.addEventListener('change', function(){
    const file = this.files && this.files[0];
    if(!file) return;

    // 2MB size limit
    const maxBytes = 2 * 1024 * 1024;
    if (file.size > maxBytes) {
      alert('Image is larger than 2MB. Please choose a smaller file.');
      this.value = '';
      return;
    }

    // Preview
    const reader = new FileReader();
    reader.onload = e => { preview.src = e.target.result; };
    reader.readAsDataURL(file);
  });

  // Auto-dismiss alerts
  setTimeout(() => {
    document.querySelectorAll('.alert').forEach(a => a.remove());
  }, 5000);
  
  const passwordInput = document.getElementById('password');
  const togglePassword = document.getElementById('togglePassword');
  const eyeIcon = document.getElementById('eyeIcon');

  togglePassword.addEventListener('click', () => {
    const isPassword = passwordInput.type === 'password';
    passwordInput.type = isPassword ? 'text' : 'password';
    eyeIcon.classList.toggle('fa-eye', isPassword);
    eyeIcon.classList.toggle('fa-eye-slash', !isPassword);
  });

</script>
</body>
</html>
