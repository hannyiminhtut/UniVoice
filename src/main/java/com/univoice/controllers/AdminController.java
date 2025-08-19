package com.univoice.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.univoice.DAOS.DeptDAO;
import com.univoice.DAOS.IssueDAO;
import com.univoice.models.Department;
import com.univoice.models.Issue;


import jakarta.servlet.http.HttpSession;

@Controller
public class AdminController {
	
	@Autowired
	private IssueDAO issueDAO;
	
	@Autowired
	private DeptDAO deptDAO;
	
	@GetMapping("admin-dashboard/create")
	public String createDepartment() {
		return "create-department";
	}
	
	@GetMapping("admin-dashboard/questions")
	public String createQuestions() {
		return "create-questions";
	}
	
	@GetMapping("admin-dashboard/issues")
	public String viewIssues(Model model) {
		List<Issue> issues = issueDAO.getAllIssues();
		model.addAttribute("issues", issues);
		return "view-issues";
	}
	
	 @GetMapping("admin-dashboard/issues/{id}")
	    public String viewIssueDetails(@PathVariable("id") int id, Model model) {
	        Issue issue = issueDAO.getIssueById(id);
	        List<Department> depts = deptDAO.getAllDepartments();
	        model.addAttribute("issue", issue);
	        model.addAttribute("departments", depts);
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
	
	

}
