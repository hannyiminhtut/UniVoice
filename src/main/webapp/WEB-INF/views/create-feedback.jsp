<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Create Feedback</title>

  <!-- Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">

  <!-- Flatpickr (calendar) -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">

  <style>
    :root{
      --navy:#000066;
      --blue:#3b82f6;
      --ink:#111827;
      --muted:#64748b;
      --card:#ffffff;
    }

    body {
      background:
        radial-gradient(1000px 500px at -10% -5%, #eef2ff 15%, transparent 55%),
        radial-gradient(900px 450px at 110% -5%, #f3f4ff 15%, transparent 55%),
        #f8fafc;
      min-height: 100vh;
      font-family: "Segoe UI", Roboto, system-ui, -apple-system, sans-serif;
    }

    /* ===== Card ===== */
    .feedback-card {
      background: var(--card);
      border: 1px solid #e5e7eb;
      border-radius: 18px;
      box-shadow: 0 8px 25px rgba(0, 0, 0, 0.18);   /* visible shadow */
      padding: 28px 30px;
      transition: transform 0.15s ease, box-shadow 0.15s ease;
    }
    .feedback-card:hover {
      transform: translateY(-3px);
      box-shadow: 0 14px 35px rgba(0, 0, 0, 0.25);
    }
    .feedback-card h4 {
      font-weight: 800;
      font-size: 1.4rem;
      color: var(--navy);
      margin-bottom: 6px;
    }
    .feedback-card .sub {
      font-size: 0.95rem;
      color: var(--muted);
      margin-bottom: 20px;
    }

    /* ===== Inputs ===== */
    .form-label { font-weight: 600; color: #374151; }

    .form-control {
      height: 46px;
      border-radius: 12px;
      border: 1px solid #d1d5db;
      transition: border 0.2s, box-shadow 0.2s;
    }
    .form-control:focus {
      border-color: var(--navy);
      box-shadow: 0 0 0 3px rgba(0, 0, 102, 0.25);
      outline: none;
    }

    /* ===== Button ===== */
    .btn-primary {
      background: linear-gradient(135deg, var(--navy), var(--blue));
      border: none;
      border-radius: 12px;
      padding: 12px;
      font-weight: 700;
      letter-spacing: .3px;
      box-shadow: 0 8px 18px rgba(0,0,102,.25);
      transition: transform .12s ease, box-shadow .12s ease;
    }
    .btn-primary:hover {
      transform: translateY(-1px);
      box-shadow: 0 12px 24px rgba(0,0,102,.3);
    }

    /* ===== Flatpickr overrides ===== */
    .flatpickr-calendar {
      border: 1px solid #e6e9ef;
      box-shadow: 0 20px 45px rgba(15,23,42,.18);
      border-radius: 16px;
      overflow: hidden;
      font-family: "Segoe UI", Roboto, sans-serif;
    }

    /* Month & year section (keep white background, dark text) */
    .flatpickr-months {
      background: #fff;
      color: var(--ink);
      font-weight: 700;
      padding: 6px 0;
      border-bottom: 1px solid #e5e7eb;
    }
    .flatpickr-current-month input.cur-year,
    .flatpickr-current-month .cur-month {
      color: var(--ink) !important;
      font-weight: 800;
    }

    /* Weekdays */
    .flatpickr-weekday {
      color: var(--navy);
      font-weight: 700;
    }

    /* Days */
    .flatpickr-day {
      border-radius: 10px;
    }
    .flatpickr-day:hover {
      background: #eef2ff;
      border-color: #eef2ff;
    }
    .flatpickr-day.today {
      box-shadow: inset 0 0 0 2px var(--blue);
      border-color: var(--blue);
    }
    .flatpickr-day.selected,
    .flatpickr-day.startRange,
    .flatpickr-day.endRange {
      background: var(--blue);
      border-color: var(--blue);
      color: #fff;
    }

    /* Footer buttons (Clear / Today) */
    .flatpickr-calendar .flatpickr-footer {
      border-top: 1px solid #e5e7eb;
      padding: 6px;
    }
    .flatpickr-calendar .flatpickr-clear,
    .flatpickr-calendar .flatpickr-today {
      color: var(--blue);
      font-weight: 600;
      cursor: pointer;
    }
    .flatpickr-calendar .flatpickr-clear:hover,
    .flatpickr-calendar .flatpickr-today:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>
  <div class="container py-5">
    <div class="col-lg-6 mx-auto">
      <div class="feedback-card">
        <h4>Create Feedback Session</h4>
        <div class="sub">Define a title and deadline for collecting responses.</div>

        <!-- Keep action & names the same -->
        <form action="/admin-dashboard/create-session" method="post">
          <div class="mb-3">
            <label class="form-label">Feedback Title</label>
            <input type="text" name="feedbackTitle" class="form-control" placeholder="Enter a session title..." required>
          </div>

          <div class="mb-3">
            <label class="form-label">Deadline Date</label>
            <!-- Use text for Flatpickr -->
            <input type="text" id="deadlineDate" name="deadlineDate" class="form-control" placeholder="Pick a date…" required>
          </div>

          <button class="btn btn-primary w-100">Create & Continue</button>
        </form>
      </div>
    </div>
  </div>

  <!-- JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
  <script>
    flatpickr("#deadlineDate", {
      dateFormat: "Y-m-d",       // submitted to backend
      altInput: true,
      altFormat: "F j, Y",       // human readable
      minDate: "today",
      allowInput: true
    });
  </script>
</body>
</html>
