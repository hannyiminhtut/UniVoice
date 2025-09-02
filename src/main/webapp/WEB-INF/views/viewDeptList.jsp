<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.univoice.models.Department"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Departments — UniVoice</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="../assets/css/adminstyle.css" rel="stylesheet" />
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet"/>

  <style>
    .page-card{ border:0; border-radius:14px; box-shadow:0 10px 26px rgba(0,0,0,.08); }
    .page-card .card-header{ background:#fff; border-bottom:1px solid #eef2f7; }
    .table > :not(caption) > * > * { vertical-align: middle; }
    .btn-icon{ display:inline-flex; align-items:center; gap:.4rem; }
    .page-card { max-width: 1000px; margin: 0 auto; }
	.noti { max-width: 1000px; margin: 0 auto 1rem; }
  </style>
</head>
<body>

<nav class="navbar navbar-expand-lg bg-white shadow-sm px-3">
  <div class="container-fluid d-flex justify-content-between align-items-center">
    <div class="fw-bold fs-5 text-dark">
      <a href="/admin-dashboard" class="text-decoration-none">Admin Dashboard</a>
    </div>
    <div class="d-flex align-items-center gap-3">
      <a href="#" class="text-decoration-none position-relative"><i class="fa-solid fa-envelopes-bulk"></i></a>
      <a href="#" class="text-decoration-none position-relative"><i class="fa-solid fa-bell"></i></a>
      <div class="d-flex align-items-center">
        <img src="../assets/imgs/blank-profile.webp" class="rounded-circle me-2" width="35" height="33" style="object-fit:cover;">
        <div class="fw-bold">Admin</div>
      </div>
    </div>
  </div>
</nav>

<div class="main-content">
  <div class="container-fluid py-4">
  	<div class="noti" >

		<% if (request.getAttribute("success") != null) { %>
  			<div class="alert alert-success" role="alert">
   				 <%= request.getAttribute("success") %>
  			</div>
		<% } %>
		
		<% if (request.getAttribute("ok") != null) { %>
  			<div class="alert alert-success" role="alert">
   				 <%= request.getAttribute("ok") %>
  			</div>
		<% } %>
	
	</div>
    <div class="card page-card">
      <div class="card-header d-flex justify-content-between align-items-center">
        <div>
          <h5 class="mb-0 fw-semibold">Departments</h5>
         
        </div>
        <a href="/admin-dashboard/create" class="btn btn-primary btn-icon">
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
                for (Department d : depts) {
                  no++;
            %>
              <tr>
                <td><span class="fw-bold"><%= no %></span></td>
                <td><%= d.getName() %></td>
                <td><%= d.getEmail() %></td>
                <td>
                  <div class="d-flex gap-2">
                    <!-- Update/Edit -->
                    <a class="btn btn-sm btn-warning btn-icon"
                       href="/admin-dashboard/departments/edit/<%= d.getId() %>">
                      <i class="fa-solid fa-pen-to-square"></i><span>Update</span>
                    </a>

                    <!-- Delete (POST; adjust to your mapping) -->
                    <form action="/admin-dashboard/departments/delete/<%= d.getId() %>" method="post"
                          onsubmit="return confirm('Delete department &quot;<%= d.getName() %>&quot;?');">
                      <!-- If using Spring Security, include CSRF token (safe if not present) -->
                      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                      <!-- If you use HiddenHttpMethodFilter to support DELETE: -->
                      <!-- <input type="hidden" name="_method" value="DELETE"> -->
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

    </div>
  </div>
</div>
<script>
setTimeout(() => {
    const alerts = document.querySelectorAll('.alert');
    alerts.forEach(alert => alert.remove());
}, 5000);
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
