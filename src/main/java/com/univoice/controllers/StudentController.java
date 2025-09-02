package com.univoice.controllers;



import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.Mapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.univoice.DAOS.AdminDAO;
import com.univoice.DAOS.DeptDAO;
import com.univoice.DAOS.FeedbackDAO;
import com.univoice.DAOS.FeedbackSessionDAO;
import com.univoice.DAOS.IssueDAO;
import com.univoice.DAOS.StudentDAO;
import com.univoice.models.Admin;
import com.univoice.models.Department;
import com.univoice.models.FeedbackOptions;
import com.univoice.models.FeedbackQuestions;
import com.univoice.models.FeedbackSession;
import com.univoice.models.Issue;
import com.univoice.models.Student;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class StudentController {
	
@Autowired
private StudentDAO studentDAO;

@Autowired
private AdminDAO adminDAO;

@Autowired
private DeptDAO deptDAO;

@Autowired
private IssueDAO issueDAO;

@Autowired
private FeedbackSessionDAO sessionDAO;

@Autowired
private FeedbackDAO questionDAO;

@Autowired
private JdbcTemplate jdbcTemplate;

@PostMapping("/register")
public String register(
    @RequestParam("name") String name,
    @RequestParam("email") String email,
    @RequestParam("password") String password) {

    Student student = new Student();
    student.setEmail(email);
    student.setName(name);
    student.setPassword(password);

    studentDAO.saveStudent(student);
    return "redirect:/login";
}


@GetMapping("/login")
public String showLoginPage() {
    return "login"; 
}


@GetMapping("/contact")
public String showContactPage() {
    return "contact"; 
}

@GetMapping("/about")
public String showAboutPage() {
    return "about"; 
}



@PostMapping("/check")
public String login(@RequestParam("email") String email,
                    @RequestParam("password") String password,
                    HttpServletRequest request) {

    HttpSession session = request.getSession();

   
            Student student = studentDAO.findbyEmailandPassword(email, password);
            Admin admin = adminDAO.findbyEmailandPassword(email, password);
            Department department = deptDAO.findbyEmailandPassword(email, password);
            if (student != null) {
                session.setAttribute("student", student);
                return "redirect:/student-dashboard";
            } 
            else if (admin != null) {
                session.setAttribute("admin", admin);
                return "redirect:/admin-dashboard";
            }else if(department != null){
            	session.setAttribute("department", department);
            	return "redirect:/department-dashboard";
            }else {
            	  return "redirect:/login?error=invalid";
            }
           
           
            
       
  
}

@GetMapping("/student-dashboard")
public String showStudentDashboard(HttpSession session,Model model) {
	if (session.getAttribute("student") == null) return "redirect:/login";
	Student stud = (Student)session.getAttribute("student");
	int studId = stud.getUser_id();
	boolean hasPendingFeedback = sessionDAO.hasPendingFeedback(studId);
    model.addAttribute("hasPendingFeedback", hasPendingFeedback);
    return "student-dashboard"; 
}

@GetMapping("/student-dashboard/submitIssues")
public String showSubmitIssues(HttpSession session, Model model) {
    Student student = (Student) session.getAttribute("student");
    if (student == null) {
        return "redirect:/login";
    }
    model.addAttribute("student", student);
    return "submit-issues";
}

@GetMapping("student-dashboard/logout")
public String doLogout(HttpSession session) {
	session.invalidate();
	return "redirect:/";
}


@PostMapping("/student-dashboard/sendIssue")
public String sendIssue(
    @RequestParam("title") String title,
    @RequestParam("des") String des,
    @RequestParam("location") String location,
    @RequestParam(value = "img", required = false) MultipartFile img,
    HttpSession session,Model model) {
	
	 Student stud = (Student) session.getAttribute("student");
	 if (stud == null) return "redirect:/login";
try { 
	Issue issue = new Issue();
	issue.setTitle(title);
	issue.setDescription(des);
	issue.setLocation(location);
	issue.setStudent_id(stud.getUser_id());
	
	
	String imagePath = null;

    if (img != null && !img.isEmpty()) {
    	String folder = "C:/uploads/issues";
        File uploadDir = new File(folder);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // unique filename
        String fileName = System.currentTimeMillis() + "_" + img.getOriginalFilename();
        File destination = new File(uploadDir, fileName);
        img.transferTo(destination);

        // save relative path (to use in JSP/HTML <img>)
        imagePath = "/uploads/issues/" + fileName;
   
    }
    issue.setImg(imagePath);
	studentDAO.sendIssue(issue);
	model.addAttribute("success", "Issue is sent successfully");
	
	
    
}catch(Exception e) {
		model.addAttribute("fail","Failed to send issue");
	}

    return "submit-issues";
}




@GetMapping("/admin-dashboard")
public String showAdminDashboard(HttpSession session,Model model,HttpServletRequest req) {
	if(session.getAttribute("admin") == null ) return "redirect:/login";
	int totalDept = deptDAO.getTotalDept();
	int totalStud = studentDAO.getTotalStud();
	int totalSes = sessionDAO.getTotal();
	int totalPen = issueDAO.totalPendingIss();
	model.addAttribute("totalDept", totalDept);
	model.addAttribute("totalStud", totalStud);
	model.addAttribute("totalSes", totalSes);
	model.addAttribute("totalPen", totalPen);
	req.setAttribute("sessions", sessionDAO.findAll() );
	
	
	return "admin-dashboard";
}

@GetMapping("/department-dashboard")
public String showDepartmentDashboard(HttpSession session,Model model) {
	Department dept = (Department) session.getAttribute("department");
	 if (dept == null) return "redirect:/login";
	 
	 List<Issue> issues = issueDAO.findIssuesByDeptId(dept.getId());
	 model.addAttribute("department", dept);
	 model.addAttribute("issues", issues);
	return "department-dashboard";
}

@GetMapping("student-dashboard/feedback")
public String showFeedbackQuestions(HttpSession session,Model model) {
	
	 Student stud = (Student) session.getAttribute("student");
     int studId = stud.getUser_id();
     List<FeedbackSession> sessions = sessionDAO.getPendingSessionsForStudent(studId);
     model.addAttribute("sessions", sessions);
     return "answer-feedback";
	
}

@GetMapping("student-dashboard/feedback/{sessionId}")
public String showFeedbackQuestions(@PathVariable int sessionId, Model model) {
    // Fetch all questions for this session
    List<FeedbackQuestions> qs = questionDAO.findQuestionsBySession(sessionId);

    // Create a map to store options for each multiple-choice question
    Map<Integer, List<FeedbackOptions>> optionsMap = new HashMap<>();

    for (FeedbackQuestions q : qs) {
        if ("multiple".equalsIgnoreCase(q.getQuestionType())) {
            List<FeedbackOptions> opts = questionDAO.findOptionsByQuestionId(q.getId());
            optionsMap.put(q.getId(), opts);
        }
    }

    model.addAttribute("sessionId", sessionId);
    model.addAttribute("questions", qs);
    model.addAttribute("optionsMap", optionsMap); // <-- Add options map
    return "answer-questions";
}

@PostMapping("/student-dashboard/feedback/submit")
public String submitFeedback(
        @RequestParam int sessionId,
        @RequestParam Map<String, String> allParams,
        HttpSession session,
        RedirectAttributes redirectAttributes) {

    Student stud = (Student) session.getAttribute("student");
    if (stud == null) return "redirect:/login";

    int studentId = stud.getUser_id();

    // 1. Save response row (feedback_responses)
    int responseId = sessionDAO.saveFeedbackResponse(sessionId, studentId);

    // 2. Save each answer into feedback_answers
    for (Map.Entry<String, String> entry : allParams.entrySet()) {
        String key = entry.getKey();
        String value = entry.getValue();

        if (key.startsWith("q_")) {
            try {
                int questionId = Integer.parseInt(key.substring(2)); // "q_5" → 5

                questionDAO.saveAnswer(responseId, questionId, value);

            } catch (NumberFormatException e) {
                System.out.println("Invalid question key: " + key);
            }
        }
    }

    redirectAttributes.addFlashAttribute("msg", "Thank You, Your feedback has been submitted");
    return "redirect:/student-dashboard"; // A simple JSP confirmation page
}

@GetMapping("/student-dashboard/issueResult")
public String showissueResult(HttpSession session,Model model) {
	Student stud = (Student)session.getAttribute("student");
	int stud_id = stud.getUser_id();
	List<Issue> issues = issueDAO.findIssuesByStudId(stud_id);
	model.addAttribute("issues", issues);
	return "viewIssueResult";
}

@GetMapping("/student-dashboard/createProfile/{id}")
public String createProfile(HttpSession session,Model model,RedirectAttributes redirectAttributes,@PathVariable int id) {
	Student stud = studentDAO.findById(id);
	model.addAttribute("student",stud);
	return "create-studprofile";
}

@PostMapping("/student-dashboard/updateProfile")
public String updateProfile(
        @RequestParam("name") String name,
        @RequestParam("email") String email,
        @RequestParam(value = "password", required = false) String password,
        @RequestParam(value = "image", required = false) MultipartFile image,
        HttpSession session,
        RedirectAttributes redirectAttributes) {

    try {
        // Get logged-in student from session (don’t trust hidden form id)
        Student sessionStudent = (Student) session.getAttribute("student");
        if (sessionStudent == null) {
            redirectAttributes.addFlashAttribute("fail", "Session expired. Please log in again.");
            return "redirect:/login";
        }
        int studentId = sessionStudent.getUser_id();

        // 1) Email validation (case-insensitive)
        if (email == null || !email.toLowerCase().endsWith("@uit.edu.mm")) {
            redirectAttributes.addFlashAttribute("fail", "Email must end with @uit.edu.mm");
            return "redirect:/student-dashboard/createProfile/" + studentId;
        }

        // 2) Load current row
        Student existing = studentDAO.findById(studentId);
        if (existing == null) {
            redirectAttributes.addFlashAttribute("fail", "Student not found.");
            return "redirect:/student-dashboard";
        }

        // 3) Handle image (keep old if none)
        String imagePath = existing.getImage();
        if (image != null && !image.isEmpty()) {
            String folder = "C:/uploads/students";
            File uploadDir = new File(folder);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            String original = image.getOriginalFilename();
            String safe = (original == null) ? "img" : original.replaceAll("[^a-zA-Z0-9._-]", "_");
            String fileName = System.currentTimeMillis() + "_" + safe;
            File dest = new File(uploadDir, fileName);
            image.transferTo(dest);

            imagePath = "/uploads/students/" + fileName;
        }

        // 4) Prepare updated fields
        existing.setName(name);
        existing.setEmail(email);
        existing.setImage(imagePath);

        // 5) Update (with or without password)
        int rows;
        if (password != null && !password.isBlank()) {
            String policy = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$";
            if (!password.matches(policy)) {
                redirectAttributes.addFlashAttribute("fail",
                    "Password must be at least 8 characters and include uppercase, lowercase, number, and special character.");
                return "redirect:/student-dashboard/createProfile/" + studentId;
            }
            existing.setPassword(password);
            rows = studentDAO.updateProfile(existing);
        } else {
            rows = studentDAO.updateProfileWithoutPassword(existing);
        }

        if (rows <= 0) {
            redirectAttributes.addFlashAttribute("fail", "No rows updated. Please try again.");
            return "redirect:/student-dashboard/createProfile/" + studentId;
        }

        // 6) Refresh session copy
        session.setAttribute("student", existing);

        redirectAttributes.addFlashAttribute("success", "Profile updated successfully!");
        return "redirect:/student-dashboard/createProfile/" + studentId;

    } catch (org.springframework.dao.DuplicateKeyException ex) {
        redirectAttributes.addFlashAttribute("fail", "This email is already in use.");
        return "redirect:/student-dashboard" + ((Student)session.getAttribute("student")).getUser_id();

    } catch (Exception e) {
        e.printStackTrace();
        redirectAttributes.addFlashAttribute("fail", "Failed to update profile.");
        return "redirect:/student-dashboard/createProfile/" + ((Student)session.getAttribute("student")).getUser_id();
    }
}





	
	

}
