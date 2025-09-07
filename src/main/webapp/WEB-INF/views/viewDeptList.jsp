<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.univoice.models.Department"%>
<%@ page import="com.univoice.models.Admin"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Departments — UniVoice</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="../assets/css/adminstyle.css" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css" referrerpolicy="no-referrer" />

  <style>
    /* No sidebar on this page */
    .main-content { margin-left: 0 !important; }

    /* Centered card + shadow */
    .page-card {
      border: 0;
      border-radius: 16px;
      box-shadow: 0 12px 28px rgba(0,0,0,.12);
      background: #fff;
    }

    /* Header text */
    .page-card .card-header h5 {
      font-size: 1.4rem;
      font-weight: 800;
      color: #002699;
      margin: 0;
    }

    /* Create button */
    .btn-create {
      background-color: #1e40af;
      border: none;
      color: #fff;
      font-weight: 600;
      border-radius: 8px;
      padding: .45rem 1rem;
      transition: background-color .2s ease, transform .15s ease;
    }
    .btn-create:hover { background-color: #2563eb; transform: translateY(-2px); }
    .btn-create:active { background-color: #1d4ed8; transform: translateY(0); }

    .table > :not(caption) > * > * { vertical-align: middle; }
    .btn-icon { display: inline-flex; align-items: center; gap: .4rem; }

    /* ===== Navbar (same as other admin pages) ===== */
    .navbar{ height:65px; border-bottom:1px solid #eee; background:#fff;
             font-family:system-ui,-apple-system,"Segoe UI",Roboto,"Helvetica Neue",Arial; }
    .navbar .fw-bold a{ font-size:25px; font-weight:700; color:#000066; text-decoration:none; }
    .navbar i{ color:#0f156d; font-size:1.2rem; }
    /* Bell counter */
    .notify-badge{
      position:absolute; top:-6px; right:-8px; background:#ef4444; color:#fff; border-radius:999px;
      min-width:18px; height:18px; font-size:11px; line-height:18px; text-align:center; padding:0 4px;
      box-shadow:0 0 0 2px #fff;
    }
  </style>
</head>
<body>

<%
  // Same navbar data used elsewhere
  Admin admin = (Admin) session.getAttribute("admin");
  String imagePath = (admin != null ? admin.getImage() : null);
  String adminName = (admin != null ? admin.getName()  : "Admin");

  Boolean pendingBell = (Boolean) request.getAttribute("pendingBell");
  Integer unseenPen   = (Integer) request.getAttribute("unseenPen");
%>

<nav class="navbar navbar-expand-lg bg-white shadow-sm px-3">
  <div class="container-fluid d-flex justify-content-between align-items-center">
    <div class="fw-bold fs-5 text-dark">
      <a href="/admin-dashboard" class="text-decoration-none">Admin Dashboard</a>
    </div>
    <div class="d-flex align-items-center gap-3">
      <!-- Bell with optional badge -->
      <a href="/admin-dashboard/issues" class="text-decoration-none position-relative" title="Pending issues">
        <i class="fa-solid fa-bell"></i>
        <% if (pendingBell != null && pendingBell) { %>
          <span class="notify-badge"><%= (unseenPen != null ? unseenPen : 0) %></span>
        <% } %>
      </a>
      <!-- Profile -->
      <a href="/admin-dashboard/profile" class="d-flex align-items-center text-decoration-none">
        <img src="<%= imagePath != null ? imagePath : "../assets/imgs/blank-profile.webp" %>"
             class="rounded-circle me-2" width="35" height="33" style="object-fit:cover;">
        <span class="fw-bold text-dark"><%= adminName %></span>
      </a>
    </div>
  </div>
</nav>

<!-- Main Content -->
<div class="main-content">
  <div class="container py-4">
    <div class="row justify-content-center">
      <div class="col-12 col-lg-10 col-xl-8">

        <% if (request.getAttribute("success") != null) { %>
          <div class="alert alert-success" role="alert"><%= request.getAttribute("success") %></div>
        <% } %>
        <% if (request.getAttribute("ok") != null) { %>
          <div class="alert alert-success" role="alert"><%= request.getAttribute("ok") %></div>
        <% } %>

        <div class="card page-card">
          <div class="card-header d-flex justify-content-between align-items-center">
            <h5 class="mb-0 fw-semibold">Departments</h5>
            <a href="/admin-dashboard/create" class="btn btn-create btn-icon">
              <i class="fa-solid fa-plus"></i><span>Create</span>
            </a>
          </div>

          <div class="card-body">
            <div class="table-responsive">
              <table class="table table-hover align-middle mb-0">
                <thead>
                  <tr>
                    <th style="width:80px;">No.</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th style="width:200px;">Actions</th>
                  </tr>
                </thead>
                <tbody>
                <%
                  @SuppressWarnings("unchecked")
                  List<Department> depts = (List<Department>) request.getAttribute("depts");
                  if (depts != null && !depts.isEmpty()) {
                    int no = 0;
                    for (Department d : depts) { no++; %>
                      <tr>
                        <td><span class="fw-bold"><%= no %></span></td>
                        <td><%= d.getName() %></td>
                        <td><%= d.getEmail() %></td>
                        <td>
                          <div class="d-flex gap-2">
                            <a class="btn btn-sm btn-warning btn-icon"
                               href="/admin-dashboard/departments/edit/<%= d.getId() %>">
                              <i class="fa-solid fa-pen-to-square"></i><span>Update</span>
                            </a>
                            <form action="/admin-dashboard/departments/delete/<%= d.getId() %>" method="post"
                                  onsubmit="return confirm('Delete department &quot;<%= d.getName() %>&quot;?');">
                              <button type="submit" class="btn btn-sm btn-danger btn-icon">
                                <i class="fa-solid fa-trash"></i><span>Delete</span>
                              </button>
                            </form>
                          </div>
                        </td>
                      </tr>
                <%
                    }
                  } else {
                %>
                  <tr>
                    <td colspan="4" class="text-center text-muted py-4">No departments found.</td>
                  </tr>
                <%
                  }
                %>
                </tbody>
              </table>
            </div>
          </div>

        </div><!-- /.page-card -->

      </div>
    </div>
  </div>
</div>

<script>
  setTimeout(() => { document.querySelectorAll('.alert').forEach(a => a.remove()); }, 5000);
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
