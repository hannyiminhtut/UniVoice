<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.univoice.models.Issue"%>
<%@ page import="java.time.*" %>
<%@ page import="java.time.format.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>My Issues — UniVoice</title>

  <!-- Core CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="../assets/css/adminstyle.css" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

  <style>
    :root{
      --uv-primary:#6c63ff;
      --uv-primary-2:#8e2de2;
      --uv-bg:#f6f8fb;
      --uv-card:#ffffff;
      --uv-muted:#6b7280;
      --uv-border:#e5e7eb;
      --uv-shadow:0 18px 40px rgba(30,41,59,.12);
    }

    html,body{height:100%}
    body{
      background:
        radial-gradient(1200px 600px at -10% -20%, rgba(108,99,255,.15), transparent 60%),
        radial-gradient(800px 500px at 110% 10%, rgba(142,45,226,.12), transparent 60%),
        var(--uv-bg);
      font-family: 'Segoe UI', system-ui, -apple-system, Roboto, Arial, sans-serif;
      color:#0f172a;
    }

    /* Top hero */
    .uv-hero{
      background: linear-gradient(90deg, var(--uv-primary), var(--uv-primary-2));
      color:#fff;
      border-radius: 20px;
      padding: 24px;
      box-shadow: var(--uv-shadow);
    }
    .uv-hero .title{font-weight:800; letter-spacing:.2px; margin:0}
    .uv-hero .sub{opacity:.95}
    .crumb a{ color: rgba(255,255,255,.9); text-decoration:none; }
    .crumb a:hover{ text-decoration:underline; }

    /* Page card */
    .page-card{
      border:0; border-radius:18px; background:var(--uv-card);
      box-shadow:var(--uv-shadow);
      overflow:hidden;
    }
    .page-card .card-header{ background:#fff; border-bottom:1px solid #eef2f7; }

    /* Toolbar */
    .toolbar{
      position: sticky; top: 0; z-index: 50;
      background: rgba(255,255,255,.75);
      backdrop-filter: blur(8px);
      border: 1px solid var(--uv-border);
      padding: 12px;
      border-radius: 14px;
      margin-bottom: 16px;
    }
    .toolbar .form-control, .toolbar .form-select{
      border-radius: 12px; border:1px solid var(--uv-border);
    }
    .btn-soft{
      border-radius: 12px; border:1px solid var(--uv-border); background:#fff;
    }
    .btn-soft:hover{ border-color:#d1d5db; }

    /* Issue items */
    .acc-item{
      border:1px solid #eef2f7; border-radius:14px; background:#fff;
      box-shadow:0 8px 18px rgba(0,0,0,.06);
      overflow:hidden;
    }
    .acc-header{
      padding:14px 16px; cursor:pointer; transition: background .18s ease;
    }
    .acc-header:hover{ background:#f8fafc; }
    .num-badge{
      width:36px; height:36px; display:grid; place-items:center; border-radius:999px;
      background:#eef2ff; color:#4f46e5; font-weight:800;
    }
    .title-cell{ font-weight:700; color:#0f172a; }
    .meta{ color:var(--uv-muted); font-size:.92rem; }
    .acc-body{ padding:16px; border-top:1px solid #eef2f7; }

    /* Status badges */
    .badge-soft{ font-weight:700; letter-spacing:.3px; }
    .badge-pending   { background:#fee2e2; color:#991b1b; }
    .badge-assigned  { background:#fff7e6; color:#92400e; }
    .badge-resolved  { background:#dcfce7; color:#166534; }
    .badge-banned	 { background-color: #dc2626; color: #fff}

    /* Image */
    .img-wrap img{
      max-width:100%; border-radius:12px; border:1px solid var(--uv-border);
      box-shadow:0 6px 12px rgba(0,0,0,.06);
    }

    /* Note */
    .note-box{
      background:#f8fafc; border:1px dashed #dbe3ea; border-radius:12px; padding:12px;
    }

    /* Empty state */
    .empty{
      padding:40px 16px; text-align:center; color:var(--uv-muted);
    }
    .empty i{ font-size:34px; color: var(--uv-primary); }

    /* Subtle fade-in */
    .fade-in{ opacity:0; transform: translateY(8px); animation:fadeUp .35s ease forwards; }
    @keyframes fadeUp{ to{ opacity:1; transform:none; } }
  </style>
</head>
<body>

  <div class="container py-4">

    <!-- Hero / Breadcrumb -->
    <div class="uv-hero mb-4">
      <div class="d-flex align-items-center justify-content-between flex-wrap gap-2">
        <div>
          <div class="crumb mb-1">
            <a href="/student-dashboard"><i class="bi bi-house-door"></i> Dashboard</a>
            <span class="mx-2">›</span> <span style="opacity:.9">My Issues</span>
          </div>
          <h1 class="title">My Issues</h1>
          <p class="sub mb-0">Track each submission, status, and resolution details.</p>
        </div>
        <div>
          <a class="btn btn-light btn-sm" href="/student-dashboard">
            <i class="bi bi-arrow-left"></i> Back to Dashboard
          </a>
          <a class="btn btn-dark btn-sm" href="/student-dashboard/submitIssues">
            <i class="bi bi-plus-circle"></i> New Issue
          </a>
        </div>
      </div>
    </div>

    <!-- Page card -->
    <div class="page-card">
      <div class="card-header">
        <div class="d-flex align-items-center justify-content-between">
          
        </div>
      </div>

      <div class="card-body">

        <!-- Toolbar -->
        <div class="toolbar d-flex flex-wrap gap-2 align-items-center">
          <div class="flex-grow-1">
            <input id="searchBox" type="search" class="form-control" placeholder="Search by title, description or location (press Enter)">
          </div>
          <div>
            <select id="statusFilter" class="form-select">
              <option value="">All statuses</option>
              <option value="pending">Pending</option>
              <option value="assigned">Assigned</option>
              <option value="resolved">Resolved</option>
            </select>
          </div>
          <div>
            <select id="sortSelect" class="form-select">
              <option value="created_desc">Newest first</option>
              <option value="created_asc">Oldest first</option>
              <option value="resolved_desc">Resolved (newest)</option>
              <option value="resolved_asc">Resolved (oldest)</option>
            </select>
          </div>
          <div class="ms-auto d-flex gap-2">
            <button id="expandAll" class="btn btn-soft"><i class="bi bi-arrows-angle-expand"></i> Expand all</button>
            <button id="collapseAll" class="btn btn-soft"><i class="bi bi-arrows-angle-contract"></i> Collapse all</button>
          </div>
        </div>

        <%
          @SuppressWarnings("unchecked")
          List<Issue> issues = (List<Issue>) request.getAttribute("issues");

          if (issues == null || issues.isEmpty()) {
        %>
          <div class="empty">
            <i class="bi bi-inbox"></i>
            <h5 class="mt-3 mb-1">No issues yet</h5>
            <p class="mb-3">When you submit issues, they’ll appear here with real-time status updates.</p>
            <a href="/student-dashboard/submitIssues" class="btn btn-dark btn-sm">
              <i class="bi bi-plus-circle"></i> Submit your first issue
            </a>
          </div>
        <%
          } else {
            DateTimeFormatter outFmt = DateTimeFormatter.ofPattern("MMM dd, yyyy hh:mm a");
            DateTimeFormatter dbFmt  = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

            int idx = 0;
            for (Issue it : issues) {
              idx++;

              // Title
              String title   = it.getTitle() != null ? it.getTitle() : "(No title)";

              // Created display + sort key
              String createdRaw = it.getCreated_at() != null ? it.getCreated_at() : "";
              String created = createdRaw;
              String createdSort = "0";
              try {
                LocalDateTime cdt = LocalDateTime.parse(createdRaw, dbFmt);
                created = cdt.format(outFmt);
                createdSort = cdt.format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
              } catch (Exception ignore) {
                // fallback: try ISO-ish or leave as-is
                try {
                  created = LocalDateTime.parse(createdRaw.replace(' ','T')).format(outFmt);
                } catch(Exception ig2){}
              }

              // Status + badge
              String status = it.getStatus() != null ? it.getStatus() : "-";
              String statusLower = status.toLowerCase();
              String statusBadge = "badge-soft";
              if ("pending".equals(statusLower))      statusBadge += " badge-pending";
              else if ("assigned".equals(statusLower)) statusBadge += " badge-assigned";
              else if ("resolved".equals(statusLower)) statusBadge += " badge-resolved";
              else if("banned".equals(statusLower)) statusBadge += " badge-banned";

              // Description & Location
              String desc = it.getDescription() != null ? it.getDescription() : "-";
              String loc  = it.getLocation() != null ? it.getLocation() : "-";
              String img  = it.getImg();
              String note = it.getNote();

              // Resolved display + sort key (only if present)
              String resolvedRaw = it.getResolved_at();
              String resolvedDisplay = "";
              String resolvedSort = "";
              if (resolvedRaw != null && !resolvedRaw.trim().isEmpty()){
                try {
                  LocalDateTime rdt = LocalDateTime.parse(resolvedRaw, dbFmt);
                  resolvedDisplay = rdt.format(outFmt);
                  resolvedSort = rdt.format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
                } catch (Exception ignore) {
                  // fallback
                  resolvedDisplay = resolvedRaw;
                }
              }

              String datasetText = (title + " " + desc + " " + loc).toLowerCase();
              String accId = "issueAcc_" + idx;
        %>

        <!-- Issue item -->
        <div class="mb-3 acc-item fade-in issue-row"
             data-status="<%= statusLower %>"
             data-title="<%= datasetText %>"
             data-created="<%= createdSort %>"
             data-resolved="<%= resolvedSort %>">
          <div class="acc-header d-flex align-items-center justify-content-between"
               data-bs-toggle="collapse" data-bs-target="#<%= accId %>">
            <div class="d-flex align-items-center gap-3">
              <div class="num-badge"><%= idx %></div>
              <div>
                <div class="title-cell"><%= title %></div>
                <div class="meta">
                  <div><i class="bi bi-clock"></i> Submitted: <%= created != null && !created.isEmpty() ? created : "-" %></div>
                  <% if ("resolved".equals(statusLower)) { %>
                    <div><i class="bi bi-check2-circle"></i> Resolved: <%= (resolvedDisplay != null && !resolvedDisplay.isEmpty()) ? resolvedDisplay : "-" %></div>
                  <% } %>
                </div>
              </div>
            </div>
            <span class="badge <%= statusBadge %> text-uppercase"><%= status %></span>
          </div>

          <div id="<%= accId %>" class="collapse">
            <div class="acc-body">
              <div class="row g-3">
                <div class="col-12 col-lg-8">
                  <div class="mb-2">
                    <strong>Description</strong>
                    <div class="text-body-secondary"><%= desc %></div>
                  </div>
                  <div class="mb-2">
                    <strong>Location</strong>
                    <div class="text-body-secondary"><%= loc %></div>
                  </div>

                  <% if (note != null && !note.trim().isEmpty()) { %>
                    <div class="note-box mt-3">
                      <div class="fw-semibold mb-1"><i class="bi bi-journal-text"></i> Resolution Note</div>
                      <div><%= note %></div>
                    </div>
                  <% } else if ("resolved".equals(statusLower)) { %>
                    <div class="note-box mt-3">
                      <div class="fw-semibold mb-1"><i class="bi bi-journal-text"></i> Resolution Note</div>
                      <div class="text-muted">This issue is resolved. No note was provided.</div>
                    </div>
                  <% } %>
                </div>

                <% if (img != null && !img.trim().isEmpty()) { %>
                  <div class="col-12 col-lg-4">
                    <strong>Attachment</strong>
                    <div class="img-wrap mt-2">
                      <a href="<%= img %>" target="_blank" rel="noopener">
                        <img src="<%= img %>" alt="Attached image" onerror="this.style.display='none'">
                      </a>
                    </div>
                  </div>
                <% } %>
              </div>
            </div>
          </div>
        </div>

        <%
            } // end for
          } // end else
        %>
      </div>
    </div>

    <!-- Footer tiny -->
    <div class="text-center text-muted small mt-4 mb-2">
      UniVoice • My Issues
    </div>

  </div>

  <!-- JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    // Client-side search/filter/sort/expand-collapse (no backend changes)

    const searchBox   = document.getElementById('searchBox');
    const statusSel   = document.getElementById('statusFilter');
    const sortSel     = document.getElementById('sortSelect');
    const rows        = Array.from(document.querySelectorAll('.issue-row'));
    const expandAll   = document.getElementById('expandAll');
    const collapseAll = document.getElementById('collapseAll');

    function applyFilters(){
      const q = (searchBox.value || '').trim().toLowerCase();
      const st= (statusSel.value || '').toLowerCase();

      rows.forEach(row=>{
        const hay = row.dataset.title || '';
        const rs  = row.dataset.status || '';
        const matchesText = !q || hay.includes(q);
        const matchesStat = !st || rs === st;
        row.style.display = (matchesText && matchesStat) ? '' : 'none';
      });
    }

    function applySort(){
      const mode = sortSel.value;
      const list = rows.filter(r => r.style.display !== 'none');
      const parent = list.length ? list[0].parentElement : null;
      if(!parent) return;

      list.sort((a,b)=>{
        const ca = a.dataset.created || '0';
        const cb = b.dataset.created || '0';
        const ra = a.dataset.resolved || '0';
        const rb = b.dataset.resolved || '0';

        switch(mode){
          case 'created_asc' : return ca.localeCompare(cb);
          case 'created_desc': return cb.localeCompare(ca);
          case 'resolved_asc': return ra.localeCompare(rb);
          case 'resolved_desc':return rb.localeCompare(ra);
          default: return 0;
        }
      });

      list.forEach(el => parent.appendChild(el));
    }

    function recalc(){
      applyFilters();
      applySort();
      toggleNoResults();
    }

    function toggleNoResults(){
      const visible = rows.some(r => r.style.display !== 'none');
      if(!visible){
        if(!document.getElementById('noResults')){
          const div = document.createElement('div');
          div.id = 'noResults';
          div.className = 'empty';
          div.innerHTML = `
            <i class="bi bi-search"></i>
            <h5 class="mt-3 mb-1">No results</h5>
            <p class="mb-0">Try changing your search or filters.</p>
          `;
          document.querySelector('.card-body').appendChild(div);
        }
      }else{
        const nr = document.getElementById('noResults');
        if(nr) nr.remove();
      }
    }

    // Expand / Collapse all
    expandAll.addEventListener('click', ()=>{
      document.querySelectorAll('.acc-item .collapse').forEach(c=>{
        const inst = bootstrap.Collapse.getOrCreateInstance(c, {toggle:false});
        inst.show();
      });
    });
    collapseAll.addEventListener('click', ()=>{
      document.querySelectorAll('.acc-item .collapse').forEach(c=>{
        const inst = bootstrap.Collapse.getOrCreateInstance(c, {toggle:false});
        inst.hide();
      });
    });

    // Bind
    searchBox.addEventListener('keydown', (e)=>{ if(e.key==='Enter'){ e.preventDefault(); recalc(); }});
    statusSel.addEventListener('change', recalc);
    sortSel.addEventListener('change', recalc);

    // Initial
    recalc();
  </script>
</body>
</html>
