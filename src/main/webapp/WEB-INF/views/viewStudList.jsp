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
<style>
  body { background:#f6f8fb; }
  .page-card{ border:0; border-radius:14px; box-shadow:0 10px 26px rgba(0,0,0,.08); }
  .page-card .card-header{ background:#fff; border-bottom:1px solid #eef2f7; }
  .table > :not(caption) > * > * { vertical-align: middle; }
  .table thead th { background:#f8fafc; border-bottom:1px solid #eef2f7 !important; font-weight:600; color:#0f172a; }
  .table-hover tbody tr:hover { background:#f9fbff; }

  /* Center the card */
  .center-wrap { max-width: 1100px; margin: 0 auto; }

  /* Make Name take the remaining width */
  .table { table-layout: fixed; }              /* important */
  .num-col  { width: 70px; text-align:center; font-weight:700; }
  .img-col  { width: 90px; }
  .email-col{ width: 32ch; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
  .pw-col   { width: 320px; }
  .name-col { /* gets the remaining width */ }
  .name-cell{ white-space: normal; word-break: break-word; }
  .avatar-sm { width:42px; height:42px; object-fit:cover; border-radius:50%; border:2px solid #e5e7eb; }
  .pw-wrap .form-control { font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace; }
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
  <div class="container-fluid py-4">
    <div class="center-wrap">   <!-- centers the card -->

      <div class="card page-card">
        <div class="card-header d-flex justify-content-between align-items-center">
          <div>
            <h5 class="mb-0 fw-semibold">Students</h5>
          </div>
          
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
      </div>

    </div><!-- /.center-wrap -->
  </div>
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
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/js/all.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
