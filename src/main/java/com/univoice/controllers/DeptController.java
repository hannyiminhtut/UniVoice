package com.univoice.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.univoice.DAOS.DeptDAO;
import com.univoice.models.Department;

@Controller
public class DeptController {
	
@Autowired
private DeptDAO deptDAO;

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
	

}
