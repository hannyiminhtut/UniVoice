<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.univoice.models.FeedbackSession" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.*" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Feedback Sessions</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>

  <style>
    :root{
      --bg:#f0fdf7;                 /* light green */
      --card:#ffffff;
      --ink:#0f172a;
      --muted:#64748b;
      --brand:#10b981;              /* emerald */
      --brand-2:#06b6d4;            /* teal */
      --brand-deep:#0e9f75;         /* darker emerald */
      --shadow:0 12px 28px rgba(2,6,23,.08);
      --ring: rgba(6,182,212,.22);  /* teal glow */
      --border:#e5e7eb;
    }

    html,body{ background:var(--bg); color:var(--ink); font-family: system-ui,-apple-system,"Segoe UI",Roboto,Arial,sans-serif; }

    /* Header box */
    .page-hero{
      background: linear-gradient(135deg,#ecfdf5 0%, #e6fffb 100%); /* mint → aqua */
      border: 1px solid #d1fae5;
      border-radius: 16px;
      box-shadow: var(--shadow);
      padding: 22px 24px;
    }
    .page-hero h2{
      margin:0; font-weight: 800; letter-spacing:.2px;
      color:#065f46; /* deep emerald */
      font-size: clamp(1.2rem, 2.4vw, 1.6rem);
    }
    .page-hero .subtext{
      color:#0f766e;                /* teal text */
      font-size:.95rem;
      font-weight:600;
      margin-top: 4px;
    }
    .icon-circle{
      width:44px; height:44px; border-radius:50%;
      background: linear-gradient(135deg,var(--brand),var(--brand-2));
      color:#fff; display:flex; align-items:center; justify-content:center;
      font-size:1.25rem;
      box-shadow:0 4px 12px var(--ring);
    }

    /* Card grid */
    .sessions-grid{ margin-top: 18px; }
    .session-card{
      background: var(--card);
      border: 1px solid var(--border);
      border-radius: 16px;
      box-shadow: var(--shadow);
      padding: 16px 16px;
      height: 100%;
      transition: transform .15s ease, box-shadow .15s ease, border-color .15s ease, background .15s ease;
    }
    .session-card:hover{
      transform: translateY(-2px);
      box-shadow: 0 16px 32px rgba(2,6,23,.12);
      border-color:#a7f3d0;            /* mint border on hover */
      background:#f7fffd;              /* ultra light mint */
    }

    .sess-title{
      font-weight: 800;
      font-size: 1.05rem;
      margin: 0 0 6px 0;
      word-break: break-word;
      color:#064e3b;                    /* darker emerald */
    }
    .deadline{
      display: inline-flex;
      align-items: center;
      gap: .5rem;
      color: var(--muted);
      font-weight: 600;
      font-size: .92rem;
    }
    .deadline i{ color:#10b981; }       /* emerald icon */

    /* CTAs */
    .btn-start{
      background: linear-gradient(135deg, var(--brand), var(--brand-2));
      border:0;
      color:#fff;
      font-weight: 800;
      letter-spacing:.2px;
      border-radius: 12px;
      padding: .6rem .95rem;
      width: 100%;
      box-shadow: 0 10px 22px var(--ring);
      transition: transform .12s ease, box-shadow .12s ease, filter .12s ease;
    }
    .btn-start:hover{
      transform: translateY(-1px);
      filter: brightness(.98);
      box-shadow: 0 14px 26px var(--ring);
      color:#fff;
    }
    .btn-ghost{
      width:100%;
      border-radius:12px;
      font-weight:800;
      padding:.58rem .95rem;
      border:2px solid #a7f3d0;        /* mint outline */
      color:#047857;                    /* emerald text */
      background:#ecfdf5;
      cursor:not-allowed;
    }

    /* Subtle disabled tint */
    .is-disabled{ opacity:.92; }

    /* Make bootstrap’s outline buttons within ghost area look greenish, even if old classes remain */
    .session-card .btn-outline-secondary.btn-ghost,
    .session-card .btn-outline-danger.btn-ghost{
      border-color:#a7f3d0 !important;
      color:#047857 !important;
      background:#ecfdf5 !important;
    }
  </style>
</head>
<body>

<div class="container py-4">

  <!-- Header box -->
  <div class="page-hero d-flex align-items-center gap-3">
    <div class="icon-circle">
      <i class="fa-solid fa-clipboard-list"></i>
    </div>
    <div>
      <h2>Available Feedback Sessions</h2>
      <p class="subtext mb-0">Choose a session below and share your feedback</p>
    </div>
  </div>

  <!-- Cards -->
  <div class="sessions-grid">
    <div class="row g-3">
      <%
        @SuppressWarnings("unchecked")
        List<FeedbackSession> sessions = (List<FeedbackSession>) request.getAttribute("sessions");

        ZoneId zone = ZoneId.of("Asia/Yangon");     // UTC+06:30
        LocalDateTime now = LocalDateTime.now(zone);
        LocalDate today = now.toLocalDate();

        DateTimeFormatter dateFmt = DateTimeFormatter.ofPattern("MMM dd, yyyy");

        int rendered = 0;

        if (sessions != null && !sessions.isEmpty()) {
          for (FeedbackSession s : sessions) {

            // Parse deadline flexibly
            LocalDate deadlineDate = null;
            try {
              Object raw = s.getDeadline_date();
              if (raw instanceof LocalDate) {
                deadlineDate = (LocalDate) raw;
              } else if (raw instanceof java.util.Date) {
                deadlineDate = ((java.util.Date) raw).toInstant().atZone(zone).toLocalDate();
              } else if (raw instanceof String) {
                deadlineDate = LocalDate.parse((String) raw);
              }
            } catch (Exception ignore) {}

            if (deadlineDate == null) { continue; }

            // Noon cutoff on deadline day
            LocalDateTime cutoff = deadlineDate.atTime(12, 0);

            boolean isExpired      = now.isAfter(cutoff);
            boolean isPublished    = s.isPublished();
            boolean isActive       = isPublished && !isExpired;
            boolean isUnpublished  = !isPublished && !isExpired;

            rendered++;
      %>
      <div class="col-12 col-md-6 col-lg-4 d-flex">
        <div class="session-card w-100 <%= (isActive ? "" : "is-disabled") %> d-flex flex-column">
          <!-- Title -->
          <h5 class="sess-title"><%= s.getTitle() %></h5>

          <!-- Deadline only -->
          <div class="deadline mb-3">
            <i class="fa-solid fa-calendar-day"></i>
            <%
              if (deadlineDate.isEqual(today) && !isExpired) {
            %>
              <span>Closes today at 12:00</span>
            <%
              } else {
            %>
              <span>Deadline: <%= deadlineDate.format(dateFmt) %> (12:00)</span>
            <%
              }
            %>
          </div>

          <!-- CTA -->
          <div class="mt-auto">
            <%
              if (isActive) {
            %>
              <a href="feedback/<%= s.getId() %>" class="btn btn-start">Start Feedback</a>
            <%
              } else if (isUnpublished) {
            %>
              <button class="btn btn-outline-secondary btn-ghost" disabled>Not Published</button>
            <%
              } else {
            %>
              <button class="btn btn-outline-danger btn-ghost" disabled>Expired</button>
            <%
              }
            %>
          </div>
        </div>
      </div>
      <%
          } // end for
        } // end if

        if (sessions == null || sessions.isEmpty() || rendered == 0) {
      %>
        <div class="col-12">
          <div class="alert alert-light border text-secondary">
            No feedback sessions available right now. Please check back later.
          </div>
        </div>
      <%
        }
      %>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
</body>
</html>
