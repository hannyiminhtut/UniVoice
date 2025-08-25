package com.univoice.controllers;



import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.Mapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import com.univoice.DAOS.AdminDAO;
import com.univoice.DAOS.DeptDAO;
import com.univoice.DAOS.IssueDAO;
import com.univoice.DAOS.StudentDAO;
import com.univoice.models.Admin;
import com.univoice.models.Department;
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
public String showStudentDashboard(HttpSession session) {
	if (session.getAttribute("student") == null) return "redirect:/login";
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
public String showAdminDashboard(HttpSession session,Model model) {
	if(session.getAttribute("admin") == null ) return "redirect:/login";
	int totalDept = deptDAO.getTotalDept();
	int totalStud = studentDAO.getTotalStud();
	model.addAttribute("totalDept", totalDept);
	model.addAttribute("totalStud", totalStud);
	
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



	
	

}
