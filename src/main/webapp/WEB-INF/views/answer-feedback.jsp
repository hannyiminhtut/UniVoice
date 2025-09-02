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

  <!-- Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>

  <style>
    :root { --bg:#f6f7fb; --card:#fff; --text:#1f2937; }
    html, body { background:var(--bg); color:var(--text); font-family: system-ui,-apple-system,"Segoe UI",Roboto,Arial,sans-serif; }

    .page-title { font-weight:800; letter-spacing:.2px; }

    .session-row {
      background: var(--card);
      border: 0;
      border-left: 6px solid #2563eb;
      border-radius: 14px;
      box-shadow: 0 8px 22px rgba(0,0,0,.06);
      transition: transform .15s ease, box-shadow .15s ease, border-color .15s ease;
      padding: 1.25rem 1.25rem;
    }
    .session-row:hover {
      transform: translateY(-2px);
      box-shadow: 0 12px 28px rgba(0,0,0,.10);
      border-color: #1d4ed8;
    }
    .session-row.disabled { opacity:.75; }

    .title {
      font-size: clamp(1rem, 1.6vw, 1.15rem);
      font-weight:700;
      margin-bottom:.25rem;
      word-break: break-word;
    }
    .meta { color:#6b7280; font-weight:600; }
    .cta-wrap { min-width: 210px; }
    .btn-wide { width: 100%; }
  </style>
</head>
<body>

<div class="container py-5">
  <h2 class="page-title mb-4">Available Feedback Sessions</h2>

  <div class="vstack gap-3">
    <%
      @SuppressWarnings("unchecked")
      List<FeedbackSession> sessions = (List<FeedbackSession>) request.getAttribute("sessions");

      // Use explicit Asia/Yangon timezone (UTC+06:30)
      ZoneId zone = ZoneId.of("Asia/Yangon");
      LocalDateTime now = LocalDateTime.now(zone);
      LocalDate today = now.toLocalDate();

      DateTimeFormatter dateFmt = DateTimeFormatter.ofPattern("MMM dd, yyyy");

      int rendered = 0;

      if (sessions != null && !sessions.isEmpty()) {
        for (FeedbackSession s : sessions) {

          // ---- Parse deadline into LocalDate (supports LocalDate, java.util.Date, or String ISO yyyy-MM-dd) ----
          LocalDate deadlineDate = null;
          try {
            Object raw = s.getDeadline_date(); // adjust if your getter differs
            if (raw instanceof LocalDate) {
              deadlineDate = (LocalDate) raw;
            } else if (raw instanceof java.util.Date) {
              deadlineDate = ((java.util.Date) raw).toInstant().atZone(zone).toLocalDate();
            } else if (raw instanceof String) {
              deadlineDate = LocalDate.parse((String) raw);
            }
          } catch (Exception ignore) {}

          // If no parsable deadline, skip this session safely
          if (deadlineDate == null) { continue; }

          // ---- Cutoff is 12:00 noon on the deadline date ----
          LocalDateTime cutoff = deadlineDate.atTime(12, 0);

          boolean isExpired      = now.isAfter(cutoff);             // after 12:00 on deadline day -> expired
          boolean isPublished    = s.isPublished();
          boolean isActive       = isPublished && !isExpired;
          boolean isUnpublished  = !isPublished && !isExpired;

          String cardState = isActive ? "" : "disabled";
          rendered++;
    %>

    <!-- Full-width row card -->
    <div class="session-row <%= cardState %> d-flex flex-column flex-lg-row align-items-start align-items-lg-center justify-content-between w-100">

      <!-- Left: title + meta -->
      <div class="me-lg-3">
        <div class="title"><%= s.getTitle() %></div>
        <div class="meta">
          <%
            if (deadlineDate.isEqual(today) && !isExpired) {
          %>
              Closes today at 12:00
          <%
            } else {
          %>
              Deadline: <%= deadlineDate.format(dateFmt) %> (12:00)
          <%
            }
          %>
        </div>
      </div>

      <!-- Right: primary action -->
      <div class="cta-wrap mt-3 mt-lg-0">
        <%
          if (isActive) {
        %>
            <a href="feedback/<%= s.getId() %>" class="btn btn-primary btn-wide">Start Feedback</a>
        <%
          } else if (isUnpublished) {
        %>
            <button class="btn btn-outline-secondary btn-wide" disabled
                    title="This session isn’t published yet.">Not Published</button>
        <%
          } else {
        %>
            <button class="btn btn-outline-danger btn-wide" disabled
                    title="This session is no longer accepting responses.">Expired</button>
        <%
          }
        %>
      </div>
    </div>

    <%
        } // end for
      } // end if sessions

      if (sessions == null || sessions.isEmpty() || rendered == 0) {
    %>
      <div class="alert alert-light border text-secondary m-0">
        No feedback sessions available right now. Please check back later.
      </div>
    <%
      }
    %>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
