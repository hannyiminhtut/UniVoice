package com.univoice.controllers;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
import com.univoice.models.FeedbackQuestions;
import com.univoice.models.FeedbackSession;
import com.univoice.models.Issue;
import com.univoice.models.Student;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class AdminController {
	
	@Autowired
	private IssueDAO issueDAO;
	
	@Autowired
	private DeptDAO deptDAO;
	
	@Autowired
	private FeedbackDAO questionDAO;
	
	@Autowired
	private FeedbackSessionDAO sessionDAO;
	
	@Autowired
	private StudentDAO studDAO;
	
	@Autowired
	private AdminDAO adminDAO;
	
	@GetMapping("admin-dashboard/create")
	public String createDepartment() {
		return "create-department";
	}
	
	@GetMapping("admin-dashboard/questions")
	public String createQuestions() {
		return "create-feedback";
	}
	
	@GetMapping("admin-dashboard/issues")
	public String viewIssues(Model model, HttpSession session) {
	    List<Issue> issues = issueDAO.findAllForAdmin();
	    model.addAttribute("issues", issues);

	    // ✅ Admin is viewing issues → mark all current pending as seen
	    issueDAO.markAllPendingAsSeen();

	    int totalPen = issueDAO.totalPendingIss(); // still show total count on page if needed
	    model.addAttribute("totalPen", totalPen);
	    model.addAttribute("unseenPen", 0);
	    model.addAttribute("pendingBell", false);


	    return "view-issues";
	}

	
	 @GetMapping("admin-dashboard/issues/{id}")
	    public String viewIssueDetails(@PathVariable("id") int id, Model model,HttpServletRequest request) {
	        Issue issue = issueDAO.getIssueById(id);
	        if (issue.getNote() != null && !issue.getNote().trim().isEmpty()) {
	            issueDAO.updateNoteRead(id);
	            //issue.setNoteRead(true); // update model object too
	        }
	        List<Department> depts = deptDAO.getAllDepartments();
	        String deptName = issueDAO.getDeptNameByIssueId(id);
	        model.addAttribute("issue", issue);
	        model.addAttribute("departments", depts);
	        model.addAttribute("deptName", deptName);
	        
	      
	        return "issue-details"; // admin-issue-details.jsp
	    }
	 
	 @GetMapping("admin-dashboard/logout")
	 public String doLogout(HttpSession session) {
	 	session.invalidate();
	 	return "redirect:/";
	 }
	 
	 @PostMapping("/admin/issues/assign")
	 public String assignAssue(@RequestParam("issueId") int issueId,
			 				   @RequestParam("departmentId") int deptId,
			 				   RedirectAttributes redirectAttributes) {
		 try {
			 deptDAO.issueAssignToDept(issueId, deptId);
			 redirectAttributes.addFlashAttribute("success", "Issue is assigned successfully");
			 
		 }catch(Exception e) {
			 redirectAttributes.addFlashAttribute("fail", "Failed to assign issue");
			 
		 }
		 
		 return "redirect:/admin-dashboard/issues";
	 }
	 
	 @PostMapping("admin-dashboard/issues/resolve")
	 public String changeStatus(@RequestParam("issueId") int id,
			 					RedirectAttributes redirectAttributes) {
		 
		 int rows = issueDAO.updateStatus(id);
		 if (rows > 0) {
		        redirectAttributes.addFlashAttribute("success", "Issue is resolved ");
		    } else {
		        redirectAttributes.addFlashAttribute("error", "Issue not found!");
		    }
		 
		 return "redirect:/admin-dashboard/issues";
	 }
	 
	 @PostMapping("admin-dashboard/issues/banned/{id}")
	 public String bannedIssue(@PathVariable("id") int iD,RedirectAttributes redirectAttributes) {
		 int rows = issueDAO.bannedIssue(iD);
		 if (rows > 0) {
		        redirectAttributes.addFlashAttribute("success", "Issue is banned ");
		    } else {
		        redirectAttributes.addFlashAttribute("error", "Issue not found!");
		    }
		 
		 return "redirect:/admin-dashboard/issues";
		 
		
	 }
	 
	 @PostMapping("/admin-dashboard/create-session")
	    public String createSession(@RequestParam String feedbackTitle,
	                                @RequestParam String deadlineDate,
	                                HttpSession httpSession) {
	        int sessionId = sessionDAO.createSession(feedbackTitle, deadlineDate);
	        httpSession.setAttribute("currentSessionId", sessionId);
	        return "redirect:/admin-dashboard/add-question";
	    }
	 
	 @GetMapping("/admin-dashboard/add-question")
	    public String addQuestionPage(HttpSession httpSession, Model model) {
	        Integer sessionId = (Integer) httpSession.getAttribute("currentSessionId");
	        if (sessionId == null) return "redirect:/admin-dashboard/create-feedback";

	        FeedbackSession s = sessionDAO.findById(sessionId);
	        List<FeedbackQuestions> qs = questionDAO.findQuestionsBySession(sessionId);

	        model.addAttribute("session", s);
	        model.addAttribute("questions", qs);
	        return "add-questions"; // JSP with your MCQ/Rating form + list
	    }
	 
	 @PostMapping("/admin-dashboard/save-question")
	    public String saveQuestion(@RequestParam String questionText,
	                               @RequestParam String questionType,
	                               @RequestParam(value = "options", required = false) String[] options,
	                               HttpSession httpSession,
	                               HttpServletRequest request) {
	        Integer sessionId = (Integer) httpSession.getAttribute("currentSessionId");
	        if (sessionId == null) return "redirect:/admin-dashboard/create-feedback";

	        FeedbackQuestions q = new FeedbackQuestions();
	        q.setSessionId(sessionId);
	        q.setQuestionText(questionText);
	        q.setQuestionType(questionType);
	        if ("multiple".equals(questionType) && options != null) {
	            q.setOptions(Arrays.asList(options));
	        }
	        questionDAO.addQuestion(q);

	        request.setAttribute("success", "Question added.");
	        return "redirect:/admin-dashboard/add-question";
	    }
	 
	 @GetMapping("/admin-dashboard/review-session")
	    public String reviewSession(HttpSession httpSession, Model model) {
	        Integer sessionId = (Integer) httpSession.getAttribute("currentSessionId");
	        if (sessionId == null) return "redirect:/admin-dashboard/create-feedback";

	        FeedbackSession s = sessionDAO.findById(sessionId);
	        List<FeedbackQuestions> qs = questionDAO.findQuestionsBySession(sessionId);

	        model.addAttribute("session", s);
	        model.addAttribute("questions", qs);
	        return "review-session"; // JSP
	    }
	
	  @PostMapping("/admin-dashboard/publish-session")
	    public String publishSession(HttpSession httpSession) {
	        Integer sessionId = (Integer) httpSession.getAttribute("currentSessionId");
	        if (sessionId != null) sessionDAO.publish(sessionId);
	        return "redirect:/admin-dashboard"; // your dashboard landing
	    }
	  
	  @PostMapping("/admin-dashboard/delete-question")
	    public String deleteQuestion(@RequestParam int questionId) {
	        questionDAO.deleteQuestion(questionId);
	        return "redirect:/admin-dashboard/add-question";
	    }
	  
	  @GetMapping("admin-dashboard/viewDept")
	  public String viewDeptList(Model model) {
		  List<Department> depts = deptDAO.getAllDepartments();
		  model.addAttribute("depts", depts);
		  return "viewDeptList";
	  }
	  
	  @GetMapping("/admindashboard/viewStud")
	  public String viewStudList(Model model) {
		  List<Student> studs = studDAO.getAllStudents();
		  model.addAttribute("studs", studs);
		  return "viewStudList";
	  }
	  
	  @PostMapping("/admin-dashboard/issues/delete/{id}")
	  public String deleteResolvedIssue(@PathVariable("id") int iD,RedirectAttributes redirectAttributes) {
		  issueDAO.archiveResolvedByAdmin(iD);
		  return "redirect:/admin-dashboard/issues";
		
	  }
	  
	  @PostMapping("admin-dashboard/deleteSession/{id}")
	  public String deleteOverDueSession(@PathVariable("id") int iD,RedirectAttributes redirectAttributes) {
		  try {
			  sessionDAO.deleteSession(iD);
			  redirectAttributes.addFlashAttribute("success", "Session is deleted ");
		  }catch(Exception e) {
			  redirectAttributes.addFlashAttribute("fail", "Failed to delete session! ");
		  }
		  return "redirect:/admin-dashboard/viewfeedback";
	  }
	  
	  @GetMapping("admin-dashboard/profile")
	  public String uploadProfile(HttpSession session,Model model) {
	  	Admin admin = (Admin) session.getAttribute("admin");
	  	model.addAttribute("admin", admin);
	  	return "admin-profile";
	  }
	  
	  @PostMapping("/admin-dashboard/updateProfilePic")
	  public String updateProfilePic(@RequestParam("profilePic") MultipartFile file,
	  								@RequestParam("aID") int aID,
	                                 HttpSession session, RedirectAttributes redirectAttributes) {
	      try {
	          // Ensure upload directory exists
	          String uploadDir = "C:/uploads/admin";
	          File dir = new File(uploadDir);
	          if (!dir.exists()) dir.mkdirs();

	          // Save uploaded file
	          String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
	          Path path = Paths.get(uploadDir,fileName);
	          Files.copy(file.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);

	          // Get logged-in department from session
	          Admin admin = (Admin) session.getAttribute("admin");

	          // Save relative path for web access (not absolute disk path)
	          String imagePath = "/uploads/admin/" + fileName;
	          adminDAO.updateProfileImage(aID, imagePath);

	          // Update session object too
	          admin.setImage(imagePath);
	          session.setAttribute("admin", admin);

	          redirectAttributes.addFlashAttribute("success", "Profile picture updated successfully!");
	      } catch (Exception e) {
	          e.printStackTrace();
	          redirectAttributes.addFlashAttribute("error", "Failed to upload profile picture.");
	      }
	      return "redirect:/admin-dashboard";
	  }
	  
	 
	

}
