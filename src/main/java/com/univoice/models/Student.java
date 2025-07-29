package com.univoice.models;

public class Student {
	private int user_id;
	private String name;
	private String email;
	private String password;
	private String image;
	
	public Student() {};
	
	public Student(String name,String email,String password ) {
		this.name = name;
		this.email = email;
		this.password = password;
	}
	
	public Student(int user_id, String name, String email, String password, String image) {
		super();
		this.user_id = user_id;
		this.name = name;
		this.email = email;
		this.password = password;
		this.image = image;
	}
	
	

	public Student(String email, String password) {
		super();
		this.email = email;
		this.password = password;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	
	
	
	
	
	
	
	
}
