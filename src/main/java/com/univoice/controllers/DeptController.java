package com.univoice.controllers;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.univoice.DAOS.DeptDAO;
import com.univoice.DAOS.IssueDAO;
import com.univoice.models.Department;

import jakarta.servlet.http.HttpSession;

@Controller
public class DeptController {
	
@Autowired
private DeptDAO deptDAO;

@Autowired
private IssueDAO issueDAO;

@PostMapping("/create-department")
public String createDept(
		@RequestParam("name") String name,
	    @RequestParam("email") String email,
	    @RequestParam("password") String password,
	    Model model) {
try {	
	Department dept = new Department();
	dept.setEmail(email);
	dept.setName(name);
	dept.setPassword(password);
	deptDAO.saveDept(dept);
	
	model.addAttribute("success","Department created successfully" );
}catch(Exception e) {
	model.addAttribute("fail", "Failed to create department!");
	
}
	
	return "create-department";
}

@PostMapping("department-dashboard/sendNote")
public String sendNote(
		@RequestParam("issueId") int id,
		@RequestParam("note")String note,
		 RedirectAttributes redirectAttributes) {
	
	 int rows = issueDAO.updateNote(id, note);

	    if (rows > 0) {
	        redirectAttributes.addFlashAttribute("success", "Resolution note ");
	    } else {
	        redirectAttributes.addFlashAttribute("error", "Issue not found!");
	    }
	
	
	return "redirect:/department-dashboard";
}

@PostMapping("department-dashboard/markAsRead")
@ResponseBody
public String markAsRead(@RequestParam("issueId") int issueId) {
    issueDAO.markIssueAsRead(issueId);
    return "OK";
}

@GetMapping("department-dashboard/profile")
public String uploadProfile(HttpSession session,Model model) {
	Department dept = (Department) session.getAttribute("department");
	model.addAttribute("dept", dept);
	return "department-profile";
}

@PostMapping("/department-dashboard/updateProfilePic")
public String updateProfilePic(@RequestParam("profilePic") MultipartFile file,
								@RequestParam("dID") int dID,
                               HttpSession session, RedirectAttributes redirectAttributes) {
    try {
        // Ensure upload directory exists
        String uploadDir = "C:/uploads/issues";
        File dir = new File(uploadDir);
        if (!dir.exists()) dir.mkdirs();

        // Save uploaded file
        String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
        Path path = Paths.get(uploadDir,fileName);
        Files.copy(file.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);

        // Get logged-in department from session
        Department dept = (Department) session.getAttribute("department");

        // Save relative path for web access (not absolute disk path)
        String imagePath = "/uploads/issues/" + fileName;
        deptDAO.updateProfileImage(dID, imagePath);

        // Update session object too
        dept.setImage(imagePath);
        session.setAttribute("dept", dept);

        redirectAttributes.addFlashAttribute("success", "Profile picture updated successfully!");
    } catch (Exception e) {
        e.printStackTrace();
        redirectAttributes.addFlashAttribute("error", "Failed to upload profile picture.");
    }
    return "redirect:/department-dashboard";
}

@GetMapping("department-dashboard/logout")
public String doLogout(HttpSession session) {
	session.invalidate();
	return "redirect:/";
}



	

}
