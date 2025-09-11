<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.univoice.models.Student" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UniVoice</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css" referrerpolicy="no-referrer" />
<style>
    body {
    background-color: #e6f9f4; /* light green tone */
    font-family: 'Segoe UI', sans-serif;
}
    

    /* Sidebar */
    .sidebar {
        background: linear-gradient(135deg, #10b981, #06b6d4);
        color: white;
        min-height: 100vh;
        padding-top: 30px;
        border-radius: 10px;
        position: fixed;
        margin-left:10px;
    }
    .sidebar a {
        color: white;
        text-decoration: none;
        display: block;
        padding: 12px 20px;
        border-radius: 15px;
        transition: background 0.3s ease;
    }
    .sidebar a:hover {
        background-color: rgba(255, 255, 255, 0.15);
    }
    .sidebar .menu-icon {
        margin-right: 10px;
    }

    .main-content{
    	margin-left:240px;
    	max-width:175vh;
    }

    
    .custom-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 6px 15px rgba(0,0,0,0.12);
    }

    /* Profile */
    .profile-img {
        width: 50px;
        height: 50px;
        border-radius: 50%;
        object-fit: cover;
        border: 2px solid #6c63ff;
    }

    .fade-in {
        opacity: 0;
        transform: translateY(20px);
        animation: fadeInUp 0.6s ease forwards;
    }
    @keyframes fadeInUp { to { opacity:1; transform: translateY(0); } }

    /* ===== [NEW] Issue Status Cards ===== */
    
    
    .status-card {
        border-radius: 16px;
        background: #fff;
        padding: 24px 18px 16px 18px; 
        font-size: 0.85rem;  
        height: 220px;            /* same height for all 3 cards */
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        border: 1px solid rgba(0,0,0,0.06);
        margin-top: 12px; 
        box-shadow: 0 4px 10px rgba(0,0,0,0.06); /* subtle shadow, no color glow */
        transition: transform .2s ease, box-shadow .2s ease, border-color .2s ease, background-color .2s ease;
    }
    
    .status-card:hover {
  background: rgba(108, 99, 255, 0.08);  /* light purple tint (theme color) */
  transform: translateY(-6px);
  box-shadow: 0 10px 24px rgba(0,0,0,.12);
}

/* Optional: tiny pulse on the icon badge when hovering the card */
.status-card:hover .icon-badge {
  transform: scale(1.03);
  transition: transform .2s ease;
}
    .status-headline {
        display: flex;
        align-items: center;
        gap: 14px;
    }
    .icon-badge {
    width: 40px;
    height: 40px;
    border-radius: 10px;
    display: grid;
    place-items: center;
    color: #fff;
}
    
    .icon-pending  { background: linear-gradient(135deg, #ff8a39, #ff5f6d); }
    .icon-assigned { background: linear-gradient(135deg, #6a85ff, #6c63ff); }
    .icon-resolved { background: linear-gradient(135deg, #2ecc71, #1abc9c); }

    .status-title {
        margin: 0;
        font-weight: 700;
        font-size: 1.5rem;
        color: #222;
    }
    .status-text {
        color: #5c5f66;
        margin: 8px 0 0 0;
    }

   
.status-card .learn-btn i { margin-right: 6px; }

    /* Small helper for the purple section titles */
    .section-title {
        font-weight: 700;
        margin-bottom: 12px;
        transition: transform .15s ease, box-shadow .15s ease, background .2s ease, opacity .2s ease;
    }
    /* Learn More button */
.status-card .learn-btn {
    align-self: flex-start;
    border-radius: 999px;
    padding: 8px 12px;
    font-size: 0.75rem;
    font-weight: 600;
    border: 0;
    background: linear-gradient(135deg, #10b981, #06b6d4); /* greenish gradient */
    color: #fff;
    margin-top: 10px;
    line-height: 1.2;
}
.status-card .learn-btn i { margin-right: 6px; }

.status-card .learn-btn:hover,
.status-card .learn-btn:focus {
    background: linear-gradient(135deg, #0e9f75, #0597ad); /* darker gradient */
    box-shadow: 0 6px 14px rgba(6, 182, 212, .35), 0 0 8px rgba(16, 185, 129, .45); /* teal + green glow */
    transform: translateY(-1px);
    outline: none;
    color: #fff;
}

/* Got it button */
.btn-gotit {
  width: 100%;
  border-radius: 999px;
  padding: 12px 18px;
  font-weight: 700;
  border: 0;
  background: linear-gradient(135deg, #10b981, #06b6d4); /* greenish gradient */
  color: #fff;
}

.btn-gotit:hover {
  background: linear-gradient(135deg, #0e9f75, #0597ad); /* darker gradient */
  box-shadow: 0 6px 14px rgba(6, 182, 212, .35), 0 0 8px rgba(16, 185, 129, .45); /* teal + green glow */
  transform: translateY(-2px);
  color: #fff; /* keep text white */
}
    
    
    /* ===== Pretty modal like screenshot ===== */
.uv-modal .modal-content{
  border-radius: 16px;
  border: 0;
  padding: 20px 20px 8px 20px;   /* roomy inside */
  box-shadow: 0 10px 30px rgba(0,0,0,0.15);
}
.uv-modal .modal-header{
  border-bottom: 0;
  padding: 6px 6px 0 6px;
}
.uv-modal .modal-title{
  font-weight: 500;              /* bold black title */
  color: #111;
  font-size: 1.5rem;
}
.uv-modal .modal-body{
  color: #444;
  line-height: 1.6;
  padding: 8px 6px 0 6px;
}
.uv-modal .btn-close{
  background: #f0f2f5;
  border-radius: 999px;
  opacity: 1;
  width: 28px; height: 28px;
}

.text-center h3 {
  color: #222;
}
.text-center p {
  font-size: 0.95rem;
  margin-top: 4px;
}


/* already exists earlier */
.custom-card {
  border-radius: 15px;
  background: white;
  padding: 20px;
  box-shadow: 0 4px 10px rgba(0,0,0,0.08);
}

/* put this AFTER the above */
.custom-card.header-banner {
  background: linear-gradient(135deg, #10b981, #06b6d4) !important;
  color: #fff;
}


/* ensure text is readable on the gradient */
.custom-card.header-banner h5,
.custom-card.header-banner h4,
.custom-card.header-banner p {
  color: #fff;
}

/* optional: make the profile ring match */
.custom-card.header-banner .profile-img {
  border-color: #fff;
}




    
</style>
</head>
<body>
	<%
          com.univoice.models.Student student = (com.univoice.models.Student) session.getAttribute("student");
          String studentName = (student != null) ? student.getName() : "Guest";
      %>
	<div class="container-fluid">
    <div class="row">

        <!-- Sidebar -->
        <div class="col-md-2 sidebar">
            <div class="text-center mb-4">
                <i class="fa-solid fa-graduation-cap fa-2x"></i>
            </div>
            <a href="student-dashboard/createProfile/<%= student.getUser_id() %>"><i class="fa-solid fa-user menu-icon"></i> Profile</a>
            <a href="student-dashboard/submitIssues"><i class="fa-solid fa-pen menu-icon"></i> Submit Issues </a>
            <a href="student-dashboard/issueResult"><i class="fa-solid fa-chart-line menu-icon"></i> Issues Result</a>
            
          	<a href="student-dashboard/feedback" class="position-relative">
			    <i class="fa-solid fa-book menu-icon"></i> Feedback
			    <% if ((Boolean) request.getAttribute("hasPendingFeedback")) { %>
			        <span class="position-absolute top-2 start-100 translate-middle p-1 bg-danger border border-light rounded-circle"></span>
			    <% } %>
			</a>
          	
            <!--  <a href="https://mail.google.com/mail/u/0/#inbox"><i class="fa-solid fa-bullhorn menu-icon"></i> Contact Admin</a>-->
            <a href="student-dashboard/logout"><i class="fa-solid fa-right-from-bracket menu-icon"></i> Logout</a>
        </div>

        <!-- Main Content -->
        <div class="col-md-10 p-4 main-content">
        		
        	<div class="container-fluid">

         
            
			<%
			   String msg = (String) request.getAttribute("msg");
			   if (msg != null) {
			%>
			   <div class="alert alert-success alert-dismissible fade show mt-3" role="alert">
			       <%= msg %>
			       <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			   </div>
		  <% } %>
			
            <!-- Welcome Card (unchanged) -->
            <div class="custom-card header-banner mb-4 fade-in">
    <h5><%= java.time.LocalDate.now() %></h5>
    <h4>Welcome back, <%=studentName %></h4>
    <p>Always stay updated in your student dashboard</p>
</div>
            
            	<!-- Profile image (dynamic: student or default) -->
    <%
        String profileImg = (student != null && student.getImage() != null && !student.getImage().isEmpty()) 
                            ? student.getImage()
                            : "../assets/imgs/blank-profile.webp";
    %>
    <img src="<%= profileImg %>" 
         alt="Profile" 
         class="profile-img position-absolute" 
         style="top: 40px; right: 55px; border:2px solid #fff; width:45px; height:45px;" />
                
            </div>

            <!-- ===== Issue Status Cards (replaces Finance) ===== -->
<div class="text-center mb-4">
    <h3 class="fw-bold">Issue Status Overview</h3>
    <p class="text-muted">Track the progress of your submitted issues and feedback</p>
</div>
<div class="row g-3 mb-4 justify-content-center">
            

                <!-- Pending -->
                <div class="col-md-4 fade-in">
                    <div class="status-card h-100">
                        <div>
                            <div class="status-headline">
                                <div class="icon-badge icon-pending">
                                    <i class="fa-solid fa-clock fa-sm"></i>
                                </div>
                                <h5 class="status-title">Pending</h5>
                            </div>
                            <p class="status-text mt-3">Your issue has been received and is awaiting review.</p>
                        </div>
                        <button class="learn-btn" data-bs-toggle="modal" data-bs-target="#modalPending">
                            <i class="fa-solid fa-circle-info"></i> Learn more
                        </button>
                    </div>
                </div>

                <!-- Assigned -->
                <div class="col-md-4 fade-in" style="animation-delay:0.1s">
                    <div class="status-card h-100">
                        <div>
                            <div class="status-headline">
                                <div class="icon-badge icon-assigned">
                                    <i class="fa-solid fa-user-check fa-sm"></i>
                                </div>
                                <h5 class="status-title">Assigned</h5>
                            </div>
                            <p class="status-text mt-3">Your issue has been assigned to a department.</p>
                        </div>
                        <button class="learn-btn" data-bs-toggle="modal" data-bs-target="#modalAssigned">
                            <i class="fa-solid fa-circle-info"></i> Learn more
                        </button>
                    </div>
                </div>

                <!-- Resolved -->
                <div class="col-md-4 fade-in" style="animation-delay:0.2s">
                    <div class="status-card h-100">
                        <div>
                            <div class="status-headline">
                                <div class="icon-badge icon-resolved">
                                    <i class="fa-solid fa-circle-check fa-sm"></i>
                                </div>
                                <h5 class="status-title">Resolved</h5>
                            </div>
                            <p class="status-text mt-3">Your issue has been successfully resolved.</p>
                        </div>
                        <button class="learn-btn" data-bs-toggle="modal" data-bs-target="#modalResolved">
                            <i class="fa-solid fa-circle-info"></i> Learn more
                        </button>
                    </div>
                </div>
            </div>
            <!-- ===== End Issue Status ===== -->


        </div>
    </div>
</div>

<!-- ===== Modals for Learn More ===== -->

<!-- Modal: Pending -->
<div class="modal fade uv-modal" id="modalPending" tabindex="-1" aria-labelledby="modalPendingLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header align-items-start">
        <h5 class="modal-title" id="modalPendingLabel">Pending</h5>
        <!-- no X button -->
      </div>
      <div class="modal-body">
        When your issue is marked as <strong>Pending</strong>, it means we’ve successfully received your report and it’s waiting for the admin team to review before assigning it to the right department.
      </div>
      <div class="p-3 pt-4">
        <button type="button" class="btn-gotit" data-bs-dismiss="modal">Got it!</button>
      </div>
    </div>
  </div>
</div>

<!-- Modal: Assigned -->
<div class="modal fade uv-modal" id="modalAssigned" tabindex="-1" aria-labelledby="modalAssignedLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header align-items-start">
        <h5 class="modal-title" id="modalAssignedLabel">Assigned</h5>
        <!-- no X button -->
      </div>
      <div class="modal-body">
        <strong>Assigned</strong> means the admin has reviewed your report and forwarded it to the relevant department. They’re now working on a fix.
      </div>
      <div class="p-3 pt-4">
        <button type="button" class="btn-gotit" data-bs-dismiss="modal">Got it!</button>
      </div>
    </div>
  </div>
</div>

<!-- Modal: Resolved -->
<div class="modal fade uv-modal" id="modalResolved" tabindex="-1" aria-labelledby="modalResolvedLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header align-items-start">
        <h5 class="modal-title" id="modalResolvedLabel">Resolved</h5>
        <!-- no X button -->
      </div>
      <div class="modal-body">
        <strong>Resolved</strong> means the department has fixed the issue and the admin has verified the solution. You can view the resolution details on the issue result page.
      </div>
      <div class="p-3 pt-4">
        <button type="button" class="btn-gotit" data-bs-dismiss="modal">Got it!</button>
      </div>
    </div>
  </div>
</div>


<!-- ===== End Modals ===== -->

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- Animation Delay -->
<script>
    document.querySelectorAll('.fade-in').forEach((el, index) => {
        el.style.animationDelay = `${index * 0.1}s`;
    });
    
    setTimeout(() => {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(alert => alert.remove());
    }, 2000);
</script>
</body>
</html>
