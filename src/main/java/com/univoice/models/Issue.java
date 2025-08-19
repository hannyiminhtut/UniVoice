package com.univoice.models;

import org.springframework.web.multipart.MultipartFile;

public class Issue {
	
	private int issue_id;
	private int student_id;
	private int dept_id;
	private String title;
	private String description;
	private String img;
	private String location;
	private String status;
	private String note;
	private String created_at;
	
	
	public Issue() {
		
	}

	public Issue(String title, String description, String location) {
		this.title = title;
		this.description = description;
		this.location = location;
	}

	public Issue(String title, String description, String img, String location) {
		this.title = title;
		this.description = description;
		this.img = img;
		this.location = location;
	}
	
	
	//student smbmit issue with image
	public Issue(int student_id, String title, String description, String img, String location) {
		
		this.student_id = student_id;
		this.title = title;
		this.description = description;
		this.img = img;
		this.location = location;
	}
	
    //submit issue without image
	public Issue(int student_id, String title, String description, String location) {
		super();
		this.student_id = student_id;
		this.title = title;
		this.description = description;
		this.location = location;
	}

	public int getIssue_id() {
		return issue_id;
	}

	public void setIssue_id(int issue_id) {
		this.issue_id = issue_id;
	}

	public int getStudent_id() {
		return student_id;
	}

	public void setStudent_id(int student_id) {
		this.student_id = student_id;
	}

	public int getDept_id() {
		return dept_id;
	}

	public void setDept_id(int dept_id) {
		this.dept_id = dept_id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}


	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getCreated_at() {
		return created_at;
	}

	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}
	
	

	
	
	
	
	

	
	
	
	
	

}
