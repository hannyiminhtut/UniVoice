package com.univoice.DAOS;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class FeedbackResponseImple implements FeedbackResponseDAO {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Override
	public void saveResponse(int sessionId, int studentId, Map<Integer, String> answers) {
		
	    // Insert response
	    String insertResponseSql = "INSERT INTO feedback_responses (session_id, student_id) VALUES (?, ?)";
	    jdbcTemplate.update(insertResponseSql, sessionId, studentId);

	    // Get the last inserted response_id (for this student & session)
	    String getIdSql = "SELECT id FROM feedback_responses WHERE session_id = ? AND student_id = ? ORDER BY id DESC LIMIT 1";
	    Integer responseId = jdbcTemplate.queryForObject(getIdSql, Integer.class, sessionId, studentId);

	    // Insert answers
	    String ansSql = "INSERT INTO feedback_answers (response_id, question_id, answer_text) VALUES (?, ?, ?)";
	    for (Map.Entry<Integer, String> entry : answers.entrySet()) {
	        jdbcTemplate.update(ansSql, responseId, entry.getKey(), entry.getValue());
	    }
	}


}
