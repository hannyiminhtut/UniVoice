<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.univoice.models.Issue" %>
<%@ page import="com.univoice.models.Admin" %>
<%@ page import="java.util.List" %>
<%
    List<Issue> issues = (List<Issue>) request.getAttribute("issues");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UniVoice</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css"  crossorigin="anonymous" referrerpolicy="no-referrer" />
<link href="../assets/css/view-issues.css" rel="stylesheet" />
<style>
  :root{
    --bg: #f6f8fc;
    --ink:#0f172a;
    --muted:#64748b;
    --card:#ffffff;
    --border:#eef2f7;
    --shadow: 0 12px 28px rgba(15,23,42,.10);
    --shadow-hover: 0 18px 40px rgba(15,23,42,.14);
  }


  .navbar{
    height:65px;
    border-bottom:1px solid #eee;
    background:#fff;
    font-family:system-ui,-apple-system,"Segoe UI",Roboto,"Helvetica Neue",Arial;
  }
  .navbar .fw-bold a{
    font-size:25px;
    font-weight:700;
    color:#000066;
    text-decoration:none;
  }
  .navbar i{ color:#0f156d; font-size:1.2rem; }

  .page-title {
  font-weight: 800;
  letter-spacing: .2px;
  padding: 12px 0; /* top & bottom padding */
}


  /* Page background + typography */
  body{
    background:
      radial-gradient(1200px 520px at -10% -5%, #eef2ff 15%, transparent 55%),
      radial-gradient(1000px 520px at 110% -5%, #f1f5ff 15%, transparent 55%),
      var(--bg);
    color: var(--ink);
    font-family: 'Segoe UI', system-ui, -apple-system, Roboto, Arial, sans-serif;
  }

  /* Page title */
  .page-title{
    font-weight:800;
    letter-spacing:.2px;
  }

  /* Cards grid */
  .fade-in{ opacity:0; transform: translateY(8px); animation:fadeUp .35s ease forwards; }
  @keyframes fadeUp{ to{ opacity:1; transform:none; } }

  .issue-card-link{
    text-decoration:none; color:inherit;
    display:block;
    border-left:6px solid #e5e7eb; /* default strip; overridden per status */
    border-radius:14px;
  }

  /* Status colored accent (no markup changes needed beyond data-status) */
  .issue-card-link[data-status="pending"]  { border-left-color:#fca5a5; } /* red-300 */
  .issue-card-link[data-status="assigned"] { border-left-color:#fbbf24; } /* amber-400 */
  .issue-card-link[data-status="resolved"] { border-left-color:#34d399; } /* emerald-400 */
  .issue-card-link[data-status="banned"]   { border-left-color:#ef4444; } /* red-500 */

  .issue-card{
    background:var(--card);
    border:1px solid var(--border);
    border-radius:14px;
    box-shadow: var(--shadow);
    transition: transform .18s ease, box-shadow .18s ease, border-color .18s ease, background .18s ease;
    min-height:146px;
  }
  .issue-card:hover{
    transform: translateY(-3px);
    box-shadow: var(--shadow-hover);
    border-color:#dbeafe; /* light blue border on hover */
  }

  /* Status-aware hover tint for the whole card */
  .issue-card-link[data-status="pending"]  .issue-card:hover{ background:#fff6f6; }
  .issue-card-link[data-status="assigned"] .issue-card:hover{ background:#fff9ec; }
  .issue-card-link[data-status="resolved"] .issue-card:hover{ background:#eefcf4; }
  .issue-card-link[data-status="banned"]   .issue-card:hover{ background:#fff1f2; }

  .issue-title{
    margin:0;
    font-size:1.05rem;
    font-weight:800;
    letter-spacing:.2px;
    color:var(--ink);
  }
  .issue-date{ color:var(--muted); margin-bottom:0; }

  /* Unread dot */
  .unread-dot{
    display:inline-block;
    width:10px; height:10px;
    background:#ef4444;
    border-radius:50%;
    top:12px; right:12px;
  }

  /* Alerts look a bit nicer */
  .alert{ border:0; border-radius:12px; box-shadow: var(--shadow); }
</style>
</head>
<body>
<!-- Top Navbar (unchanged) -->
<%
    // Count issues that have resolution notes (unread)
    int noteCount = 0;
    if (issues != null) {
        for (Issue i : issues) {
            if (i.getNote() != null && !i.getNote().trim().isEmpty() && !i.getRead_note()) {
                noteCount++;
            }
        }
    }
%>
<nav class="navbar navbar-expand-lg bg-white shadow-sm px-3">
  <div class="container-fluid d-flex justify-content-between align-items-center">
    <!-- Left: Title -->
    <div class="fw-bold fs-5 text-dark">
      <a href="../admin-dashboard" style="text-decoration:none;">Admin Dashboard</a>
    </div>

    <!-- Right-side icons and profile -->
    <div class="d-flex align-items-center gap-4">
      <a href="#" id="bellBtn" class="text-decoration-none position-relative d-flex align-items-center">
        <i class="fa-solid fa-bell fs-5"></i>
        <% if (noteCount > 0) { %>
          <span id="bellCount" class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger"><%= noteCount %></span>
        <% } %>
      </a>

      <!-- Profile -->
      <div class="d-flex align-items-center">
        <%
          Admin admin = (Admin)session.getAttribute("admin");
          String imagePath = admin != null ? admin.getImage() : null;
          String adminName = admin != null ? admin.getName()  : "Admin";
        %>
        <a href="/admin-dashboard/profile" class="d-flex align-items-center text-decoration-none">
          <img src="<%= imagePath != null ? imagePath : "../assets/imgs/blank-profile.webp" %>"
               class="rounded-circle me-2" width="35" height="33" style="object-fit: cover;">
          <span class="fw-bold text-dark"><%= adminName %></span>
        </a>
      </div>
    </div>
  </div>
</nav>

<div class="container my-4">
  <h4 class="text-center page-title mb-4">
    <i class="fa-solid fa-list-check me-2 text-primary"></i> Submitted Issues
  </h4>

  <!-- notices -->
  <div class="row">
    <div class="col-md-12">
      <% if (request.getAttribute("success") != null) { %>
        <div class="alert alert-success" role="alert"><%= request.getAttribute("success") %></div>
      <% } %>
      <% if (request.getAttribute("fail") != null) { %>
        <div class="alert alert-danger" role="alert"><%= request.getAttribute("fail") %></div>
      <% } %>
    </div>
  </div>

  <div class="row">
    <%
      if (issues != null && !issues.isEmpty()) {
        int delay = 0;
        for (Issue issue : issues) {
          String statusLower = issue.getStatus() != null ? issue.getStatus().toLowerCase() : "";
    %>
      <div class="col-md-4 mb-4 fade-in" style="animation-delay: <%= delay %>ms;">
        <a href="<%= request.getContextPath() %>/admin-dashboard/issues/<%= issue.getIssue_id() %>"
           class="issue-card-link position-relative"
           data-issue-id="<%= issue.getIssue_id() %>"
           data-status="<%= statusLower %>">
          <div class="issue-card p-3 position-relative h-100">
            <% if (issue.getNote() != null && !issue.getNote().trim().isEmpty() && !issue.getRead_note()) { %>
              <span class="unread-dot position-absolute"></span>
            <% } %>

            <h5 class="issue-title">
              <i class="fa-solid fa-bug text-danger me-2"></i> <%= issue.getTitle() %>
            </h5>

            <p class="issue-date mt-2">
              <i class="fa-regular fa-calendar-days me-1"></i> <%= issue.getCreated_at() %>
            </p>

            <p class="issue-status mt-2 mb-0">
              <% if ("pending".equalsIgnoreCase(issue.getStatus())) { %>
                <span class="badge bg-danger"><i class="fa-solid fa-clock me-1"></i> Pending</span>
              <% } else if ("assigned".equalsIgnoreCase(issue.getStatus())) { %>
                <span class="badge bg-warning text-dark"><i class="fa-solid fa-user-check me-1"></i> Assigned</span>
              <% } else if ("resolved".equalsIgnoreCase(issue.getStatus())) { %>
                <span class="badge bg-success"><i class="fa-solid fa-circle-check me-1"></i> Resolved</span>
              <% } else if ("banned".equalsIgnoreCase(issue.getStatus())) { %>
                <span class="badge bg-dark"><i class="fa-solid fa-ban me-1"></i> Banned</span>
              <% } %>
            </p>
          </div>
        </a>
      </div>
    <%
          delay += 150; // staggered animation effect
        }
      } else {
    %>
      <p class="text-center text-muted">No issues submitted yet.</p>
    <%
      }
    %>
  </div>
</div>

<script>
  // Auto-dismiss alerts
  setTimeout(() => {
    document.querySelectorAll('.alert').forEach(alert => alert.remove());
  }, 5000);

  // Bell interactions (show dots; decrement on card click)
  document.addEventListener("DOMContentLoaded", function () {
    const bellBtn = document.getElementById("bellBtn");
    const bellCount = document.getElementById("bellCount");

    if (bellBtn){
      bellBtn.addEventListener("click", function (e) {
        e.preventDefault();
        document.querySelectorAll(".unread-dot").forEach(dot => { dot.style.display = "block"; });
      });
    }

    document.querySelectorAll(".issue-card-link").forEach(link => {
      link.addEventListener("click", function () {
        const dot = this.querySelector(".unread-dot");
        if (dot) {
          dot.remove();
          if (bellCount) {
            let count = parseInt(bellCount.textContent);
            if (!isNaN(count) && count > 0) {
              bellCount.textContent = --count;
              if (count === 0) bellCount.remove();
            }
          }
        }
      });
    });
  });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" ></script>
</body>
</html>