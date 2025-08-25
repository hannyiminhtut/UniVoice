package com.univoice.DAOS;

import java.util.List;

import com.univoice.models.FeedbackSession;

public interface FeedbackSessionDAO {
	
	 int createSession(String title, String deadlineDate);
	 
	 FeedbackSession findById(int id);
	 
	 void publish(int id);
	 
	 List<FeedbackSession> findAll();
	

}
