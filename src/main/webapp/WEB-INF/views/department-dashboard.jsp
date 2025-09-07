<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.univoice.models.Issue" %>
<%@ page import="com.univoice.models.Department" %>

<html>
<head>
    <title>Univoice</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
      :root{
        --uv-emerald:#10b981;
        --uv-teal:#06b6d4;
        --uv-emerald-dark:#0e9f75;
        --uv-teal-dark:#0597ad;
        --uv-bg:#f0fdf7;
      }

      body { background: var(--uv-bg); font-family: 'Segoe UI', sans-serif; }

      /* NAVBAR */
      .navbar.bg-white{
        background: linear-gradient(135deg, var(--uv-emerald), var(--uv-teal)) !important;
        color:#fff;
      }
      .navbar.bg-white a,
      .navbar.bg-white .fw-bold,
      .navbar.bg-white .fa-bell { color:#fff !important; }
      .navbar .dropdown-menu{ border-radius:12px; border:0; box-shadow:0 6px 18px rgba(0,0,0,.12); }

		.navbar {
  padding-top: 1rem;     /* increase top padding */
  padding-bottom: 1rem;  /* increase bottom padding */
  min-height: 70px;      /* enforce taller bar */
}
      /* Buttons */
      .btn-dark{
        background: linear-gradient(135deg, var(--uv-emerald), var(--uv-teal)) !important;
        border:0 !important; color:#fff !important; font-weight:700;
      }
      .btn-dark:hover{ background: linear-gradient(135deg, var(--uv-emerald-dark), var(--uv-teal-dark)) !important; }
      .btn-light{
        background:#ecfdf5 !important; color:#065f46 !important; border:1px solid #d1fae5 !important;
      }
      .btn-solve{
        background: linear-gradient(135deg, var(--uv-emerald), var(--uv-teal));
        color:#fff; border:0; border-radius:12px; padding:.6rem 1rem; font-weight:700;
        box-shadow:0 6px 14px rgba(16,185,129,.28);
      }
      .btn-solve:hover{ background: linear-gradient(135deg, var(--uv-emerald-dark), var(--uv-teal-dark)); }

      /* Alerts */
      .alert-success{ background:#ecfdf5; color:#065f46; border:1px solid #a7f3d0; }
      .alert-danger{ background:#fef2f2; color:#991b1b; border:1px solid #fecaca; }
      .alert-info{ background:#eff6ff; color:#1e40af; border:1px solid #bfdbfe; }

      /* Notification badge */
      .notify-badge{
        position:absolute; top:0; right:0; transform: translate(35%,-35%);
        background:#ef4444; color:#fff; border-radius:999px;
        font-size:.7rem; padding:.15rem .4rem; border:2px solid #fff;
      }

      /* ISSUE CARDS (tile style) */
      .issue-card {
        background:#fff;
        border-radius:22px;
        padding:20px 16px;
        cursor:pointer;
        text-align:center;
        border:1px solid #e5e7eb;
        box-shadow:0 6px 16px rgba(0,0,0,.06);
        transition: transform .25s ease, box-shadow .25s ease, border-color .25s ease;
        min-height:200px;
        display:flex; flex-direction:column; align-items:center; justify-content:center;
      }
      .issue-card:hover {
        transform: translateY(-6px);
        box-shadow: 0 14px 28px rgba(6,182,212,.22);
        border-color: rgba(6,182,212,.35);
      }

      .icon-badge {
        width:64px; height:64px; border-radius:50%;
        display:flex; align-items:center; justify-content:center;
        font-size:1.4rem; color:#fff;
        margin-bottom:12px;
        box-shadow:0 6px 14px rgba(0,0,0,.08);
      }
      .icon-pending  { background: linear-gradient(135deg,#f59e0b,#f97316); }
      .icon-assigned { background: linear-gradient(135deg,#06b6d4,#0ea5e9); }
      .icon-resolved { background: linear-gradient(135deg,#10b981,#059669); }

      .issue-title { font-weight:800; font-size:1rem; margin:0; color:#0f172a; }
      .issue-date { margin-top:6px; font-size:.85rem; color:#64748b; }
      .issue-date i{ color: var(--uv-emerald); }

      .issue-card .position-absolute.p-2.bg-danger{
        width:12px; height:12px; padding:0 !important;
        border:2px solid #fff; border-radius:50%;
      }

      /* Modal styling */
      .modal-content{ border-radius:16px; }
      .modal-header{ background:#f0fdf7; border-bottom:1px solid #e5e7eb; }
      .modal .modal-icon{
        width:38px; height:38px; border-radius:10px;
        display:flex; align-items:center; justify-content:center; color:#fff;
        margin-right:8px;
      }
      
      .section-header {
  padding: 1.5rem 0;     /* vertical padding */
}
.section-header h4 {
  font-size: 1.6rem;     /* make title a bit larger */
  font-weight: 800;
  margin-bottom: 0.5rem;
}
.section-header p {
  font-size: 1rem;       /* slightly bigger subtitle text */
  color: #4b5563;        /* darker muted text */
}

/* Dropdown menu fix */
.navbar .dropdown-menu {
  background: #fff;             /* keep menu white */
  color: #111;                  /* dark text */
}
.navbar .dropdown-menu .dropdown-item {
  color: #111 !important;       /* ensure visible text */
  font-weight: 500;
}
.navbar .dropdown-menu .dropdown-item:hover {
  background: #ecfdf5;          /* light green hover */
  color: #065f46 !important;    /* dark green text on hover */
}
.navbar .dropdown-menu .dropdown-item.text-danger {
  color: #dc2626 !important;    /* keep logout red */
}
.navbar .dropdown-menu .dropdown-item.text-danger:hover {
  background: #fef2f2;
  color: #991b1b !important;
}

    </style>
</head>
<body>
<%
  Department dept = (Department)request.getAttribute("department");
  String imagePath = (dept != null && dept.getImage()!=null) ? dept.getImage() : "../assets/imgs/blank-profile.webp";
%>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg bg-white shadow-sm px-3">
  <div class="container-fluid d-flex justify-content-between align-items-center">
    <div class="fw-bold fs-5">
      <a href="/department-dashboard" class="text-decoration-none" style="color:#fff;">Department Dashboard</a>
    </div>
    <div class="d-flex align-items-center gap-3">
      <a href="#" class="text-decoration-none position-relative">
        <i class="fa-solid fa-bell fs-5"></i>
        <%
          List<Issue> problems = (List<Issue>) request.getAttribute("issues");
          long unreadCount = 0;
          if (problems != null) {
            unreadCount = problems.stream().filter(i -> !i.getRead_dept()).count();
          }
          if (unreadCount > 0) {
        %>
          <span id="bellDot" class="notify-badge"><%= unreadCount %></span>
        <% } %>
      </a>

      <!-- Profile Dropdown -->
      <div class="dropdown">
        <a href="#" class="d-flex align-items-center text-decoration-none dropdown-toggle"
           id="profileDropdown" data-bs-toggle="dropdown" aria-expanded="false" style="color:#fff;">
          <img src="<%= imagePath %>" class="rounded-circle me-2" width="35" height="33" style="object-fit: cover;">
          <span class="fw-bold"><%= (dept!=null ? dept.getName() : "Department") %></span>
        </a>
        <ul class="dropdown-menu dropdown-menu-end shadow">
          <li><a class="dropdown-item" href="/department-dashboard/profile">Profile</a></li>
          <li>
            <form action="department-dashboard/logout" method="get" class="m-0">
              <button type="submit" class="dropdown-item text-danger">Logout</button>
            </form>
          </li>
        </ul>
      </div>
    </div>
  </div>
</nav>

<div class="container mt-4">
  <div class="text-center mb-4 section-header">
  <h4><i class="fa-solid fa-list-check me-2 text-primary"></i> Received Issues</h4>
  <p>Below are all issues reported to your department. Click on any card to view details or send a resolution note.</p>
</div>
  

  <!-- Alerts -->
  <div class="row g-4">
    <% if (request.getAttribute("success") != null) { %>
      <div class="alert alert-success"><%= request.getAttribute("success") %></div>
    <% } %>
    <% if (request.getAttribute("fail") != null) { %>
      <div class="alert alert-danger"><%= request.getAttribute("fail") %></div>
    <% } %>

    <%
      List<Issue> issues = (List<Issue>) request.getAttribute("issues");
      if (issues != null && !issues.isEmpty()) {
        int index = 0;
        for (Issue issue : issues) {
          String modalId = "issueModal" + index;
          String status = (issue.getStatus() != null) ? issue.getStatus().toLowerCase() : "";
          String iconClass, badgeClass;
          if ("pending".equals(status)) { iconClass="fa-solid fa-clock"; badgeClass="icon-pending"; }
          else if ("assigned".equals(status)) { iconClass="fa-solid fa-user-check"; badgeClass="icon-assigned"; }
          else if ("resolved".equals(status)) { iconClass="fa-solid fa-circle-check"; badgeClass="icon-resolved"; }
          else { iconClass="fa-solid fa-file-lines"; badgeClass="icon-assigned"; }
    %>

    <!-- Card -->
    <div class="col-md-4">
      <div class="issue-card position-relative"
           onclick="openIssueModal('<%= modalId %>', <%= issue.getIssue_id() %>)">

        <% if (!issue.getRead_dept()) { %>
          <span id="dot-<%= issue.getIssue_id() %>"
                class="position-absolute top-0 end-0 translate-middle p-2 bg-danger border border-light rounded-circle"></span>
        <% } else if (issue.getNote() != null) { %>
          <i class="fa-solid fa-circle-check text-success position-absolute top-0 end-0 fs-5 me-1 mt-1"></i>
        <% } %>

        <div class="icon-badge <%= badgeClass %>"><i class="<%= iconClass %>"></i></div>
        <h5 class="issue-title"><%= issue.getTitle() %></h5>
        <p class="issue-date mb-0"><i class="fa-regular fa-calendar-days me-1"></i> <%= issue.getCreated_at() %></p>
      </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="<%= modalId %>" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="issue-title d-flex align-items-center">
              <span class="modal-icon <%= badgeClass %>"><i class="<%= iconClass %>"></i></span>
              <%= issue.getTitle() %>
            </h5>
          </div>
          <div class="modal-body">
            <p><strong>Description:</strong> <%= issue.getDescription() %></p>
            <p><strong>Location:</strong> <%= issue.getLocation() %></p>
            <p><strong>Date:</strong> <%= issue.getCreated_at() %></p>
            <hr>
            <% if (issue.getImg() != null && !issue.getImg().isEmpty()) { %>
              <p><i class="fa-solid fa-image me-2"></i><strong>Attached Image:</strong></p>
              <img src="<%= issue.getImg() %>" class="issue-img" alt="Issue Image" width="200" height="250">
              <hr>
            <% } %>
            <% if (issue.getNote() == null) { %>
              <form action="department-dashboard/sendNote" method="post">
                <input type="hidden" name="issueId" value="<%= issue.getIssue_id() %>">
                <div class="mb-3">
                  <label class="form-label">Solution Note</label>
                  <textarea class="form-control" name="note" rows="3" required></textarea>
                </div>
                <button type="submit" class="btn btn-solve"><i class="fa-solid fa-paper-plane me-2"></i> Send solution</button>
              </form>
            <% } else { %>
              <i class="fa-solid fa-circle-check me-1 text-success"></i> We’ve already sent the resolution note
            <% } %>
          </div>
        </div>
      </div>
    </div>

    <%
          index++;
        }
      } else {
    %>
      <div class="alert alert-info text-center">No issues found for this department.</div>
    <% } %>
  </div>
</div>

<script>
function openIssueModal(modalId, issueId) {
  let modalEl = document.getElementById(modalId);
  let modal = new bootstrap.Modal(modalEl);
  modal.show();

  fetch('department-dashboard/markAsRead', {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
    body: 'issueId=' + issueId
  }).then(res => res.text()).then(data => {
    if (data === "OK") {
      let dot = document.getElementById('dot-' + issueId);
      if (dot) dot.remove();
      if (document.querySelectorAll('[id^="dot-"]').length === 0) {
        let bellDot = document.getElementById('bellDot');
        if (bellDot) bellDot.remove();
      }
    }
  });
}
setTimeout(() => { document.querySelectorAll('.alert').forEach(a => a.remove()); }, 5000);
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
