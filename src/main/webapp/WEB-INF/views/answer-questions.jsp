<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.univoice.models.FeedbackQuestions,com.univoice.models.FeedbackOptions,java.util.List,java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Feedback Form</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet"/>
<style>
  :root{
    --bg:#f0fdf7;                 /* light green */
    --card:#ffffff;
    --ink:#0f172a;
    --muted:#64748b;
    --brand:#10b981;              /* emerald */
    --brand2:#06b6d4;             /* teal */
    --ring:rgba(6,182,212,.20);   /* teal glow */
    --shadow:0 18px 40px rgba(2,6,23,.08);
    --mint:#ecfdf5;
    --mint-strong:#a7f3d0;
  }

  html,body{background:var(--bg);color:var(--ink);font-family:system-ui,-apple-system,"Segoe UI",Roboto,Arial,sans-serif}
  .frame{max-width:980px;margin:36px auto;padding:0 16px}

  /* Header */
  .session-header{padding:32px 0 16px}
  .session-header h2{font-size:2rem;font-weight:800;color:#065f46} /* deep emerald */
  .session-header p{font-size:1.05rem;color:var(--muted)}
  .btn-outline-primary{
    --bs-btn-color:#065f46; --bs-btn-border-color:#a7f3d0;
    --bs-btn-hover-color:#065f46; --bs-btn-hover-bg:#ecfdf5; --bs-btn-hover-border-color:#86efac;
  }

  /* Progress */
  .prog-head{display:flex;align-items:center;justify-content:space-between;margin-bottom:10px;color:var(--muted);font-weight:700}
  .progress-wrap{background:#e6fff7;height:10px;border-radius:999px;overflow:hidden;border:1px solid #d1fae5}
  .progress-wrap .bar{height:100%;width:0%;background:linear-gradient(90deg,var(--brand),var(--brand2));transition:width .25s ease}

  /* Question card */
  .q-card{background:var(--card);border:1px solid #eef2f7;border-radius:18px;box-shadow:var(--shadow);padding:24px 22px}
  .num-pill{width:38px;height:38px;border-radius:999px;display:grid;place-items:center;background:#d1fae5;color:#065f46;font-weight:800}
  .q-title{font-weight:800;font-size:clamp(1.05rem,2.4vw,1.35rem)}
  .q-sub{color:var(--muted)}

  /* Rating */
  .star-rating{font-size:2.1rem;color:#d1d5db;cursor:pointer;user-select:none}
  .star-rating .filled{color:#facc15} /* keep gold stars */

  /* Choices */
  .choice .btn{border-radius:12px;font-weight:600}
  .choice .btn-check:checked + .btn{
    background:var(--brand);border-color:var(--brand);color:#fff;
  }
  .choice .btn.btn-outline-primary{
    border-color:#d1fae5;color:#065f46;
  }
  .choice .btn.btn-outline-primary:hover{
    background:#ecfdf5;border-color:#a7f3d0;color:#065f46;
  }

  /* Footer nav */
  .q-foot{display:flex;align-items:center;justify-content:space-between;gap:12px}
  .btn-prev{
    border-radius:12px;font-weight:800;
    border:2px solid #d1fae5;color:#065f46;background:#ecfdf5;
  }
  .btn-prev:hover{background:#d1fae5;border-color:#a7f3d0;color:#065f46}

  .btn-next{
    background:linear-gradient(90deg,var(--brand),var(--brand2));
    border:0;color:#fff;font-weight:800;border-radius:12px;
    padding:.7rem 1.1rem;box-shadow:0 12px 24px var(--ring)
  }
  .btn-next:hover{filter:brightness(.98);color:#fff}
  .btn-next:disabled{opacity:.6}

  /* Dots */
  .dots{display:flex;gap:8px;justify-content:center;margin-top:14px}
  .dot{width:9px;height:9px;border-radius:999px;background:#ccefe6;transition:.2s}
  .dot.active{background:var(--brand);transform:scale(1.2)}

  /* Screens */
  .q-screen{display:none}
  .q-screen.active{display:block}
  
  .btn-outline-primary {
  --bs-btn-color: #065f46;                 /* deep emerald */
  --bs-btn-border-color: #a7f3d0;          /* mint border */
  --bs-btn-hover-color: #065f46;           /* dark green text */
  --bs-btn-hover-bg: #d1fae5;              /* pale mint background */
  --bs-btn-hover-border-color: #10b981;    /* emerald border */
  --bs-btn-active-bg: #10b981;             /* filled emerald when active */
  --bs-btn-active-border-color: #059669;   /* dark emerald border */
  --bs-btn-disabled-color: #6b7280;
  --bs-btn-disabled-border-color: #d1fae5;
}
  
</style>
</head>
<body>

<!-- header -->
<div class="session-header text-center mb-4">
  <div class="mb-3 text-start">
    <a href="javascript:history.back()" class="btn btn-outline-primary">
      <i class="fa-solid fa-arrow-left me-2"></i> Back to Sessions
    </a>
  </div>
  <h2 class="fw-bold mb-1">
    <%= request.getAttribute("sessionTitle")!=null?request.getAttribute("sessionTitle"):"Feedback Session" %>
  </h2>
  <p class="mb-0">
    <%= request.getAttribute("sessionSubtitle")!=null?request.getAttribute("sessionSubtitle"):"Participate to share your valuable feedback" %>
  </p>
</div>

<div class="frame">
  <div class="prog-head">
    <div></div>
    <div id="stepPct" data-step-pct>0% completed</div>
  </div>
  <div class="progress-wrap mb-3">
    <div class="bar" id="progressBar"></div>
  </div>

  <form action="submit" method="post" id="fbForm">
    <input type="hidden" name="sessionId" value="${sessionId}">
<%
  List<FeedbackQuestions> questions = (List<FeedbackQuestions>) request.getAttribute("questions");
  Map<Integer, List<FeedbackOptions>> optionsMap = (Map<Integer, List<FeedbackOptions>>) request.getAttribute("optionsMap");

  if (questions == null || questions.isEmpty()) {
%>
    <div class="alert alert-info">No questions available for this session.</div>
<%
  } else {
    int idx = 0;
    for (FeedbackQuestions q : questions) {
      int qIndex = idx++;
%>
    <div class="q-screen <%= (qIndex==0?"active":"") %>" data-index="<%= qIndex %>">
      <div class="q-card mb-2">
        <div class="d-flex align-items-center gap-3 mb-3">
          <div class="num-pill"><%= (qIndex+1) %></div>
          <div class="q-title"><%= q.getQuestionText() %></div>
        </div>

        <% if ("multiple".equalsIgnoreCase(q.getQuestionType())) {
             List<FeedbackOptions> opts = optionsMap!=null ? optionsMap.get(q.getId()) : null; %>
          <div class="row g-2 choice mt-1">
            <% if (opts != null) {
                 for (FeedbackOptions opt : opts) { %>
              <div class="col-12 col-md-6">
                <input type="radio" class="btn-check"
                       name="q_<%= q.getId() %>"
                       id="q<%= q.getId() %>_<%= opt.getId() %>"
                       value="<%= opt.getOption_text() %>">
                <label class="btn btn-outline-primary w-100 py-2"
                       for="q<%= q.getId() %>_<%= opt.getId() %>"><%= opt.getOption_text() %></label>
              </div>
            <%   }
               } else { %>
              <div class="col-12"><em class="text-muted">No options found.</em></div>
            <% } %>
          </div>
        <% } else if ("rating".equalsIgnoreCase(q.getQuestionType())) { %>
          <div class="mt-2">
            <div class="star-rating text-center" data-question="q_<%= q.getId() %>">
              <% for (int s=1;s<=5;s++){ %><span class="star" data-value="<%= s %>">&#9733;</span><% } %>
            </div>
            <input type="hidden" name="q_<%= q.getId() %>" id="q_<%= q.getId() %>_value">
            <div class="text-center q-sub mt-1"><small><span id="rate_<%= q.getId() %>">0</span>/5</small></div>
          </div>
        <% } else { %>
          <div class="mt-2"><em class="text-muted">Unsupported question type.</em></div>
        <% } %>

        <hr class="mt-4 mb-3">
        <div class="q-foot">
          <button type="button" class="btn btn-prev" id="prevBtn">Previous</button>
          <button type="button" class="btn btn-next" id="nextBtn">Next Question&nbsp;&nbsp;<i class="fa-solid fa-chevron-right"></i></button>
        </div>
      </div>
    </div>
<%  } // end for
   } // end else %>

    <div class="dots" id="dots"></div>
  </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
document.addEventListener('DOMContentLoaded', () => {
  const screens  = Array.from(document.querySelectorAll('.q-screen'));
  const total    = screens.length;
  let current    = 0;

  const bar      = document.getElementById('progressBar');
  const dotsWrap = document.getElementById('dots');

  // Build dots
  for (let i=0;i<total;i++){
    const d=document.createElement('div');
    d.className='dot'+(i===0?' active':'');
    d.dataset.index = i;
    dotsWrap.appendChild(d);
  }
  const dots = Array.from(dotsWrap.children);

  function setStepPct(text){
    document.querySelectorAll('#stepPct, [data-step-pct]').forEach(el => el.textContent = text);
  }

  // Progress uses ANSWERED count
  function isAnswered(screenEl){
    if (!screenEl) return false;
    if (screenEl.querySelector('input[type="radio"]:checked')) return true;
    const hidden = screenEl.querySelector('input[type="hidden"][name^="q_"]');
    if (hidden && parseInt(hidden.value || '0', 10) > 0) return true;
    return false;
  }
  function answeredCount(){
    return screens.reduce((n, sc)=> n + (isAnswered(sc) ? 1 : 0), 0);
  }
  function updateProgress(){
    const completed = answeredCount();
    const percent = Math.round((completed / Math.max(total,1)) * 100);
    setStepPct(`${percent}% completed`);
    if (bar) bar.style.width = percent + '%';

    const nextBtn = screens[current]?.querySelector('#nextBtn');
    if (nextBtn && nextBtn.type === 'button'){
      nextBtn.disabled = !isAnswered(screens[current]);
    }
  }

  function bindNavHandlers(){
    const prev = screens[current].querySelector('#prevBtn');
    const next = screens[current].querySelector('#nextBtn');
    if (prev) prev.onclick = ()=> show(current-1);
    if (next && next.type==='button') next.onclick = ()=> show(current+1);
  }

  function show(idx){
    if (total === 0) return;
    current = Math.max(0, Math.min(idx, total-1));

    screens.forEach((el,i)=> el.classList.toggle('active', i===current));
    dots.forEach((d,i)=> d.classList.toggle('active', i===current));

    const prevBtn = screens[current].querySelector('#prevBtn');
    if (prevBtn) prevBtn.disabled = (current===0);

    const nextBtn = screens[current].querySelector('#nextBtn');
    if (current === total-1){
      if (!nextBtn || nextBtn.type !== 'submit'){
        const html = `<button type="submit" class="btn btn-next" id="nextBtn">Submit Feedback</button>`;
        if (nextBtn) nextBtn.outerHTML = html;
        else screens[current].querySelector('.q-foot').insertAdjacentHTML('beforeend', html);
      }
    } else {
      if (!nextBtn || nextBtn.type !== 'button'){
        const html = `<button type="button" class="btn btn-next" id="nextBtn">Next Question&nbsp;&nbsp;<i class="fa-solid fa-chevron-right"></i></button>`;
        if (nextBtn) nextBtn.outerHTML = html;
        else screens[current].querySelector('.q-foot').insertAdjacentHTML('beforeend', html);
      }
    }
    bindNavHandlers();
    updateProgress();
  }

  document.addEventListener('change', (e)=>{
    if (e.target && e.target.matches('input[type="radio"]')){
      setTimeout(updateProgress, 0);
    }
  });
  document.addEventListener('click', (e)=>{
    const star = e.target.closest('.star-rating .star');
    if (!star) return;
    const container = star.closest('.star-rating');
    const qName   = container.getAttribute('data-question');
    const hidden  = document.getElementById(qName + '_value');
    const stars   = container.querySelectorAll('.star');
    const rateLbl = document.getElementById('rate_' + qName.split('_')[1]);

    const val = parseInt(star.dataset.value, 10) || 0;
    if (hidden) hidden.value = val;
    stars.forEach((s,i)=> s.classList.toggle('filled', i < val));
    if (rateLbl) rateLbl.textContent = val || 0;

    setTimeout(updateProgress, 0);
  });

  dotsWrap.addEventListener('click', (e)=>{
    const d = e.target.closest('.dot');
    if (!d) return;
    show(parseInt(d.dataset.index, 10) || 0);
  });

  show(0);
  updateProgress();
});
</script>
</body>
</html>
