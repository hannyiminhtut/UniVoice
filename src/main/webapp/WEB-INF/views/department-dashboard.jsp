<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.univoice.models.Issue" %>
<%@ page import="com.univoice.models.Department" %>

<html>
<head>
    <title>Univoice</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css"  crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
 	<link rel="stylesheet" href="../assets/css/dept-dash.css" />
</head>
<body>
<%	Department dept = (Department)request.getAttribute("department");
	String imagePath = dept.getImage();
	
%>
<!-- Top Navbar -->
<nav class="navbar navbar-expand-lg bg-white shadow-sm px-3">
    <div class="container-fluid d-flex justify-content-between align-items-center">
        
        <div class="fw-bold fs-5 text-dark">
           <a href="/department-dashboard" style="text-decoration:none;">Department Dashboard</a>
        </div>

        <!-- Right-side icons and profile -->
        <div class="d-flex align-items-center gap-3">
        
            <!-- Message icon -->
            <a href="" class="text-decoration-none position-relative">
                <i class="fa-solid fa-envelopes-bulk"></i>
            </a>
            
            <!-- Notification icon -->
			<a href="" class="text-decoration-none position-relative">
			    <i class="fa-solid fa-bell fs-5"></i>
			    <% 
			    	List<Issue> problems = (List<Issue>) request.getAttribute("issues");
			        long unreadCount = problems.stream().filter(i -> !i.getRead_dept()).count();
			        if (unreadCount > 0) { 
			    %>
			        <span id="bellDot" class="position-absolute top-0 start-100 translate-middle p-2 bg-danger border border-light rounded-circle">
			        	<%= unreadCount %>
			        </span>
			    <% } %>
			</a>
            
           <!-- Profile Dropdown -->
			<div class="dropdown">
			    <a href="#" class="d-flex align-items-center text-decoration-none dropdown-toggle" 
			       id="profileDropdown" data-bs-toggle="dropdown" aria-expanded="false">
			        <img src=" <%= imagePath != null ? imagePath : "../assets/imgs/blank-profile.webp" %> " 
			             class="rounded-circle me-2" width="35" height="33" style="object-fit: cover;">
			        <span class="fw-bold text-dark"><%= dept.getName() %></span>
			    </a>
			    <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="profileDropdown">
			        <li>
			            <a class="dropdown-item" href="/department-dashboard/profile">Profile</a>
			        </li>
			        <li>
			            <form action="department-dashboard/logout" method="get" class="m-0">
			                <button type="submit" class="dropdown-item text-danger">Logout</button>
			            </form>
			        </li>
			    </ul>
			</div>
           
        </div>
    </div>
</nav>

<div class="container mt-4">
    <h4 class="mb-4 text-center"> <i class="fa-solid fa-list-check me-2 text-primary"></i>Received Issues</h4>
    <div class="row g-4">
        <%
            List<Issue> issues = (List<Issue>) request.getAttribute("issues");
            if (issues != null && !issues.isEmpty()) {
                int index = 0;
                for (Issue issue : issues) {
                    String modalId = "issueModal" + index;
        %>
    <div class="col-md-4">
    		
		<% if (request.getAttribute("success") != null) { %>
  			<div class="alert alert-success" role="alert">
   				 <%= request.getAttribute("success") %>
  			</div>
		<% } %>

		<% if (request.getAttribute("fail") != null) { %>
		  <div class="alert alert-danger" role="alert">
		    <%= request.getAttribute("fail") %>
		  </div>
		<% } %>
		
	  <div class="issue-card position-relative"
	       onclick="openIssueModal('<%= modalId %>', <%= issue.getIssue_id() %>)">
	
	    <% if (!issue.getRead_dept()) { %>
	        <!-- 🔴 Unread red dot -->
	        <span id="dot-<%= issue.getIssue_id() %>" 
	              class="position-absolute top-1 end-0 translate-middle p-2 bg-danger border border-light rounded-circle"></span>
	    <% } else if (issue.getNote() != null) { %>
	        <!-- ✅ Green check icon if note exists & already read -->
	        <i class="fa-solid fa-circle-check text-success position-absolute top-0 end-0 fs-5 me-1 mt-1"></i>
	    <% } %>
	
	    <h5 class="issue-title">
	        <i class="fa-solid fa-bug text-danger me-2"></i> <%= issue.getTitle() %>
	    </h5>
	    <p class="issue-date mt-2">
	        <i class="fa-regular fa-calendar-days me-1"></i> <%= issue.getCreated_at() %>
	    </p>
	  </div>
	</div>
    
      	

        <!-- Modal for Issue Details -->
        <div class="modal fade" id="<%= modalId %>" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="issue-title">
                            <i class="fa-solid fa-bug text-danger me-2"></i> <%= issue.getTitle() %>
                        </h5>
                        
                    </div>
                    <div class="modal-body">
                        
                        <p><strong>Description:</strong> <%= issue.getDescription() %></p>
                        <p><strong>Location:</strong> <%= issue.getLocation() %></strong></p>
                        <p><strong>Date:</strong> <%= issue.getCreated_at() %></strong></p>
                        <hr>
                        
                        <% if (issue.getImg() != null && !issue.getImg().isEmpty()) { %>
            			<p><i class="fa-solid fa-image me-2"></i> <strong>Attached Image:</strong></p>
            			<img src="<%= issue.getImg()  %>" class="issue-img" alt="Issue Image" width="200px" height="250px">
            			<hr>
       					 <% } %>
       					 
                        <% if (issue.getNote() == null) {%>
                        <form action="department-dashboard/sendNote" method="post">
                            <input type="hidden" name="issueId" value="<%= issue.getIssue_id() %>">
                            <div class="mb-3">
                                <label class="form-label">Solution Note</label>
                                <textarea class="form-control" name="note" rows="3" placeholder="Enter solution..." required></textarea>
                            </div>
                            <button type="submit" class="btn btn-solve">Send solution </button>
                        </form>
                        <% } else { %>
                        	<i class="fa-solid fa-circle-check me-1"></i> We’ve already sent the resolution note
                        <% } %>
                    </div>
                </div>
            </div>
        </div>

        <%
                    index++;
                }
            } else {
        %>
        <div class="alert alert-info text-center">No issues found for this department.</div>
        <%
            }
        %>
    </div>
</div>
<script>
function openIssueModal(modalId, issueId) {
    let modalEl = document.getElementById(modalId);
    let modal = new bootstrap.Modal(modalEl);
    modal.show();

    // Ajax call to mark issue as read
    fetch('department-dashboard/markAsRead', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: 'issueId=' + issueId
    }).then(res => res.text())
      .then(data => {
          if (data === "OK") {
              // Remove red dot from issue card
              let dot = document.getElementById('dot-' + issueId);
              if (dot) dot.remove();

              // If no more dots, remove bell notification
              if (document.querySelectorAll('[id^="dot-"]').length === 0) {
                  let bellDot = document.getElementById('bellDot');
                  if (bellDot) bellDot.remove();
              }
          }
      });
}
</script>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
