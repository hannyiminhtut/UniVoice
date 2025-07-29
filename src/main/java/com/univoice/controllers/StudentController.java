package com.univoice.controllers;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.Mapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.univoice.DAOS.AdminDAO;
import com.univoice.DAOS.StudentDAO;
import com.univoice.models.Admin;
import com.univoice.models.Student;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class StudentController {
	
@Autowired
private StudentDAO studentDAO;

@Autowired
private AdminDAO adminDAO;

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
                    @RequestParam("userType") String role,
                    HttpServletRequest request) {

    HttpSession session = request.getSession();

    switch (role) {
        case "student":
            Student student = studentDAO.findbyEmailandPassword(email, password);
            if (student != null) {
                session.setAttribute("student", student);
                return "redirect:/student-dashboard";
            }
            break;
       case "admin":
            Admin admin = adminDAO.findbyEmailandPassword(email, password);
            if (admin != null) {
                session.setAttribute("admin", admin);
                return "redirect:/admin-dashboard";
            }
            break;
       /* case "department":
            Department dept = departmentDAO.findByEmailAndPassword(email, password);
            if (dept != null) {
                session.setAttribute("department", dept);
                return "redirect:/department/dashboard";
            }
            break;*/
    }

    // If login fails
    return "redirect:/login?error=invalid";
}

@GetMapping("/student-dashboard")
public String showStudentDashboard(HttpSession session) {
	if (session.getAttribute("student") == null) return "redirect:/login";
    return "student-dashboard"; 
}

@GetMapping("/admin-dashboard")
public String showAdminDashboard(HttpSession session) {
	if(session.getAttribute("admin") == null ) return "redirect:/login";
	return "admin-dashboard";
}

	
	

}
