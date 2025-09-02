package com.univoice.DAOS;

import java.util.Map;

public interface FeedbackResponseDAO {
	
	void saveResponse(int sessionId, int studentId, Map<Integer, String> answers);
}
