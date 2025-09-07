<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Contact • UniVoice</title>

  <!-- Bootstrap & Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet"/>

  <style>
    :root{
      --ink:#0f172a;
      --muted:#64748b;
      --ring:rgba(37,99,235,.15);
      --shadow:0 18px 36px rgba(2,6,23,.08);
      --card:#fff;
    }
    html,body{background:#f7f8fc;color:var(--ink);font-family:system-ui,-apple-system,"Segoe UI",Roboto,Arial,sans-serif}

    /* Navbar */
    .navbar { background:#fff !important; border-bottom:1px solid #eaeaea }
    .navbar .nav-link { color:#000 !important; font-weight:500 }
    .navbar .nav-link:hover { color:#0056b3 !important }
    .login-btn{
      color:#0056b3; border:2px solid #0056b3; background:transparent;
      padding:6px 18px; border-radius:30px; font-weight:500; transition:.3s;
      text-decoration:none;
    }
    .login-btn:hover{ background:#0056b3; color:#fff !important }

    /* HERO */
    .hero{
      background: linear-gradient(135deg, #4f46e5, #0ea5e9);
      color:#fff; text-align:center;
      padding: clamp(56px, 10vw, 110px) 0;
    }
    .hero h1{ font-weight:900; font-size:clamp(2rem, 4vw, 3rem); letter-spacing:.2px; margin-bottom:10px }
    .hero p{ opacity:.95; font-size:clamp(1rem,1.3vw,1.1rem); max-width:900px; margin:0 auto }

    /* Card */
    .uv-card{
      background: var(--card);
      border: 1px solid #e8ecf3;
      border-radius: 16px;
      box-shadow: var(--shadow);
    }
    .uv-card .card-header{ background:transparent; border:0; padding:18px 20px 0 }
    .uv-card .card-body{ padding:20px }

    /* Right panel lines */
    .ci{ width:40px; height:40px; border-radius:10px; display:grid; place-items:center; background:#eef2ff; color:#4f46e5; margin-right:12px; flex:0 0 auto }
    .contact-line{ display:flex; align-items:flex-start; gap:12px }
    .contact-line h6{ margin:0 0 4px 0; font-weight:800 }
    .contact-line p{ margin:0; color:var(--muted) }

    /* Social chips */
    .social-chip{
      width:42px; height:42px; border-radius:10px; border:1px solid #e8ecf3;
      display:grid; place-items:center; background:#fff; color:#1f2937;
    }
    .social-chip:hover{ background:#f8fafc }

    /* FAQ */
    .faq-title{ text-align:center; margin-bottom:6px; font-weight:900; font-size:clamp(1.4rem, 2.6vw, 2rem) }
    .faq-lead{ text-align:center; color:var(--muted); max-width:900px; margin:0 auto 18px }
    .accordion .accordion-item{ border:1px solid #e8ecf3; border-radius:14px; overflow:hidden; box-shadow:0 10px 22px rgba(2,6,23,.06); margin-bottom:12px }
    .accordion-button{ padding:16px 18px; font-weight:700; background:#fff }
    .accordion-button:not(.collapsed){ background:#f8fafc; color:#111 }
    .accordion-body{ color:#4b5563 }

    /* Footer */
    .footer-section{ background: linear-gradient(to right, #0C2587, #10B6E8) !important; color:#fff; padding:20px 0 }
    .footer-section a{ color:rgba(255,255,255,.9); text-decoration:none }
    .footer-section a:hover{ color:#fff; text-decoration:underline }
    .social-icons a{
      display:inline-flex; align-items:center; justify-content:center;
      width:40px; height:40px; border-radius:50%; background:#2b5bd7; color:#fff;
      margin-right:8px; font-size:16px; box-shadow:0 6px 18px rgba(0,0,0,.15); transition:.3s;
    }
    .social-icons a:hover{ background:#4a7ff3; transform:translateY(-3px) }
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
            <li class="nav-item ms-3"><a href="/login" class="btn login-btn">Login</a></li>
          </ul>
        </div>
      </div>
    </nav>
  </div>

  <!-- HERO -->
  <section class="hero">
    <div class="container">
      <h1>Get in Touch</h1>
      <p>Have questions, feedback, or need support? We’re here to help you with all your university reporting needs.</p>
    </div>
  </section>

  <!-- SINGLE CONTACT CARD -->
  <section class="py-4 py-md-5">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-12 col-lg-8 col-xl-7">
          <div class="uv-card">
            <div class="card-header">
              <h5 class="fw-bold">Contact Information</h5>
              <p class="text-muted mb-0">If your reported issue is taking longer than expected to be resolved, or if you have other questions about our services, you can reach us directly through email or phone. Our team will be happy to assist you and provide updates as quickly as possible.</p>
            </div>
            <div class="card-body">
              <div class="mb-4 contact-line">
                <div class="ci"><i class="fa-regular fa-envelope"></i></div>
                <div>
                  <h6>Email</h6>
                  <p>missayemoethetaung@gmail.com</p>
                  <p class="text-muted">For urgent issues outside the system</p>
                </div>
              </div>
              <div class="mb-4 contact-line">
                <div class="ci"><i class="fa-solid fa-phone"></i></div>
                <div>
                  <h6>Phone Contact</h6>
                  <p>+959694902120, +959757461077</p>
                  <p class="text-muted">Technical support helpline</p>
                </div>
              </div>
              <div class="mb-4 contact-line">
                <div class="ci"><i class="fa-solid fa-location-dot"></i></div>
                <div>
                  <h6>Office Location</h6>
                  <p class="mb-0">UIT Campus</p>
                  <p class="mb-0">Parami Road</p>
                  
                </div>
              </div>
              <div class="mb-4 contact-line">
                <div class="ci"><i class="fa-regular fa-clock"></i></div>
                <div>
                  <h6>Operating Hours</h6>
                  <p class="mb-0">Monday to Friday</p>
                  <p class="mb-0">9:00 AM – 5:00 PM</p>
                  <p class="text-muted">Closed on weekends and holidays</p>
                </div>
              </div>

              <hr class="my-3">

              <h6 class="fw-bold mb-2">Follow Us</h6>
              <div class="d-flex gap-2">
                <a class="social-chip" href="#"><i class="fa-brands fa-facebook-f"></i></a>
                <a class="social-chip" href="#"><i class="fa-brands fa-twitter"></i></a>
                <a class="social-chip" href="#"><i class="fa-brands fa-instagram"></i></a>
              </div>
            </div>
          </div>
        </div> <!-- /col -->
      </div> <!-- /row -->
    </div>
  </section>

  <!-- FAQ -->
  <section class="py-2 py-md-4 pb-5">
    <div class="container">
      <h2 class="faq-title">Frequently Asked Questions</h2>
      <p class="faq-lead">Quick answers to common questions about our feedback and reporting system.</p>

      <div class="row justify-content-center">
        <div class="col-12 col-lg-10">
          <div class="accordion" id="faq">
            <div class="accordion-item">
              <h2 class="accordion-header" id="q1h">
                <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#q1">
                  How do I track my complaint or feedback?
                </button>
              </h2>
              <div id="q1" class="accordion-collapse collapse show" data-bs-parent="#faq">
                <div class="accordion-body">
                  Once you submit a report, you’ll receive a unique tracking ID via email. Use this ID to check your
                  submission status any time through our tracking portal.
                </div>
              </div>
            </div>

            <div class="accordion-item">
              <h2 class="accordion-header" id="q2h">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#q2">
                  How long does it take to get a response?
                </button>
              </h2>
              <div id="q2" class="accordion-collapse collapse" data-bs-parent="#faq">
                <div class="accordion-body">
                  Most reports receive an initial response within 1–2 business days. Resolution time depends on the type of issue.
                </div>
              </div>
            </div>

            <div class="accordion-item">
              <h2 class="accordion-header" id="q3h">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#q3">
                  Can I submit anonymous feedback?
                </button>
              </h2>
              <div id="q3" class="accordion-collapse collapse" data-bs-parent="#faq">
                <div class="accordion-body">
                  Yes, you can choose to submit certain feedback anonymously. However, providing contact information helps us follow up if needed.
                </div>
              </div>
            </div>

            <div class="accordion-item">
              <h2 class="accordion-header" id="q4h">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#q4">
                  What types of issues can I report?
                </button>
              </h2>
              <div id="q4" class="accordion-collapse collapse" data-bs-parent="#faq">
                <div class="accordion-body">
                  Facilities, IT, safety/security, library services, administrative requests, and more—if it affects your campus experience, let us know.
                </div>
              </div>
            </div>

            <div class="accordion-item">
              <h2 class="accordion-header" id="q5h">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#q5">
                  Is my information kept confidential?
                </button>
              </h2>
              <div id="q5" class="accordion-collapse collapse" data-bs-parent="#faq">
                <div class="accordion-body">
                  We take privacy seriously. Your information is handled according to university policy and applicable regulations.
                </div>
              </div>
            </div>

          </div> <!-- /accordion -->
        </div>
      </div>
    </div>
  </section>

  <!-- Footer -->
  <footer class="footer-section text-white pt-5 pb-4">
    <div class="container">
      <div class="row">
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
        <div class="col-md-3 col-sm-6 mb-4">
          <h5 class="fw-bold">Contact Us</h5>
          <p><i class="fas fa-envelope"></i> support@unireport.edu</p>
          <p><i class="fas fa-phone"></i> +1 (555) 123-4567</p>
          <p><i class="fas fa-map-marker-alt"></i> University Campus, Main Building, Room 101</p>
        </div>
        <div class="col-md-3 col-sm-6 mb-4">
          <h5 class="fw-bold">Quick Links</h5>
          <p><a href="#">About Us</a></p>
          <p><a href="#">Services</a></p>
          <p><a href="#">Privacy Policy</a></p>
          <p><a href="#">Terms of Service</a></p>
        </div>
        <div class="col-md-3 col-sm-6 mb-4">
          <h5 class="fw-bold">Operating Hours</h5>
          <p>Monday to Friday</p>
          <p>9:00 AM – 5:00 PM</p>
          <p>Closed on weekends and holidays</p>
        </div>
      </div>
      <hr class="mt-4 mb-3" style="border-color: rgba(255,255,255,0.3);">
      <div class="text-center">
        <p class="mb-0">© 2025 UniReport. All rights reserved. | Making university life better, one report at a time.</p>
      </div>
    </div>
  </footer>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
