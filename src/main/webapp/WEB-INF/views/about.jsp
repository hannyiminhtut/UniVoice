<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>About • UniReport</title>

  <!-- Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome (icons) -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet"/>

  <style>
    :root{
      --ink:#0f172a;
      --muted:#64748b;
      --bg:#f5f7fb;
      --card:#fff;
      --brand:#2563eb;
      --brand-dark:#1e40af;
      --ring:rgba(37,99,235,.15);
      --shadow:0 12px 30px rgba(2,6,23,.08);
    }

    html,body{background:#f7f8fc;color:var(--ink);font-family:system-ui,-apple-system,"Segoe UI",Roboto,Arial,sans-serif}

	/* Navbar white background and spacing */
.navbar {
    background-color: #ffffff !important;
    border-bottom: 1px solid #eaeaea;
}

/* Navbar links */
.navbar .nav-link {
    color: #000000 !important;
    font-weight: 500;
}

.navbar .nav-link:hover {
    color: #0056b3 !important;
}

/* Login button style */
.login-btn {
    color: #0056b3;
    border: 2px solid #0056b3;
    background-color: transparent;
    padding: 6px 18px;
    border-radius: 30px;
    font-weight: 500;
    transition: all 0.3s ease;
    text-decoration: none;
}

.login-btn:hover {
    background-color: #0056b3;
    color: #ffffff !important;
}

	
    /* HERO */
    .hero{
      background: linear-gradient(135deg, #3b82f6, #1e40af);
      color:#fff;
      padding: clamp(64px, 10vw, 120px) 0;
      text-align:center;
    }
    .hero h1{
      font-weight:800;
      letter-spacing:.2px;
      font-size:clamp(2rem, 4vw, 3.25rem);
      margin-bottom:12px;
    }
    .hero p{
      font-size:clamp(1rem, 1.4vw, 1.125rem);
      opacity:.95;
      max-width:920px;
      margin:0 auto;
    }

    /* Section wrappers */
    .section{
      padding: clamp(48px, 7vw, 84px) 0;
    }
    .section-muted{
      background:#f4f6fb;
    }
    .section h2{
      font-weight:800;
      text-align:center;
      margin-bottom:10px;
      letter-spacing:.2px;
      font-size:clamp(1.6rem, 2.8vw, 2.25rem);
    }
    .section .lead{
      text-align:center;
      color:var(--muted);
      max-width:900px;
      margin:0 auto 28px auto;
      font-size:1.05rem;
    }

    /* Mission cards */
    .feature-card{
      background:var(--card);
      border:1px solid #e8ecf3;
      border-radius:18px;
      padding:28px 22px;
      box-shadow:var(--shadow);
      height:100%;
      transition:.2s ease;
    }
    .feature-card:hover{ transform: translateY(-4px); box-shadow:0 18px 36px rgba(2,6,23,.12) }
    .feature-icon{
      width:64px;height:64px;border-radius:18px;
      display:grid;place-items:center;
      color:#3b82f6;
      background:rgba(37,99,235,.10);
      margin:0 auto 14px auto;
      font-size:1.25rem;
    }
    .feature-card h5{ text-align:center; font-weight:800; margin-bottom:8px }
    .feature-card p{ text-align:center; color:var(--muted); margin:0 }

    /* Steps */
    .steps .step{
      display:flex;flex-direction:column;align-items:center;text-align:center;gap:10px;
      padding:10px 10px;
    }
    .steps .badge-round{
      width:64px;height:64px;border-radius:999px;
      display:grid;place-items:center;
      color:#fff;background:#3b82f6;
      font-weight:800;font-size:1.2rem;
      box-shadow:0 10px 24px rgba(59,130,246,.35);
      margin-bottom:6px;
    }
    .steps h6{ font-weight:800; font-size:1.05rem; margin:0 }
    .steps p{ color:var(--muted); max-width:360px; margin:0 auto }

    /* Why Choose list */
    .why-list .item{
      display:flex;gap:14px;align-items:flex-start;margin-bottom:22px;
    }
    .why-list .icon{
      width:36px;height:36px;border-radius:10px;display:grid;place-items:center;
      background:rgba(37,99,235,.1); color:#3b82f6;
    }
    .why-list h6{ margin:0; font-weight:800 }
    .why-list p{ margin:6px 0 0 0; color:var(--muted) }

    /* CTA */
    .cta{
      text-align:center;
      padding: clamp(56px, 9vw, 100px) 0;
      background:#f4f6fb;
    }
    .cta h2{ font-weight:900; margin-bottom:10px }
    .cta p{ color:var(--muted); max-width:900px; margin:0 auto 22px auto }
    .btn-pill{
      border-radius:999px; padding:12px 18px; font-weight:700; border:0;
      box-shadow:0 8px 18px var(--ring);
    }
    .btn-brand{ background:#3b82f6; color:#fff }
    .btn-brand:hover{ background:#2563eb; color:#fff }
    .btn-ghost{
      background:#fff; color:#1f2937; border:1px solid #e5e7eb; box-shadow:none;
    }
    .btn-ghost:hover{
      background:#f8fafc; color:#111827; border-color:#dbe2ea;
    }

    /* Utilities */
    .mx-auto{ margin-left:auto; margin-right:auto }
    
    /* === Footer gradient & text colors === */
.footer-section,
.site-footer {
  background: linear-gradient(to right, #0C2587, #10B6E8) !important;
  color: #ffffff;
  padding: 20px 0;
}

/* Headings & body text inside footer */
.footer-section h4, .footer-section h5, .footer-section p, .footer-section li,
.site-footer h4, .site-footer h5, .site-footer p, .site-footer li {
  color: #ffffff;
}

/* Links */
.footer-section a,
.site-footer a {
  color: rgba(255,255,255,0.9);
  text-decoration: none;
}
.footer-section a:hover,
.site-footer a:hover {
  color: #ffffff;
  text-decoration: underline;
}

/* Social pills */
.social-icons a {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 40px; height: 40px;
  border-radius: 50%;
  background: #2b5bd7;
  color: #fff;
  margin-right: 8px;
  font-size: 16px;
  box-shadow: 0 6px 18px rgba(0,0,0,.15);
  transition: all .3s ease;
}
.social-icons a:hover { background:#4a7ff3; transform: translateY(-3px); }

/* Divider line */
.footer-section hr, .site-footer hr,
.footer-section .footer-divider, .site-footer .footer-divider {
  border: 0;
  border-top: 1px solid rgba(255,255,255,.3);
  margin: 1.25rem 0;
}
  </style>
</head>
<body>
<!-- Navbar -->

<div class="container-fluid nav-custom p-0">
    <nav class="navbar navbar-expand-lg navbar-light bg-white py-3 w-100">
        <div class="container-fluid px-0">

            <a class="navbar-brand fw-bold text-primary d-flex align-items-center ms-3" href="#">
    <i class="fa-solid fa-microphone-lines me-2"></i> UniVoice
</a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                    <li class="nav-item ms-3"><a class="nav-link text-dark fw-semibold" href="<c:url value='/'/>">Home</a></li>
                    <li class="nav-item ms-3"><a class="nav-link text-dark fw-semibold" href="<c:url value='/about'/>">About</a></li>
                    <li class="nav-item ms-3"><a class="nav-link text-dark fw-semibold" href="<c:url value='/contact'/>">Contact</a></li>
                    <li class="nav-item ms-3">
                        <a href="/login" class="btn login-btn">Login</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</div>

  <!-- HERO -->
  <section class="hero">
    <div class="container">
      <h1>About UniVoice</h1>
      <p>Empowering students and universities to create better campus experiences through seamless issue reporting and resolution.</p>
    </div>
  </section>

  <!-- MISSION -->
  <section class="section section-muted">
    <div class="container">
      <h2>Our Mission</h2>
      <p class="lead">To bridge the communication gap between students and university administrators,<br class="d-none d-md-inline">
        creating a more responsive and efficient campus environment.</p>

      <div class="row g-4 pt-2">
        <div class="col-12 col-md-4">
          <div class="feature-card h-100">
            <div class="feature-icon"><i class="fa-regular fa-message"></i></div>
            <h5>Easy Reporting</h5>
            <p>Students can quickly report issues with our intuitive interface, ensuring problems are documented and tracked efficiently.</p>
          </div>
        </div>
        <div class="col-12 col-md-4">
          <div class="feature-card h-100">
            <div class="feature-icon"><i class="fa-solid fa-bolt"></i></div>
            <h5>Fast Resolution</h5>
            <p>Reports route directly to the right departments, dramatically reducing response times and improving outcomes.</p>
          </div>
        </div>
        <div class="col-12 col-md-4">
          <div class="feature-card h-100">
            <div class="feature-icon"><i class="fa-solid fa-arrow-trend-up"></i></div>
            <h5>Continuous Improvement</h5>
            <p>Analytics and feedback loops help universities spot patterns and implement systemic campus improvements.</p>
          </div>
        </div>
      </div>
    </div>
  </section>

    <!-- HOW IT WORKS -->
  <section class="section">
    <div class="container">
      <h2>How UniReport Works</h2>
      <p class="lead">A simple step-by-step process that transforms campus issue management</p>

      <div class="row justify-content-center pt-3">
        <div class="col-12 col-md-8">
          <ul class="list-unstyled">
            
            <!-- Step 1 -->
            <li class="d-flex align-items-start mb-5">
              <div class="me-3">
                <div class="step-circle">1</div>
              </div>
              <div>
                <h5 class="fw-bold mb-2">Report Issues</h5>
                <p class="text-muted mb-0">
                  Students identify and report campus issues through our user-friendly platform, 
                  with clear descriptions and locations.
                </p>
              </div>
            </li>

            <!-- Step 2 -->
            <li class="d-flex align-items-start mb-5">
              <div class="me-3">
                <div class="step-circle green">2</div>
              </div>
              <div>
                <h5 class="fw-bold mb-2">Smart Routing</h5>
                <p class="text-muted mb-0">
                  Our system automatically routes reports to the right department and personnel 
                  for quick attention.
                </p>
              </div>
            </li>

            <!-- Step 3 -->
            <li class="d-flex align-items-start">
              <div class="me-3">
                <div class="step-circle orange">3</div>
              </div>
              <div>
                <h5 class="fw-bold mb-2">Track &amp; Resolve</h5>
                <p class="text-muted mb-0">
                  Students receive real-time updates while admins manage and resolve issues 
                  with full transparency.
                </p>
              </div>
            </li>

          </ul>
        </div>
      </div>
    </div>
  </section>

  <style>
    /* Circle number style */
    .step-circle {
      width: 50px;
      height: 50px;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      font-weight: 700;
      font-size: 1.2rem;
      color: #fff;
      background: #3b82f6; /* default blue */
      box-shadow: 0 4px 10px rgba(0,0,0,0.15);
    }
    .step-circle.green {
      background: #10b981; /* green */
    }
    .step-circle.orange {
      background: #f59e0b; /* orange */
    }

    /* Make headers more prominent */
    .section h5 {
      font-size: 1.25rem;
    }
  </style>
  

    <!-- ROLES & RESPONSIBILITIES -->
  <section class="section section-muted">
    <div class="container">
      <h2>Roles &amp; Responsibilities</h2>
      <p class="lead">How different stakeholders collaborate to keep the platform effective</p>

      <div class="row g-4 pt-3">
        
        <!-- Students -->
        <div class="col-12 col-md-4">
          <div class="feature-card h-100 text-center">
            <div class="feature-icon" style="background:linear-gradient(135deg,#3b82f6,#2563eb); color:#fff;">
              <i class="fa-solid fa-user-graduate"></i>
            </div>
            <h5>Students</h5>
            <p>
              Students can submit complaints about facilities, services, or campus-related issues 
              and track progress in real time. They also join monthly feedback sessions to share 
              their experience and suggest improvements.
            </p>
          </div>
        </div>

        <!-- Admins -->
        <div class="col-12 col-md-4">
          <div class="feature-card h-100 text-center">
            <div class="feature-icon" style="background:linear-gradient(135deg,#f59e0b,#ef4444); color:#fff;">
              <i class="fa-solid fa-user-shield"></i>
            </div>
            <h5>Admins</h5>
            <p>
              Admins review issues, assign them to the right departments, and ensure timely resolution. 
              They monitor progress, maintain accountability, and organize feedback sessions to 
              evaluate and improve the system.
            </p>
          </div>
        </div>

        <!-- Departments -->
        <div class="col-12 col-md-4">
          <div class="feature-card h-100 text-center">
            <div class="feature-icon" style="background:linear-gradient(135deg,#10b981,#06b6d4); color:#fff;">
              <i class="fa-solid fa-building"></i>
            </div>
            <h5>Departments</h5>
            <p>
              Departments resolve issues assigned by admins and provide resolution notes for transparency. 
              Admins confirm the fixes before notifying students, ensuring proper communication 
              and accountability.
            </p>
          </div>
        </div>

      </div>
    </div>
  </section>
  

    <!-- CTA -->
  <section class="cta">
    <div class="container">
      <h2>Ready to Transform Your Campus?</h2>
      <p>Join universities already using UniReport to improve student satisfaction and streamline campus operations.</p>
      <div class="d-flex justify-content-center">
        <a href="#" class="btn btn-pill btn-brand">Get Started Today</a>
      </div>
    </div>
  </section>
  
  <!-- Footer -->
<footer class="footer-section text-white pt-5 pb-4">
  <div class="container">
    <div class="row">

      <!-- About -->
      <div class="col-md-3 col-sm-6 mb-4">
        <h5 class="fw-bold">UniVoice</h5>
        <p>Making university campuses better through efficient issue management and student feedback.</p>
        <div class="social-icons">
          <a href="#"><i class="fab fa-facebook-f"></i></a>
          <a href="#"><i class="fab fa-twitter"></i></a>
          <a href="#"><i class="fab fa-linkedin-in"></i></a>
          <a href="#"><i class="fab fa-instagram"></i></a>
        </div>
      </div>

      <!-- Contact Us -->
      <div class="col-md-3 col-sm-6 mb-4">
        <h5 class="fw-bold">Contact Us</h5>
        <p><i class="fas fa-envelope"></i> support@unireport.edu</p>
        <p><i class="fas fa-phone"></i> +1 (555) 123-4567</p>
        <p><i class="fas fa-map-marker-alt"></i> University Campus, Main Building, Room 101</p>
      </div>

      <!-- Quick Links -->
      <div class="col-md-3 col-sm-6 mb-4">
        <h5 class="fw-bold">Quick Links</h5>
        <p><a href="#">About Us</a></p>
        <p><a href="#">Services</a></p>
        <p><a href="#">Privacy Policy</a></p>
        <p><a href="#">Terms of Service</a></p>
      </div>

      <!-- Office Hours -->
      <div class="col-md-3 col-sm-6 mb-4">
        <h5 class="fw-bold">Operating Hours</h5>
        <p>Monday to Friday</p>
        <p>9:00 AM – 5:00 PM</p>
        <p>Closed on weekends and holidays</p>
      </div>
    </div>

    <hr class="mt-4 mb-3" style="border-color: rgba(255,255,255,0.3);">

    <!-- Footer Bottom -->
    <div class="text-center">
      <p class="mb-0">© 2025 UniReport. All rights reserved. | Making university life better, one report at a time.</p>
    </div>
  </div>
</footer>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

