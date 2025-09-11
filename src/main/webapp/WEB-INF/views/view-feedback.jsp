<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.time.*"%>
<%@ page import="java.time.format.*"%>
<%@ page import="com.univoice.models.FeedbackSession"%>
<%@ page import="com.univoice.models.Issue"%>
<%@ page import="com.univoice.models.Admin"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UniVoice</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="../assets/css/adminstyle.css" rel="stylesheet" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css" referrerpolicy="no-referrer" />
<link href="https://cdn.datatables.net/1.13.8/css/dataTables.bootstrap5.min.css" rel="stylesheet">

<style>
/* ===== Navbar (same as profile) ===== */
.navbar{height:65px;border-bottom:1px solid #eee;background:#fff;font-family:system-ui,-apple-system,"Segoe UI",Roboto,"Helvetica Neue",Arial;}
.navbar .fw-bold a{font-size:25px;font-weight:700;color:#000066;text-decoration:none;}
.navbar i{color:#0f156d;font-size:1.2rem;}
/* small red circular counter for bell */
.notify-badge{
  position:absolute;top:-6px;right:-8px;background:#ef4444;color:#fff;border-radius:999px;
  min-width:18px;height:18px;font-size:11px;line-height:18px;text-align:center;padding:0 4px;
  box-shadow:0 0 0 2px #fff;
}

/* ===== Sidebar ===== */
.sidebar{position:fixed;top:64px;left:0;bottom:0;width:280px;padding:12px 8px;overflow-y:auto;background:#0d1694 !important;border-right:1px solid rgba(255,255,255,0.06);}
.sidebar a{display:block;color:#cbd5e1;text-decoration:none;padding:10px 8px;margin:4px 6px;border-radius:8px;font-weight:600;transition:background .2s,color .2s,transform .15s,box-shadow .2s;}
.sidebar a:hover{background:#2563eb;color:#fff;transform:translateX(3px);box-shadow:inset 3px 0 0 #1e3a8a;}
.sidebar hr{border-color:rgba(255,255,255,0.15) !important;margin:6px 12px;}

/* ===== Main Content ===== */
.main-content{margin-left:280px;padding-top:18px;}

/* ===== Sessions Card ===== */
.sessions-card{border:0;border-radius:18px;box-shadow:0 8px 20px rgba(0,0,0,.08);overflow:hidden;background:#fff;transition:transform .15s,box-shadow .15s;}
.sessions-card:hover{transform:translateY(-3px);box-shadow:0 12px 28px rgba(0,0,0,.12);}
.sessions-card .card-header{background:#f9fbff;border-bottom:1px solid #eef2f7;padding:20px 24px;}
.sessions-card .card-header h5{font-size:1.6rem;font-weight:700;color:#002699;margin:0;}
.sessions-card .card-header small{color:#475569;font-size:.9rem;}

/* ===== Table ===== */
.table thead th{background:#f8fafc;border-bottom:1px solid #eef2f7 !important;font-weight:600;font-size:20px;color:#0f172a;}
.table-hover tbody tr:hover{background:#f0f4ff;}
tr[role="button"]{cursor:pointer;}

/* ===== Due date pills ===== */
.pill{display:inline-flex;align-items:center;gap:.4rem;padding:.35rem .6rem;border-radius:999px;font-size:.78rem;font-weight:600;}
.pill-gray{background:#f1f5f9;color:#0f172a;}
.pill-green{background:#e8faf0;color:#166534;}
.pill-amber{background:#fff7e6;color:#92400e;}
.pill-red{background:#fee2e2;color:#991b1b;}

/* ===== Pagination ===== */
.dataTables_wrapper .dataTables_paginate{padding:.75rem 1rem 1rem;}
.dataTables_wrapper .dataTables_paginate .paginate_button{border:0 !important;border-radius:10px !important;padding:.45rem .75rem !important;margin:0 .125rem !important;}
.dataTables_wrapper .dataTables_paginate .paginate_button.current{background:#0ea5e9 !important;color:#fff !important;}
.dataTables_wrapper .dataTables_paginate .paginate_button:hover{background:#e2f2ff !important;color:#0c4a6e !important;}
</style>
</head>

<body>
<%
  Admin admin = (Admin) session.getAttribute("admin");
  String imagePath = (admin != null ? admin.getImage() : null);
  String adminName = (admin != null ? admin.getName()  : "Admin");
  Boolean pendingBell = (Boolean) request.getAttribute("pendingBell");
  Integer unseenPen   = (Integer) request.getAttribute("unseenPen");
%>

<!-- ===== Navbar (manual, matches profile) ===== -->
<nav class="navbar navbar-expand-lg bg-white shadow-sm px-3">
  <div class="container-fluid d-flex justify-content-between align-items-center">
    <div class="fw-bold fs-5 text-dark">
      <a href="/admin-dashboard" style="text-decoration:none;">Admin Dashboard</a>
    </div>
    <div class="d-flex align-items-center gap-3">
      <a href="/admin-dashboard/issues" class="text-decoration-none position-relative" title="Pending issues">
        <i class="fa-solid fa-bell"></i>
        <% if (pendingBell != null && pendingBell) { %>
          <span class="notify-badge"><%= (unseenPen != null ? unseenPen : 0) %></span>
        <% } %>
      </a>
      <a href="/admin-dashboard/profile" class="d-flex align-items-center text-decoration-none">
        <img src="<%= imagePath != null ? imagePath : "../assets/imgs/blank-profile.webp" %>"
             class="rounded-circle me-2" width="35" height="33" style="object-fit:cover;">
        <span class="fw-bold text-dark"><%= adminName %></span>
      </a>
    </div>
  </div>
</nav>

<!-- Sidebar -->
<div class="sidebar">
  <a href="../admin-dashboard/create">➕ Create Department</a><hr>
  <a href="../admin-dashboard/issues">📋 View Issues</a><hr>
  <a href="../admin-dashboard/questions">❓ Create Feedback Questions</a><hr>
  <a href="/admin-dashboard/viewfeedback">📝 View Feedback Answers</a><hr>
  <a href="../admin-dashboard/logout"><i class="fa fa-sign-out" aria-hidden="true"></i> Logout</a>
</div>

<!-- Main -->
<div class="main-content">
  <div class="container-fluid py-4">

    <!-- Created Sessions Box -->
    <div class="card sessions-card mt-4">
      <div class="card-header d-flex justify-content-between align-items-center">
        <h5 class="mb-0">Created Sessions</h5>
        <small>Click a session to view answers</small>
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
      try { createdPretty = LocalDateTime.parse(s.getCreated_at().replace(' ', 'T')).format(createdOut); } catch (Exception ignore) {}
      String duePretty = "-"; String duePillText = "N/A"; String duePillClass = "pill pill-gray";
      try {
        LocalDate due = LocalDate.parse(s.getDeadline_date(), dueIn);
        duePretty = due.format(dueOut);
        if (due.isBefore(today)) { duePillText="Overdue"; duePillClass="pill pill-red"; }
        else if (due.isEqual(today)) { duePillText="Due today"; duePillClass="pill pill-amber"; }
        else {
          long days = java.time.temporal.ChronoUnit.DAYS.between(today,due);
          if (days<=3) { duePillText="Due in "+days+" day"+(days==1?"":"s"); duePillClass="pill pill-amber"; }
          else { duePillText="In "+days+" days"; duePillClass="pill pill-green"; }
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
  }
%>
            </tbody>
          </table>
        </div>
      </div>
    </div>

  </div>
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.datatables.net/1.13.8/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.8/js/dataTables.bootstrap5.min.js"></script>
<script>
  $(function () {
    const dt = $('#sessionsTable').DataTable({
      searching:false, info:false, lengthChange:false, order:[[1,'desc']], pageLength:8,
      pagingType:'simple_numbers',
      dom:"<'table-responsive't><'d-flex justify-content-end px-3 py-2'p>",
      language:{ emptyTable:'No sessions found.', paginate:{ previous:'&laquo;', next:'&raquo;' } }
    });
    dt.on('draw', function(){
      const api = dt.api();
      const pages = api.page.info().pages;
      $(api.table().container()).find('.dataTables_paginate').toggle(pages>1);
    }).trigger('draw');
  });
</script>
</body>
</html>
