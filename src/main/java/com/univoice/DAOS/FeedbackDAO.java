package com.univoice.DAOS;

import java.util.List;

import com.univoice.models.FeedbackQuestions;

public interface FeedbackDAO {
	
	int addQuestion(FeedbackQuestions q);
	
	List<FeedbackQuestions> findQuestionsBySession(int sessionId);
	
	void deleteQuestion(int questionId);

}
