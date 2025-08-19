package com.univoice.models;

public class Department {
	
	private int id;
	private String email;
	private String name;
	private String password;
	private String image;
	
	public Department() {};
	
	public Department(String email, String name, String password) {
		this.email = email;
		this.name = name;
		this.password = password;
	}


	public Department(int id, String email, String name, String password, String image) {
		
		this.id = id;
		this.email = email;
		this.name = name;
		this.password = password;
		this.image = image;
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
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
