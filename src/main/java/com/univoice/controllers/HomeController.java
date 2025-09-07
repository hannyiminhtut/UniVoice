package com.univoice.controllers;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
	
	@GetMapping("/health")
	public String health() { return "health"; }

	
	@GetMapping("/")
    public String index() {
        return "index"; // Will load /WEB-INF/views/index.jsp
    }
	
	@GetMapping("/about/")
    public String about() {
        // resolves to /WEB-INF/views/about.jsp
        return "about";
    }

    @GetMapping("/contact/")
    public String contact() {
        // resolves to /WEB-INF/views/contact.jsp
        return "contact";
    }
	
	@GetMapping("/user/")
	 public String user() {
        return "user"; 
    }
	
	
	
	
}
