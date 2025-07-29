package com.univoice.controllers;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
	
	@GetMapping("/")
    public String index() {
        return "index"; // Will load /WEB-INF/views/index.jsp
    }
	
	@GetMapping("/user/")
	 public String user() {
        return "user"; 
    }
	
	
	
	
}
