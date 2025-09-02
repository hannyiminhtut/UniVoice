package com.univoice.DAOS;

import java.util.List;

import com.univoice.models.FeedbackSession;

public interface FeedbackSessionDAO {
	
	 int createSession(String title, String deadlineDate);
	 
	 FeedbackSession findById(int id);
	 
	 void publish(int id);
	 
	 List<FeedbackSession> findAll();
	 
	 boolean hasPendingFeedback(int studentId);
	 
	 List<FeedbackSession> getPendingSessionsForStudent(int studentId);
	 
	 int saveFeedbackResponse(int sessionId, int studentId);
	 
	 int getTotal();
	 
	 int deleteSession(int id);
	 
	 
	 
	 
	

}
