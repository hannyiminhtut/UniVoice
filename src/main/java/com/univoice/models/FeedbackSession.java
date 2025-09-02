package com.univoice.models;

public class FeedbackSession {
	
	 private int id;
	 private String title;
	 private String deadline_date; 
	 private boolean published;
	 private String created_at;
	 
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDeadline_date() {
		return deadline_date;
	}
	public void setDeadline_date(String deadline_date) {
		this.deadline_date = deadline_date;
	}
	public boolean isPublished() {
		return published;
	}
	
	public void setPublished(boolean published) {
		this.published = published;
	}
	public String getCreated_at() {
		return created_at;
	}
	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}
	 

	 

}
