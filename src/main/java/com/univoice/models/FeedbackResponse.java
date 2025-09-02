package com.univoice.models;

public class FeedbackResponse {
	
	private int id;
	private int session_id;
	private int student_id;
	private String submitted_at;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getSession_id() {
		return session_id;
	}
	public void setSession_id(int session_id) {
		this.session_id = session_id;
	}
	public int getStudent_id() {
		return student_id;
	}
	public void setStudent_id(int student_id) {
		this.student_id = student_id;
	}
	public String getSubmitted_at() {
		return submitted_at;
	}
	public void setSubmitted_at(String submitted_at) {
		this.submitted_at = submitted_at;
	}
	
	

}
