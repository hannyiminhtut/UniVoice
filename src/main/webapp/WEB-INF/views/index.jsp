<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UniVoice</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="./assets/css/style.css" rel="stylesheet" />
<link href="./assets/imgs/univoice.jpg" rel="icon" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

</head>

<body>
<!-- Navbar -->
<div class="container-fluid nav-custom">
    <nav class="navbar navbar-expand-lg navbar-light bg-white py-3">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold text-primary" href="#">
                UniVoice
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                    <li class="nav-item ms-3"><a class="nav-link text-dark fw-semibold" href="#">Home</a></li>
                    <li class="nav-item ms-3"><a class="nav-link text-dark fw-semibold" href="/about">About</a></li>
                    <li class="nav-item ms-3"><a class="nav-link text-dark fw-semibold" href="/contact">Contact</a></li>
                    <li class="nav-item ms-3">
                        <a href="/login" class="btn login-btn">Login</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</div>


<!-- Top section with gradient background -->
<div class="top-section">

<!-- Hero Section -->
<section class="hero-section py-5">
    <div class="container text-center">
        <h1 class="display-5 intro">Empower Every Student's Voice</h1>
        <p class="lead mb-4">Report issues instantly and get them resolved faster.<br> 
        UniVoice connects students with the right teams to make campus life better.</p>
        <a href="/user/" class="btn btn-primary btn-lg started">Get Started</a>
    </div>
</section>
</div>

<!-- Feature Cards -->
<section class="container my-5">
  <!-- Section title -->
  <div class="text-center mb-5">
    <h2 class="fw-bold">What We Do</h2>
  </div>

  <div class="row text-center align-items-stretch">
    <div class="col-md-3 mb-4 d-flex">
      <div class="feature-card p-4 text-center">
      
        <img src="./assets/imgs/feedback.png" height="60" class="mb-3" alt="Feedback">
        <h5>Submit Feedback</h5>
        <p>Let your department know what’s working and what’s not.</p>
      </div>
    </div>

    <div class="col-md-3 mb-4 d-flex">
      <div class="feature-card p-4 text-center">
      
        <img src="./assets/imgs/issue.png" class="img-fluid mb-3" alt="Issue">
        <h5>Report Issues</h5>
        <p>Raise concerns directly to the right people—quickly and easily.</p>
      </div>
    </div>

    <div class="col-md-3 mb-4 d-flex">
      <div class="feature-card p-4 text-center">
      
        <img src="./assets/imgs/access.png" class="img-fluid mb-3" alt="Access">
        <h5>Role-Based Access</h5>
        <p>Students report issues, staff respond to their department's concerns, and administrators manage the entire workflow seamlessly.</p>
      </div>
    </div>

    <div class="col-md-3 mb-4 d-flex">
      <div class="feature-card p-4 text-center">
      
        <img src="./assets/imgs/status.png" class="img-fluid mb-3" alt="Status">
        <h5>Track Progress</h5>
        <p>Get real-time updates on your submitted feedback or complaints.</p>
      </div>
    </div>
  </div> <!-- /row -->
</section> <!-- /container -->


<!-- Why Use This Platform Section -->
<section class="why-use-section py-5">
  <div class="container">
    <div class="row align-items-center">
      
      <!-- Left Image -->
      <div class="col-md-6 text-center">
        <img src="./assets/imgs/whyuse.jpg" alt="Why Use This Platform" class="img-fluid rounded">
      </div>
      
      <!-- Right Text -->
      <div class="col-md-6">
        <h2 class="fw-bold mb-4 custom-heading">Why Use This Platform?</h2>
        
        <ul class="list-unstyled why-list">
          <li><strong>✓ Faster response times to issues</strong> – Reports are sent instantly to the right department, allowing problems to be addressed more quickly than with manual reporting.</li>
          <li><strong>✓ Transparent tracking of complaint status</strong> – Students can monitor the progress of their requests in real time, building trust and accountability.</li>
          <li><strong>✓ Easy access from anywhere</strong> – The platform works on any device, enabling reports and updates on or off campus.</li>
          <li><strong>✓ Connects directly with responsible departments</strong> – Issues are assigned straight to the team that can solve them, reducing delays and miscommunication.</li>
          <li><strong>✓ Encourages a cleaner, safer, more efficient campus</strong> – Quick reporting of problems promotes a well-maintained and safe environment for everyone.</li>
        </ul>
      </div>

    </div>
  </div>
</section>


<!-- Departments You Can Contact -->
<section class="departments-section py-5">
  <div class="container">
    <h2 class="fw-bold text-center mb-2 departments-heading">Departments You Can Contact</h2>
<p class="text-center mb-4 departments-subheading">Our campus connects you with the right departments to handle your needs efficiently. Whether you have questions, need assistance, or want to access services, you’ll find the right team here—making communication quick, clear, and hassle-free.</p>
    
    <div class="row g-4">
      <!-- 1 -->
     <div class="col-12 col-sm-6 col-md-4">
  <div class="dept-card h-100 p-3" 
       role="button" 
       tabindex="0" 
       data-bs-toggle="modal" 
       data-bs-target="#deptMaintenanceModal" 
       style="cursor:pointer;">
       
    <img src="./assets/imgs/maintenance.png" alt="Maintenance" class="dept-icon">
    <div class="dept-text">
      <p class="dept-name fw-bold">Maintenance</p>
      <p class="dept-desc">
        Handles air conditioning, electrical, plumbing, broken windows, and lighting repairs.
      </p>
    </div>
    
  </div>
</div>
     
     
      <!-- 2 -->
      <div class="col-12 col-sm-6 col-md-4">
  <div class="dept-card h-100 p-3" 
       role="button" 
       tabindex="0" 
       data-bs-toggle="modal" 
       data-bs-target="#deptITModal" 
       style="cursor:pointer;">
       
    <img src="./assets/imgs/itsupport.png" alt="IT" class="dept-icon">
    <div class="dept-text">
      <p class="dept-name fw-bold">IT Support</p>
      <p class="dept-desc">
        Manages internet issues, projectors, classroom tech, and computer labs.
      </p>
    </div>
    
  </div>
</div>
      
      
      <!-- 3 -->
      <div class="col-12 col-sm-6 col-md-4">
        <div class="dept-card h-100 p-3" 
       role="button" 
       tabindex="0" 
       data-bs-toggle="modal" 
       data-bs-target="#deptSecurityModal" 
       style="cursor:pointer;">
       
          <img src="./assets/imgs/security.png" alt="Security" class="dept-icon">
          <div class="dept-text">
          <p class="dept-name">Security</p>
          <p class="dept-desc">Handles stolen items, broken locks, unauthorized access, and lost & found.</p>
        </div>
      </div></div>
      <!-- 4 -->
      <div class="col-12 col-sm-6 col-md-4">
      
        <div class="dept-card h-100 p-3" 
       role="button" 
       tabindex="0" 
       data-bs-toggle="modal" 
       data-bs-target="#deptLibraryModal" 
       style="cursor:pointer;">
          <img src="./assets/imgs/library.png" alt="Library" class="dept-icon">
          <div class="dept-text">
          <p class="dept-name">Library Service</p>
          <p class="dept-desc">Deals with damaged furniture, book availability, and power issues in libraries.</p>
        </div>
      </div></div>
      <!-- 5 -->
      <div class="col-12 col-sm-6 col-md-4">
        <div class="dept-card h-100 p-3" 
       role="button" 
       tabindex="0" 
       data-bs-toggle="modal" 
       data-bs-target="#deptOfficeModal" 
       style="cursor:pointer;">
       
          <img src="./assets/imgs/office.png" alt="Office" class="dept-icon">
          <div class="dept-text">
          <p class="dept-name">Admin Office</p>
          <p class="dept-desc">Handles student complaints, ID card issues, and official document requests.</p>
        </div></div>
      </div>
    </div>
  </div>
</section>


<!-- Modal 1: Maintenance -->
<div class="modal fade" id="deptMaintenanceModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-xl modal-dialog-centered">
  
    <div class="modal-content">
      
      <!-- Modal Header -->
      <div class="modal-header">
        <h5 class="modal-title fw-bold">Maintenance</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

      <!-- Modal Body -->
      <div class="modal-body d-flex align-items-start">
        <!-- Icon on Left -->
        <img src="./assets/imgs/uni1.jpg" alt="Maintenance Icon" 
             class="me-3">

        <!-- Text on Right -->
        <div>
          <p>Responsible for the upkeep and smooth functioning of campus facilities. This includes:</p>
          <ul>
            <li><strong>Air Conditioning &amp; Ventilation</strong> – Ensuring all rooms and halls are well-ventilated and air-conditioned for comfort.</li>
            <li><strong>Electrical Systems</strong> – Fixing power outages, faulty wiring, and other electrical issues.</li>
            <li><strong>Plumbing</strong> – Repairing water leaks, blocked drains, and ensuring proper water supply.</li>
            <li><strong>Structural Repairs</strong> – Handling broken windows, damaged walls, and other building maintenance needs.</li>
            <li><strong>Lighting</strong> – Replacing burnt-out bulbs, fixing flickering lights, and maintaining outdoor lighting for safety.</li>
          </ul>
        </div>
      </div>

    </div>
  </div>
</div>


<!-- Modal 2: IT Support -->
<div class="modal fade" id="deptITModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-xl modal-dialog-centered">
  
    <div class="modal-content">
      
      <!-- Modal Header -->
      <div class="modal-header">
        <h5 class="modal-title fw-bold">IT Support</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

      <!-- Modal Body -->
      <div class="modal-body d-flex align-items-start">
        <!-- Icon on Left -->
        <img src="./assets/imgs/uni2.jpg" alt="Maintenance Icon" 
             class="me-3";">

        <!-- Text on Right -->
        <div>
          <p>Dedicated to keeping campus technology running efficiently. This includes:</p>
          <ul>
            <li><strong>Internet Connectivity</strong> – Troubleshooting Wi-Fi issues and ensuring reliable internet access in all areas.</li>
            <li><strong>Classroom Technology</strong> – Maintaining projectors, smart boards, and other teaching tools.</li>
            <li><strong>Computer Labs</strong> – Managing software installation, hardware maintenance, and performance upgrades.</li>
            <li><strong>Technical Assistance</strong> – Helping staff and students resolve tech-related problems quickly and effectively.</li>
          </ul>
        </div>
      </div>
</div>
  </div>
</div>

<!-- Modal 3: Security -->
<div class="modal fade" id="deptSecurityModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-xl modal-dialog-centered">
  
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title fw-bold">Security</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body d-flex align-items-start">
        <img src="./assets/imgs/uni4.jpg"class="me-3">
        <div>
          <p>Ensures the safety and protection of people and property on campus. This includes:</p>
          <ul>
            <li><strong>Lost &amp; Found</strong> – Safekeeping and returning lost items to their rightful owners.</li>
            <li><strong>Theft &amp; Unauthorized Access</strong> – Investigating stolen items and preventing unauthorized entry to restricted areas.</li>
            <li><strong>Safety Patrols</strong> – Regularly monitoring campus to deter suspicious activity.</li>
            <li><strong>Lock &amp; Access Control</strong> – Repairing broken locks and maintaining secure access systems.</li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Modal 4: Library Services -->
<div class="modal fade" id="deptLibraryModal" tabindex="-1" aria-hidden="true">
 <div class="modal-dialog modal-xl modal-dialog-centered">
 
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title fw-bold">Library Services</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body d-flex align-items-start">
        <img src="./assets/imgs/uni6.jpg" class="me-3">
        <div>
          <p>Supports academic success by maintaining a comfortable and resourceful library environment. This includes:</p>
          <ul>
            <li><strong>Book Availability</strong> – Managing borrowing, returns, and ensuring books are stocked and accessible.</li>
            <li><strong>Study Environment</strong> – Repairing damaged furniture and maintaining a quiet, clean study space.</li>
            <li><strong>Technical Support in Libraries</strong> – Addressing power issues, computer malfunctions, and printing problems.</li>
            <li><strong>Resource Assistance</strong> – Helping students and staff locate research materials and references.</li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Modal 5: Admin Office -->
<div class="modal fade" id="deptOfficeModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-xl modal-dialog-centered">
  
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title fw-bold">Admin Office</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body d-flex align-items-start">
        <img src="./assets/imgs/uni3.jpg" class="me-3">
        <div>
          <p>Acts as the central point for official student and staff services. This includes:</p>
          <ul>
            <li><strong>Student Complaints</strong> – Receiving and addressing concerns related to campus facilities, services, or academic matters.</li>
            <li><strong>ID Card Services</strong> – Issuing new or replacement ID cards and updating personal details.</li>
            <li><strong>Document Requests</strong> – Processing transcripts, enrollment verification, and other official paperwork.</li>
            <li><strong>General Inquiries</strong> – Providing guidance on policies, procedures, and campus resources.</li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</div>


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
        <h5 class="fw-bold">Office Hours</h5>
        <p>Monday - Friday: 8:00 AM - 6:00 PM</p>
        <p>Saturday: 9:00 AM - 2:00 PM</p>
        <p>Sunday: Closed</p>
      </div>
    </div>

    <hr class="mt-4 mb-3" style="border-color: rgba(255,255,255,0.3);">

    <!-- Footer Bottom -->
    <div class="text-center">
      <p class="mb-0">© 2025 UniReport. All rights reserved. | Making university life better, one report at a time.</p>
    </div>
  </div>
</footer>



<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" ></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
