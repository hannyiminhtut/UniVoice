<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.univoice.models.Admin" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UniVoice</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome (same as viewfeedback/profile pages) -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css" referrerpolicy="no-referrer" />

<style>
  :root{
    --bg: #f4f6fa;
    --brand-600:#4f46e5;
    --brand-500:#6574ff;
    --ring: rgba(99,102,241,.28);
    --text:#0f172a;
    --muted:#64748b;
    --danger:#ef4444;
    --success:#16a34a;
    --card: #ffffff;
  }

  body{
    background:
      radial-gradient(1100px 500px at 15% -10%, #e8f0ff 10%, transparent 55%),
      radial-gradient(1000px 520px at 120% 0%, #f1e8ff 10%, transparent 55%),
      var(--bg);
    color: var(--text);
    min-height: 100vh;
  }

  /* ===== Navbar (same look as viewfeedback/profile) ===== */
  .navbar{height:65px;border-bottom:1px solid #eee;background:#fff;font-family:system-ui,-apple-system,"Segoe UI",Roboto,"Helvetica Neue",Arial;}
  .navbar .fw-bold a{font-size:25px;font-weight:700;color:#000066;text-decoration:none;}
  .navbar i{color:#0f156d;font-size:1.2rem;}
  /* tiny bell counter badge */
  .notify-badge{
    position:absolute;top:-6px;right:-8px;background:#ef4444;color:#fff;border-radius:999px;
    min-width:18px;height:18px;font-size:11px;line-height:18px;text-align:center;padding:0 4px;
    box-shadow:0 0 0 2px #fff;
  }

  .main-content{ max-width: 980px; margin: 32px auto; padding: 0 16px; }

  .noti{ max-width: 520px; margin: 0 auto 12px; }
  .alert{ border:0; border-radius: 12px; box-shadow: 0 10px 20px rgba(0,0,0,.07); }

  .form-shell{
    max-width: 520px; margin: 0 auto;
    background: linear-gradient(180deg, #ffffff 0%, #fbfbff 100%);
    border: 1px solid #eef1f7; border-radius: 18px;
    box-shadow: 0 30px 60px rgba(31,41,55,.10);
  }
  .form-head{ padding: 20px 22px 10px; text-align:center; }
  .form-head h5{ font-weight:800; margin:0; color:#002699; letter-spacing:.2px; }
  .form-head .sub{ color:var(--muted); margin-top:6px; font-size:.95rem; }
  .form-body{ padding: 18px 22px 22px; }

  .form-control{
    height:44px; border-radius:12px; border:1px solid #e3e8f0; transition:border .15s, box-shadow .15s, background .15s;
  }
  .form-control:focus{
    border-color:#002699;
    box-shadow:0 4px 12px rgba(79,70,229,.25);
    outline:none; transform:scale(1.01);
  }

  .form-text{ font-size:.85rem; }

  .btn-primary{
    background:#002699; border:0; border-radius:12px; font-weight:800;
    box-shadow:0 12px 22px rgba(99,102,241,.25);
    padding:.8rem 1rem; transition:transform .12s, box-shadow .12s, filter .12s;
  }
  .btn-primary:hover{ transform:translateY(-1px); filter:brightness(.98); box-shadow:0 16px 28px rgba(99,102,241,.28); }
  .btn-primary:active{ transform:translateY(0); box-shadow:0 8px 18px rgba(99,102,241,.22); }
</style>
</head>
<body>

<%
  // same data sources used on your other admin pages
  Admin admin = (Admin) session.getAttribute("admin");
  String imagePath = (admin != null ? admin.getImage() : null);
  String adminName = (admin != null ? admin.getName()  : "Admin");
  Boolean pendingBell = (Boolean) request.getAttribute("pendingBell");
  Integer unseenPen   = (Integer) request.getAttribute("unseenPen");
%>

<!-- ===== Navbar (copied style/structure) ===== -->
<nav class="navbar navbar-expand-lg bg-white shadow-sm px-3">
  <div class="container-fluid d-flex justify-content-between align-items-center">

    <div class="fw-bold fs-5 text-dark">
      <a href="/admin-dashboard" style="text-decoration:none;">Admin Dashboard</a>
    </div>

    <div class="d-flex align-items-center gap-3">
      <!-- Bell with optional badge -->
      <a href="/admin-dashboard/issues" class="text-decoration-none position-relative" title="Pending issues">
        <i class="fa-solid fa-bell"></i>
        <% if (pendingBell != null && pendingBell) { %>
          <span class="notify-badge"><%= (unseenPen != null ? unseenPen : 0) %></span>
        <% } %>
      </a>
      <!-- Profile (avatar + name) -->
      <a href="/admin-dashboard/profile" class="d-flex align-items-center text-decoration-none">
        <img src="<%= imagePath != null ? imagePath : "../assets/imgs/blank-profile.webp" %>"
             class="rounded-circle me-2" width="35" height="33" style="object-fit:cover;">
        <span class="fw-bold text-dark"><%= adminName %></span>
      </a>
    </div>

  </div>
</nav>

<div class="main-content">
  <div class="container-fluid">

    <!-- Alerts -->
    <div class="noti">
      <% if (request.getAttribute("success") != null) { %>
        <div class="alert alert-success" role="alert"><%= request.getAttribute("success") %></div>
      <% } %>
      <% if (request.getAttribute("fail") != null) { %>
        <div class="alert alert-danger" role="alert"><%= request.getAttribute("fail") %></div>
      <% } %>
    </div>

    <!-- Form Card -->
    <div class="form-shell">
      <div class="form-head">
        <h5><i class="fa-solid fa-building-columns me-2"></i>Create Department</h5>
        <div class="sub">Add a department account with email, name, and secure password.</div>
      </div>

      <div class="form-body">
        <form method="POST" action="../create-department" onsubmit="return validateForm()">

          <!-- Email -->
          <div class="mb-3 input-wrap">
            <label for="email" class="form-label">Email address</label>
            <input type="email" class="form-control" name="email" id="email" required>
          </div>

          <!-- Name -->
          <div class="mb-3 input-wrap">
            <label for="name" class="form-label">Name</label>
            <input type="text" class="form-control" name="name" id="name" required>
          </div>

          <!-- Password -->
          <div class="mb-3 input-wrap">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" name="password" id="password" required>
            <div id="passwordHelp" class="form-text text-danger d-none">
              Password must be at least 8 characters, include uppercase, lowercase, digit, and symbol.
            </div>
          </div>

          <!-- Confirm Password -->
          <div class="mb-3 input-wrap">
            <label for="repassword" class="form-label">Confirm Password</label>
            <input type="password" class="form-control" id="repassword" name="repassword" required>
            <div id="matchHelp" class="form-text text-danger d-none">Passwords do not match.</div>
          </div>

          <!-- Submit -->
          <div class="d-grid pt-1">
            <button type="submit" class="btn btn-primary w-100">
              <i class="fa-solid fa-floppy-disk me-2"></i>Save
            </button>
          </div>

        </form>
      </div>
    </div>

  </div>
</div>

<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
<script>
  function validateForm() {
    const pwd = document.getElementById('password').value;
    const repwd = document.getElementById('repassword').value;
    const pwdHelp = document.getElementById('passwordHelp');
    const matchHelp = document.getElementById('matchHelp');

    const strongRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]{8,}$/;

    let isValid = true;

    if (!strongRegex.test(pwd)) { pwdHelp.classList.remove('d-none'); isValid = false; }
    else { pwdHelp.classList.add('d-none'); }

    if (pwd !== repwd) { matchHelp.classList.remove('d-none'); isValid = false; }
    else { matchHelp.classList.add('d-none'); }

    return isValid;
  }

  // Auto-dismiss alerts
  setTimeout(() => { document.querySelectorAll('.alert').forEach(a => a.remove()); }, 5000);
</script>
</body>
</html>
