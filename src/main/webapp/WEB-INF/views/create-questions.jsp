<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UniVoice</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<style>
    body {
        background-color: #f8f9fa;
    }
    .card {
        border-radius: 16px;
        box-shadow: 0 10px 25px rgba(0, 0, 139, 0.4); 
    }
    
    .form-label {
        font-weight: 500;
    }
    
    .form-control, .form-select {
        border-radius: 12px;
    }
    
    .btn-primary {
        border-radius: 12px;
        background-color: #0d6efd;
    }
    .question-group {
        padding: 15px;
        background-color: #ffffff;
        border: 1px solid #ddd;
        border-radius: 12px;
        margin-bottom: 15px;
    }
    
    .star-rating i {
        font-size: 1.5rem;
        color: #ccc;
        cursor: pointer;
    }
    
    .star-rating .checked {
        color: gold;
    }
    
    .navbar {
		    height: 65px;
		    border-bottom: 1px solid #eee;
		    font-family: 'Segoe UI', sans-serif;
		}
</style>
</head>
<body>

<!-- Top Navbar -->
<nav class="navbar navbar-expand-lg bg-white shadow-sm px-3">
    <div class="container-fluid d-flex justify-content-between align-items-center">
        
     <div class="d-flex align-items-center gap-3">
	    <div class="fw-bold fs-5 text-dark"><a href="/admin-dashboard" style="text-decoration:none;">Admin Dashboard</a></div>
	</div>

        <!-- Right-side icons and profile -->
        <div class="d-flex align-items-center gap-3">
            <!-- Message icon -->
            <a href="#" class="text-decoration-none position-relative">
                <i class="fa-solid fa-envelopes-bulk"></i>
            </a>
            <!-- Notification icon -->
            <a href="#" class="text-decoration-none position-relative">
                <i class="fa-solid fa-bell"></i>
            </a>
            <!-- Profile -->
            <div class="d-flex align-items-center">
                <img src="../assets/imgs/blank-profile.webp" class="rounded-circle me-2" width="35" height="33" style="object-fit: cover;">
                <div class="text-end">
                    <div class="fw-bold">Admin</div>
                   
                </div>
            </div>
        </div>
    </div>
</nav>

<div class="container my-3">
    <div class="row justify-content-center">
    
    	<div class="col-lg-8" >
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
		
		</div>
        <div class="col-lg-8">
            <div class="card p-4">
                <h5 class="text-center fw-bold text-primary mb-4" style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;">Create Feedback Questions</h5>

                <form action="/admin-dashboard/save-question" method="post">
                    <!-- Feedback Title -->
                    <div class="mb-3">
                        <label class="form-label">Feedback Title</label>
                        <input type="text" name="feedbackTitle" class="form-control" placeholder="Semester 6 Academic Feedback" required />
                    </div>

                    <!-- Deadline Date -->
                    <div class="mb-3">
                        <label class="form-label">Deadline Date</label>
                        <input type="date" name="deadlineDate" class="form-control" required />
                    </div>

                    <!-- Question Text -->
                    <div class="mb-3">
                        <label class="form-label">Question</label>
                        <textarea name="questionText" class="form-control" rows="3" placeholder="Write your question here..." required></textarea>
                    </div>

                    <!-- Question Type -->
                    <div class="mb-3">
                        <label class="form-label">Question Type</label>
                        <select name="questionType" class="form-select" id="questionType" required onchange="toggleQuestionFields()">
                            <option value="">Select Question Type</option>
                            <option value="multiple">Multiple Choice</option>
                            <option value="rating">Rating</option>
                        </select>
                    </div>

                    <!-- Multiple Choice -->
                    <div class="mb-3" id="multipleChoiceOptions" style="display:none;">
                        <label class="form-label">Add Options</label>
                        <div id="optionsContainer"></div>
                        <button type="button" class="btn btn-sm btn-outline-secondary mt-2" onclick="addOption()">➕ Add Option</button>
                    </div>

                    <!-- Rating -->
                    <div class="mb-3" id="ratingField" style="display:none;">
                        <label class="form-label">Select Rating</label>
                        <div class="star-rating" id="starRating">
                            <i class="fas fa-star" data-value="1"></i>
                            <i class="fas fa-star" data-value="2"></i>
                            <i class="fas fa-star" data-value="3"></i>
                            <i class="fas fa-star" data-value="4"></i>
                            <i class="fas fa-star" data-value="5"></i>
                        </div>
                        <input type="hidden" name="ratingValue" id="ratingValue" />
                        <small class="text-muted">Students will be able to rate from 1 (Poor) to 5 (Excellent).</small>
                    </div>

                    <!-- Submit -->
                    <div class="text-center mt-4">
                        <button type="submit" class="btn btn-primary px-4 py-2">➕ Add Question</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Scripts -->
<script>
    function toggleQuestionFields() {
        const type = document.getElementById('questionType').value;
        document.getElementById('multipleChoiceOptions').style.display = (type === 'multiple') ? 'block' : 'none';
        document.getElementById('ratingField').style.display = (type === 'rating') ? 'block' : 'none';
    }

    function addOption() {
        const container = document.getElementById("optionsContainer");
        const index = container.children.length + 1;

        const optionHTML = `
            <div class="form-check mt-1">
                <input class="form-check-input" type="radio" name="dummyRadio" disabled />
                <input type="text" name="options" class="form-control d-inline-block ms-2" style="width: 85%;" placeholder="Option ${index}" required />
            </div>
        `;
        container.insertAdjacentHTML('beforeend', optionHTML);
    }

    // Rating stars
    const stars = document.querySelectorAll('#starRating i');
    stars.forEach(star => {
        star.addEventListener('click', function () {
            const rating = this.getAttribute('data-value');
            document.getElementById('ratingValue').value = rating;

            stars.forEach(s => s.classList.remove('checked'));
            for (let i = 0; i < rating; i++) {
                stars[i].classList.add('checked');
            }
        });
    });
    
    setTimeout(() => {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(alert => alert.remove());
    }, 5000);
    	
  
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
