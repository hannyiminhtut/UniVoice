package com.univoice.controllers;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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

//Regex rules
// Name: letters and single spaces only (no digits, no special chars)
private static final Pattern NAME_PATTERN = Pattern.compile("^[A-Za-z]+(?:\\s[A-Za-z]+)*$");

// Email: must be local-part + "@uit.edu.mm"
private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9._%+-]+@uit\\.edu\\.mm$", Pattern.CASE_INSENSITIVE);

// Password: >= 8 chars, at least one lower, one upper, one digit, one special
// If you want EXACTLY 8 chars, change {8,} to {8}
private static final Pattern PASSWORD_PATTERN = Pattern.compile(
        "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[\\W_]).{8,}$"
);

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
	
	model.addAttribute("ok","Department created successfully" );
}catch(Exception e) {
	model.addAttribute("fail", "Failed to create department!");
	
}
	
	return "redirect:/admin-dashboard/viewDept";
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

@GetMapping("admin-dashboard/departments/edit/{id}")
public String showEditForm(@PathVariable int id, Model model, RedirectAttributes re) {
	Department dept = deptDAO.findbyId(id);
	model.addAttribute("dept", dept);
	return "edit-department";
}

@PostMapping("admin-dashboard/departments/edit/{id}")
public String updateDepartment(@PathVariable int id,
                               @RequestParam String name,
                               @RequestParam String email,
                               @RequestParam String password,
                               RedirectAttributes ra,
                               Model model) {

    Department existing = deptDAO.findbyId(id);
    if (existing == null) {
        ra.addFlashAttribute("error", "Department not found.");
        return "redirect:/admin-dashboard/viewDept";
    }

    String nameTrim = name == null ? "" : name.trim();
    String emailTrim = email == null ? "" : email.trim();
    String passRaw  = password == null ? "" : password; // keep as-is (may contain spaces)

    boolean hasError = false;

    // Name validation
    if (nameTrim.isEmpty() || !NAME_PATTERN.matcher(nameTrim).matches()) {
        model.addAttribute("errName", "Name must contain letters and spaces only (no numbers or special characters).");
        hasError = true;
    }

    // Email validation
    if (emailTrim.isEmpty() || !EMAIL_PATTERN.matcher(emailTrim).matches()) {
        model.addAttribute("errEmail", "Email must be a valid address ending with @uit.edu.mm.");
        hasError = true;
    }

    // Password validation (must meet complexity)
    if (passRaw.isEmpty() || !PASSWORD_PATTERN.matcher(passRaw).matches()) {
        model.addAttribute("errPassword", "Password must be at least 8 characters and include uppercase, lowercase, number, and special character.");
        hasError = true;
    }

    if (hasError) {
        // send back what the user typed so the form stays filled
        Department back = new Department();
        back.setId(existing.getId());
        back.setName(nameTrim);
        back.setEmail(emailTrim);
        back.setPassword(passRaw);       // shown with eye toggle on the form
        back.setImage(existing.getImage()); // image not editable, but needed for header preview
        model.addAttribute("dept", back);
        ra.addFlashAttribute("fail", "Failed to update department!");
        return "redirect:/admin-dashboard/departments/edit/{id}";
    }

    // All good -> persist
    existing.setName(nameTrim);
    existing.setEmail(emailTrim);

    // TODO: hash the password (recommended)
    // String hashed = passwordEncoder.encode(passRaw);
    // existing.setPassword(hashed);
    existing.setPassword(passRaw);

    // Image is not updated here (admin cannot change profile image)
    deptDAO.update(existing);

    ra.addFlashAttribute("success", "Department updated successfully.");
    return "redirect:/admin-dashboard/viewDept";
}

@PostMapping("/admin-dashboard/departments/delete/{id}")
public String deleteDepartment(@PathVariable int id, RedirectAttributes ra) {
    Department existing = deptDAO.findbyId(id);
    if (existing == null) {
        ra.addFlashAttribute("error", "Department not found.");
        return "redirect:/admin-dashboard/viewDept";
    }
    try {
        int rows = deptDAO.deleteDept(id);
        if (rows > 0) {
            ra.addFlashAttribute("success", "Department \"" + existing.getName() + "\" deleted.");
        } else {
            ra.addFlashAttribute("error", "Delete failed. Please try again.");
        }
    } catch (Exception e) {
        // e.g., foreign key constraints (students/issues referencing this department)
        ra.addFlashAttribute("error",
            "Cannot delete \"" + existing.getName() + "\" because it is referenced by other records.");
    }
    return "redirect:/admin-dashboard/viewDept";
}



	

}
