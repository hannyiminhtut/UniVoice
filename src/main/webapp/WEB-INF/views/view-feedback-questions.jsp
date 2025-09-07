<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.univoice.models.FeedbackSession" %>
<%@ page import="com.univoice.models.FeedbackQuestions" %>
<%@ page isELIgnored="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Session Questions</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="../assets/css/adminstyle.css" rel="stylesheet" />
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet"/>


<style>

  :root{
    --bg:#f6f8fb; --text:#111827; --muted:#6b7280; --ring:#2563eb;
    --card:#fff; --shadow:0 10px 28px rgba(2,8,20,.06);
  }
  
  html,body{ background:var(--bg); color:var(--text); }
  
  .appbar{ background:#fff; box-shadow:0 1px 0 rgba(2,8,20,.06); }
  
  .hero{
    background: linear-gradient(135deg,#4f46e5 0%, #06b6d4 100%);
    border-radius:18px; color:#fff; padding:22px 24px;
    box-shadow: 0 10px 28px rgba(4,9,20,.18);
  }
  
  .hero h4{ font-weight:800; letter-spacing:.2px; }
  
  .card-shell{
    background:var(--card); border:0; border-radius:16px; box-shadow:var(--shadow);
  }

  /* Question row */
  .q-row{
    display:flex; align-items:center; justify-content:space-between;
    padding:14px 16px; cursor:pointer; transition:.15s ease;
    border-bottom:1px solid #eef2f7;
  }
  .q-row:last-child{ border-bottom:0; }
  .q-row:hover{ background:#f8fafc; transform: translateY(-1px); }
  .q-title{ font-weight:700; margin-bottom:4px; }
  .q-meta{ color:var(--muted); font-size:.9rem; }
  
  .q-icon{
    width:44px; height:44px; display:grid; place-items:center;
    background:#eef2ff; color:#4f46e5; border-radius:12px;
    transition:.15s ease;
  }
  .q-row:hover .q-icon{ background:#e0e7ff; }

  /* Modal polish */
  .modal-content{ border:0; border-radius:16px; box-shadow:var(--shadow); }
  .modal-header{ border:0; padding-bottom:0; }
  .modal-title{ font-weight:700; }
  .chart-wrap{ position:relative; min-height:300px; }
  .skeleton{
    position:absolute; inset:0; display:flex; align-items:center; justify-content:center;
    background:linear-gradient(90deg,#f3f4f6 0,#e5e7eb 50%,#f3f4f6 100%);
    background-size:200% 100%; animation:shimmer 1.1s infinite;
    border-radius:12px;
  }
  @keyframes shimmer{ 0%{background-position:200% 0} 100%{background-position:-200% 0} }
  .legend-note{ color:#6b7280; font-size:.85rem; margin-top:6px; }

  /* Focus ring for keyboard users */
  .q-row:focus-visible{ outline:3px solid var(--ring); outline-offset:2px; border-radius:10px; }
  
  .q-num {
  min-width: 32px; height: 32px;
  border-radius: 50%;
  background: #e2e8f0;
  color: #111827;
  display: flex; align-items: center; justify-content: center;
  font-weight: 700; font-size: .85rem;
}
.q-row:hover .q-num { background:#dbe3ea; }

/* Question row hover → light blue */
.q-row:hover {
  background: #e8f1ff;   /* light blue shade */
  transform: translateY(-1px);
}

/* Questions header styling */
.card-shell h6 {
  font-size: 1.6rem;     /* bigger font */
  font-weight: 900;      /* stronger */
  color: #002699;        /* deep blue */
  margin-bottom: 0.5rem;
}

 .chart-wrap{
  position: relative;
  /* give the chart real space so it isn't 0px tall */
  height: 340px;
  min-height: 300px;

  /* center the canvas */
  display: flex;
  align-items: center;
  justify-content: center;
}

/* let the canvas fill the wrap */
.chart-wrap canvas{
  display: block;
  width: 100% !important;
  height: 100% !important;   /* pairs with maintainAspectRatio:false */
  margin: 0 auto;
}
 
 
  
</style>
</head>
<body>
<%
  FeedbackSession sess = (FeedbackSession) request.getAttribute("session");
  java.time.LocalDate today = java.time.LocalDate.now();

  // Extract deadline as LocalDate from common field types
  java.time.LocalDate deadlineLd = null;
  Object rawDeadline = (sess != null) ? sess.getDeadline_date() : null; // adjust getter if named differently

  if (rawDeadline instanceof java.time.LocalDate) {
      deadlineLd = (java.time.LocalDate) rawDeadline;
  } else if (rawDeadline instanceof java.util.Date) {
      deadlineLd = ((java.util.Date) rawDeadline).toInstant()
                     .atZone(java.time.ZoneId.systemDefault())
                     .toLocalDate();
  } else if (rawDeadline instanceof String) {
      try {
          deadlineLd = java.time.LocalDate.parse((String) rawDeadline); // expects ISO-8601 yyyy-MM-dd
      } catch (Exception ignore) {}
  }

  // Show delete when deadline is today or earlier
  boolean canDeleteSession = (deadlineLd != null) && !deadlineLd.isAfter(today);
%>

<!-- Main -->
<div class="main-content">
  <div class="container-fluid py-4">
   <div class="hero mb-4 d-flex justify-content-between align-items-start gap-3">
  <!-- LEFT: title + trash (inline) -->
  <div class="d-flex align-items-center gap-2 flex-wrap">
    <h4 class="mb-0">
      Session: <%= ((FeedbackSession)request.getAttribute("session")).getTitle() %>
    </h4>

    <% if (canDeleteSession) { %>
      <form
        action="<%= request.getContextPath() %>/admin-dashboard/deleteSession/<%= sess.getId() %>"
        method="post"
        class="m-0"
        onsubmit="return confirm('Delete this session? This action cannot be undone.');">
        <!-- <input type="hidden" name="_method" value="DELETE"> -->
        <button type="submit"
                class="btn btn-outline-light btn-sm"
                title="Delete session (deadline passed)"
                aria-label="Delete session">
          <i class="fa-solid fa-trash"></i>
        </button>
      </form>
    <% } %>

    <div class="w-100"></div>
    <div class="opacity-90">Click a question to view its answer distribution.</div>
  </div>

  <!-- RIGHT: back only -->
  <a class="btn btn-light fw-semibold" href="/admin-dashboard/viewfeedback" title="Back">
    <i class="fa fa-arrow-left me-1"></i> Back
  </a>
</div>
   
    

    <div class="card-shell">
      <div class="p-3 pb-0">
        <div class="d-flex align-items-center justify-content-between">
          <h6 class="mb-2 fw-semibold">Questions</h6>
        </div>
      </div>
      <div class="px-2">
       <ul class="list-unstyled mb-0">
          <%
			@SuppressWarnings("unchecked")
			List<FeedbackQuestions> questions = (List<FeedbackQuestions>) request.getAttribute("questions");
			if (questions != null && !questions.isEmpty()) {
			  int num = 0;
			  for (FeedbackQuestions q : questions) {
			    num++;
			%>
			<li class="q-row" tabindex="0"
			    data-qid="<%= q.getId() %>"
			onclick="openChart(this)"
			onkeypress="if(event.key==='Enter'){openChart(this);}">
			<div class="me-3 d-flex align-items-center gap-3">
			  <span class="q-num"><%= num %></span>
			<div>
			  <div class="q-title"><%= q.getQuestionText() %></div>
			  <div class="q-meta">Type: <%= q.getQuestionType() %></div>
			    </div>
			  </div>
			  <div class="q-icon"><i class="fa-solid fa-chart-pie"></i></div>
			</li>
			<%
			  }
			} else {
			%>
			<li class="p-4 text-center text-muted">No questions found for this session.</li>
			<% } %>
          
        </ul>
      </div>
    </div>
  </div>
</div>

<!-- Modal -->
<div class="modal fade" id="chartModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="chartTitle">Question</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="chart-wrap">
          <div id="chartSkeleton" class="skeleton">
            <div class="spinner-border" role="status" aria-label="loading"></div>
          </div>
          <canvas id="pieCanvas" height="260"></canvas>
        </div>
        <div class="legend-note">Hover a slice to see counts.</div>
      </div>
    </div>
  </div>
</div>

<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>
<script>
  var BASE = '<%= request.getContextPath() %>';
  var chart = null;
  var chartModalEl = document.getElementById('chartModal');
  var chartModal = new bootstrap.Modal(chartModalEl);
  var skeleton = document.getElementById('chartSkeleton');

  // store the last dataset while we wait for the modal to be shown
  var pendingRender = null;

  chartModalEl.addEventListener('hidden.bs.modal', function(){
    if (chart) { chart.destroy(); chart = null; }
    // reset canvas
    var old = document.getElementById('pieCanvas');
    var fresh = old.cloneNode(true); old.parentNode.replaceChild(fresh, old);
    pendingRender = null;
  });

  // when modal is fully visible, render (or resize) the chart
  chartModalEl.addEventListener('shown.bs.modal', function () {
    if (pendingRender) {
      renderChart(pendingRender.labels, pendingRender.counts);
      pendingRender = null;
    } else if (chart) {
      // if chart already exists, make sure it sizes correctly
      chart.resize();
    }
  });

  function openChart(li){
    var qid = li.getAttribute('data-qid');
    var title = li.querySelector('.q-title')?.innerText || 'Question';
    document.getElementById('chartTitle').innerText = title;

    chartModal.show();                 // show first
    skeleton.style.display = 'flex';   // show loader immediately

    var url = BASE + '/admin-dashboard/viewfeedback/api/question/' + qid;
    fetch(url, { headers: { 'Accept': 'application/json' } })
      .then(function(r){ if(!r.ok) throw new Error('HTTP ' + r.status); return r.json(); })
      .then(function(data){
        var labels = Array.isArray(data.labels) && data.labels.length ? data.labels : ['No responses yet'];
        var counts = Array.isArray(data.counts) && data.counts.length ? data.counts : [1];

        // queue rendering until the modal is fully shown
        pendingRender = { labels, counts };

        // if it's already shown (e.g., fast connection), render right away
        if (chartModalEl.classList.contains('show')) {
          renderChart(labels, counts);
          pendingRender = null;
        }
      })
      .catch(function(err){
        console.error(err);
        pendingRender = { labels:['Error'], counts:[1] };
        if (chartModalEl.classList.contains('show')) {
          renderChart(['Error'], [1]);
          pendingRender = null;
        }
      })
      .finally(function(){ skeleton.style.display = 'none'; });
  }

  function renderChart(labels, counts){
    var palette = [
      '#3b82f6','#22c55e','#ef4444','#f59e0b','#a855f7',
      '#06b6d4','#84cc16','#e11d48','#10b981','#6366f1'
    ];
    var bg = labels.map(function(_,i){ return palette[i % palette.length]; });

    var ctx = document.getElementById('pieCanvas').getContext('2d');
    if (chart) { chart.destroy(); chart = null; }

    chart = new Chart(ctx, {
      type: 'pie',
      data: { labels: labels, datasets: [{ data: counts, backgroundColor: bg }] },
      options: {
        responsive: true,
        maintainAspectRatio: false,   // <-- important with fixed-height container
        plugins: { legend: { position: 'bottom' } }
      }
    });
    chart.resize(); // ensure it picks up current modal size
  }
</script>

</body>
</html>
