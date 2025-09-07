<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.univoice.models.Student"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Students — UniVoice</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="../assets/css/adminstyle.css" rel="stylesheet" />
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet"/>

<style>
/* ===== Navbar ===== */
.navbar { 
  height: 65px;
  border-bottom: 1px solid #eee;
  font-family: system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial; 
  background: #fff;
}
.navbar .fw-bold a {
  font-size: 25px;
  font-weight: 700;
  color: #000066;   
  text-decoration: none;
}
.navbar i {
  color: #0f156d;
  font-size: 1.2rem;
}
.navbar .fw-bold { color: #0f156d !important; }

/* ===== Sidebar ===== */
.sidebar {
  position: fixed;
  top: 64px;
  left: 0;
  bottom: 0;
  width: 280px;
  padding: 12px 8px;
  overflow-y: auto;
  background: linear-gradient(180deg, #3b82f6 0%, #1e3a8a 100%);
  border-right: 1px solid rgba(255,255,255,0.06);
}
.sidebar a {
  display: block;
  color: #cbd5e1;
  text-decoration: none;
  padding: 10px 8px;
  margin: 4px 6px;
  border-radius: 8px;
  font-weight: 600;
  transition: background .2s ease, color .2s ease, transform .15s ease, box-shadow .2s ease;
}
.sidebar a:hover {
  background: #2563eb;
  color: #fff;
  transform: translateX(3px);
  box-shadow: inset 3px 0 0 #1e3a8a;
}
.sidebar hr {
  border-color: rgba(255,255,255,0.15) !important;
  margin: 6px 12px;
}

/* Students header styling */
.page-card .card-header h5 {
  font-size: 1.6rem;     /* bigger font */
  font-weight: 900;      /* bolder */
  color: #002699;        /* deep blue */
  margin: 0;
}

/* Light blue hover for table rows (stronger selector) */
table.table.table-hover > tbody > tr:hover {
  background-color: #e6f0ff !important;
  transition: background-color 0.2s ease;
}


/* ===== Page layout ===== */
body { background:#f6f8fb; }
.main-content { margin-left: 0 !important; }  /* cancel sidebar offset here */

/* Card + table */
.page-card{ border:0; border-radius:14px; box-shadow:0 10px 26px rgba(0,0,0,.08); }
.page-card .card-header{ background:#fff; border-bottom:1px solid #eef2f7; }
.table > :not(caption) > * > * { vertical-align: middle; }
.table thead th { background:#f8fafc; border-bottom:1px solid #eef2f7 !important; font-weight:600; color:#0f172a; }
.table-hover tbody tr:hover { background:#f9fbff; }

/* Let columns auto size (fixes broken vertical text) */
.table { table-layout: auto !important; }

.num-col  { width: 70px; text-align:center; font-weight:700; }
.img-col  { width: 90px; }
.email-col{ width: 32ch; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.pw-col   { width: 320px; }
.name-cell{ white-space: normal; word-break: break-word; }
.avatar-sm { width:42px; height:42px; object-fit:cover; border-radius:50%; border:2px solid #e5e7eb; }
.pw-wrap .form-control { font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace; }



/* Keep auto layout so columns can grow naturally */
.table { table-layout: auto !important; }

/* Fix Name column wrapping */
.name-col { min-width: 240px; }                 /* ensure it never gets too narrow */
.name-cell {
  white-space: normal;                          /* allow wrapping at spaces */
  word-break: keep-all;                         /* don't break inside words */
  overflow-wrap: break-word;                    /* wrap long multi-word names nicely */
}

/* Optional: slightly relax other fixed widths on smaller screens */
@media (max-width: 992px) {
  .email-col { max-width: 28ch; }
  .pw-col    { width: 260px; }
  .name-col  { min-width: 200px; }
}

</style>
</head>
<body>

<nav class="navbar navbar-expand-lg bg-white shadow-sm px-3">
  <div class="container-fluid d-flex justify-content-between align-items-center">
    <div class="fw-bold fs-5">
      <a href="/admin-dashboard" class="text-decoration-none">Admin Dashboard</a>
    </div>
    <a href="../admin-dashboard" class="btn btn-outline-secondary btn-sm">
      &larr; Back
    </a>
  </div>
</nav>

<div class="main-content">
  <div class="container py-4">
    <div class="row justify-content-center">
      <div class="col-12 col-lg-10 col-xl-9">

        <div class="card page-card">
  <div class="card-header d-flex justify-content-between align-items-center">
    <h5 class="mb-0 fw-semibold">Students</h5>
  </div>

          <div class="card-body">
            <div class="table-responsive">
              <table class="table table-hover align-middle mb-0">
                <thead>
                  <tr>
                    <th class="num-col">No.</th>
                    <th class="img-col">Image</th>
                    <th class="name-col">Name</th>
                    <th class="email-col">Email</th>
                    <th class="pw-col">Password</th>
                  </tr>
                </thead>
                <tbody>
                <%
                  @SuppressWarnings("unchecked")
                  List<Student> studs = (List<Student>) request.getAttribute("studs");
                  if (studs != null && !studs.isEmpty()) {
                    int no = 0;
                    for (Student s : studs) {
                      no++;
                      String name = (s.getName() != null) ? s.getName() : "-";
                      String email = (s.getEmail() != null) ? s.getEmail() : "-";
                      String pwd = (s.getPassword() != null) ? s.getPassword() : "";
                      String img = (s.getImage() != null && !s.getImage().trim().isEmpty())
                                   ? s.getImage()
                                   : "../assets/imgs/blank-profile.webp";
                      String inputId = "pw_" + no;
                %>
                  <tr>
                    <td class="num-col"><%= no %></td>
                    <td class="img-col">
                      <img class="avatar-sm" src="<%= img %>" alt="student" onerror="this.src='../assets/imgs/blank-profile.webp'">
                    </td>
                    <td class="name-cell"><%= name %></td>
                    <td class="email-col"><%= email %></td>
                    <td class="pw-col">
                      <div class="pw-wrap input-group input-group-sm">
                        <input id="<%= inputId %>" type="password" class="form-control" value="<%= pwd %>" placeholder="<%= pwd.isEmpty() ? "-" : "" %>" readonly>
                        <button class="btn btn-outline-secondary pw-toggle" type="button" data-target="<%= inputId %>" aria-label="Show password">
                          <i class="fa-solid fa-eye"></i>
                        </button>
                      </div>
                    </td>
                  </tr>
                <%
                    }
                  } else {
                %>
                  <tr>
                    <td colspan="5" class="text-center text-muted py-4">No students found.</td>
                  </tr>
                <%
                  }
                %>
                </tbody>
              </table>
            </div>
          </div>
        </div><!-- /.page-card -->

      </div><!-- /.col -->
    </div><!-- /.row -->
  </div><!-- /.container -->
</div>

<script>
  // toggle show/hide for all password rows
  (function () {
    document.addEventListener('click', function (e) {
      if (!e.target.closest('.pw-toggle')) return;
      var btn = e.target.closest('.pw-toggle');
      var id = btn.getAttribute('data-target');
      var input = document.getElementById(id);
      if (!input) return;
      var hidden = input.type === 'password';
      input.type = hidden ? 'text' : 'password';
      btn.innerHTML = hidden ? '<i class="fa-solid fa-eye-slash"></i>' : '<i class="fa-solid fa-eye"></i>';
      btn.setAttribute('aria-label', hidden ? 'Hide password' : 'Show password');
    });
  })();
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
