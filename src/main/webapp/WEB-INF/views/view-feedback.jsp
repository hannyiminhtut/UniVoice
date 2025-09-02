<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.time.*" %>
<%@ page import="java.time.format.*" %>
<%@ page import="com.univoice.models.FeedbackSession" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Feedback Answers</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css" referrerpolicy="no-referrer" />
<link href="https://cdn.datatables.net/1.13.8/css/dataTables.bootstrap5.min.css" rel="stylesheet">
<link rel="stylesheet" href="../assets/css/adminstyle.css" />

<style>

  :root { --card-radius:16px; --shadow:0 12px 30px rgba(2,6,23,.08); }

  .sessions-card { border:0; border-radius:var(--card-radius); box-shadow:var(--shadow); overflow:hidden; }
  
  .sessions-card .card-header { background:#fff; border-bottom:1px solid #eef2f7; padding:18px 22px; }

  .table thead th {
    background:#f8fafc; border-bottom:1px solid #eef2f7 !important; font-weight:600; color:#0f172a;
  }
  .table-hover tbody tr:hover { background:#f9fbff; }
  tr[role="button"] { cursor:pointer; }

  /* Due date pill */
  .pill { display:inline-flex; align-items:center; gap:.4rem; padding:.35rem .6rem; border-radius:999px; font-size:.78rem; font-weight:600; }
  .pill-gray{ background:#f1f5f9; color:#0f172a; }
  .pill-green{ background:#e8faf0; color:#166534; }
  .pill-amber{ background:#fff7e6; color:#92400e; }
  .pill-red{ background:#fee2e2; color:#991b1b; }

  /* Minimal, pretty pagination */
  .dataTables_wrapper .dataTables_paginate { padding: .75rem 1rem 1rem; }
  .dataTables_wrapper .dataTables_paginate .paginate_button {
    border:0 !important; border-radius:10px !important; padding:.45rem .75rem !important; margin:0 .125rem !important;
  }
  .dataTables_wrapper .dataTables_paginate .paginate_button.current { background:#0ea5e9 !important; color:#fff !important; }
  .dataTables_wrapper .dataTables_paginate .paginate_button:hover { background:#e2f2ff !important; color:#0c4a6e !important; }
</style>
</head>
<body>
<nav class="navbar navbar-expand-lg bg-white shadow-sm px-3">
  <div class="container-fluid d-flex justify-content-between align-items-center">
    <div class="fw-bold fs-5 text-dark">
      <a href="../admin-dashboard" style="text-decoration:none;">Admin Dashboard</a>
    </div>
    <div class="d-flex align-items-center gap-3">
      <a href="#" class="text-decoration-none position-relative"><i class="fa-solid fa-envelopes-bulk"></i></a>
      <a href="#" class="text-decoration-none position-relative"><i class="fa-solid fa-bell"></i></a>
      <div class="d-flex align-items-center">
        <img src="../assets/imgs/blank-profile.webp" class="rounded-circle me-2" width="35" height="33" style="object-fit: cover;">
        <div class="fw-bold">Admin</div>
      </div>
    </div>
  </div>
</nav>

<!-- keep your original vertical sidebar -->
<div class="sidebar">
  <a href="../admin-dashboard/create">➕ Create Department</a><hr style="border-color:#457b9d;">
  <a href="../admin-dashboard/issues">📋 View Issues</a><hr style="border-color:#457b9d;">
  <a href="../admin-dashboard/questions">❓ Create Feedback Questions</a><hr style="border-color:#457b9d;">
  <a href="../admin-dashboard/viewfeedback">📝 View Feedback Answers</a><hr style="border-color:#457b9d;">
  <a href="../admin-dashboard/logout"><i class="fa fa-sign-out"></i>  Logout</a>
</div>

<div class="main-content">
  <div class="container-fluid py-4">
  
  	 <div class="sessions-card" >
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
		
    <div class="card sessions-card">
      <div class="card-header d-flex justify-content-between align-items-center">
        <h5 class="mb-0 fw-semibold">Created Sessions</h5>
        <small class="text-muted">Click a session to view answers</small>
      </div>
      <div class="card-body p-0">
        <div class="table-responsive">
          <table id="sessionsTable" class="table table-hover align-middle mb-0">
            <thead>
              <tr>
                <th style="width:48%;">Title</th>
                <th>Created</th>
                <th>Due Date</th>
              </tr>
            </thead>
            <tbody>
<%
  @SuppressWarnings("unchecked")
  List<FeedbackSession> sessions = (List<FeedbackSession>) request.getAttribute("sessions");

  DateTimeFormatter createdOut = DateTimeFormatter.ofPattern("MMM dd, yyyy hh:mm a");
  DateTimeFormatter dueIn = DateTimeFormatter.ofPattern("yyyy-MM-dd");
  DateTimeFormatter dueOut = DateTimeFormatter.ofPattern("MMM dd, yyyy");

  LocalDate today = LocalDate.now();

  if (sessions != null && !sessions.isEmpty()) {
    for (FeedbackSession s : sessions) {
      String createdPretty = "-";
      try {
        createdPretty = LocalDateTime.parse(s.getCreated_at().replace(' ', 'T')).format(createdOut);
      } catch (Exception ignore) {}

      String duePretty = "-";
      String duePillText = "N/A";
      String duePillClass = "pill pill-gray";
      try {
        LocalDate due = LocalDate.parse(s.getDeadline_date(), dueIn);
        duePretty = due.format(dueOut);

        if (due.isBefore(today)) {
          duePillText = "Overdue";
          duePillClass = "pill pill-red";
        } else if (due.isEqual(today)) {
          duePillText = "Due today";
          duePillClass = "pill pill-amber";
        } else {
          long days = java.time.temporal.ChronoUnit.DAYS.between(today, due);
          if (days <= 3) {
            duePillText = "Due in " + days + " day" + (days==1?"":"s");
            duePillClass = "pill pill-amber";
          } else {
            duePillText = "In " + days + " days";
            duePillClass = "pill pill-green";
          }
        }
      } catch (Exception ignore) {}
%>
              <tr onclick="location.href='/admin-dashboard/viewfeedback/<%= s.getId() %>'" role="button" aria-label="Open session <%= s.getTitle() %>">
                <td class="fw-semibold"><%= s.getTitle() %></td>
                <td><%= createdPretty %></td>
                <td>
                  <div class="<%= duePillClass %>">
                    <i class="fa-solid fa-calendar-day"></i>
                    <span><%= duePretty %></span>
                    <span class="ms-2">• <%= duePillText %></span>
                  </div>
                </td>
              </tr>
<%
    }
  } // else: DataTables will show empty state
%>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.datatables.net/1.13.8/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.8/js/dataTables.bootstrap5.min.js"></script>
<script>
  $(function () {
    const dt = $('#sessionsTable').DataTable({
      searching: false,     
      info: false,          
      lengthChange: false, 
      order: [[1,'desc']],
      pageLength: 8,
      pagingType: 'simple_numbers',
      dom: "<'table-responsive't><'d-flex justify-content-end px-3 py-2'p>",
      language: {
        emptyTable: 'No sessions found.',
        paginate: { previous: '&laquo;', next: '&raquo;' }
      }
    });

    // Optional: auto-hide pagination if only one page
    dt.on('draw', function() {
      const api = dt.api();
      const pages = api.page.info().pages;
      $(api.table().container()).find('.dataTables_paginate').toggle(pages > 1);
    }).trigger('draw');
  });
  
  setTimeout(() => {
	    const alerts = document.querySelectorAll('.alert');
	    alerts.forEach(alert => alert.remove());
	}, 5000);
</script>
</body>
</html>
