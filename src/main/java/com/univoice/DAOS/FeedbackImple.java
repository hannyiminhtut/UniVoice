package com.univoice.DAOS;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.univoice.models.FeedbackQuestions;

@Repository
public class FeedbackImple implements FeedbackDAO {
	
	@Autowired
	private JdbcTemplate jdbc;

	@Override
	public int addQuestion(FeedbackQuestions q) {
		jdbc.update("INSERT INTO feedback_questions (session_id, question_text, question_type) VALUES (?,?,?)",
                q.getSessionId(), q.getQuestionText(), q.getQuestionType());
        int questionId = jdbc.queryForObject("SELECT LAST_INSERT_ID()", Integer.class);

        if ("multiple".equals(q.getQuestionType()) && q.getOptions() != null) {
            for (String opt : q.getOptions()) {
                if (opt != null && !opt.trim().isEmpty()) {
                    jdbc.update("INSERT INTO feedback_options (question_id, option_text) VALUES (?,?)",
                            questionId, opt.trim());
                }
            }
        }
        return questionId;
	}

	@Override
	public List<FeedbackQuestions> findQuestionsBySession(int sessionId) {
		List<FeedbackQuestions> questions = jdbc.query(
                "SELECT * FROM feedback_questions WHERE session_id=?",
                (rs, n) -> {
                    FeedbackQuestions q = new FeedbackQuestions();
                    q.setId(rs.getInt("id"));
                    q.setSessionId(rs.getInt("session_id"));
                    q.setQuestionText(rs.getString("question_text"));
                    q.setQuestionType(rs.getString("question_type"));
                    return q;
                }, sessionId);

        // attach options for MCQ
        if (!questions.isEmpty()) {
            List<Integer> ids = new ArrayList<>();
            for (FeedbackQuestions q : questions) ids.add(q.getId());
            String inClause = String.join(",", Collections.nCopies(ids.size(), "?"));

            Map<Integer, List<String>> optMap = new HashMap<>();
            jdbc.query("SELECT question_id, option_text FROM feedback_options WHERE question_id IN (" + inClause + ")",
                    rs -> {
                        int qid = rs.getInt("question_id");
                        optMap.computeIfAbsent(qid, k -> new ArrayList<>()).add(rs.getString("option_text"));
                    }, ids.toArray());

            for (FeedbackQuestions q : questions) {
                q.setOptions(optMap.getOrDefault(q.getId(), Collections.emptyList()));
            }
        }
        return questions;
	}

	@Override
	public void deleteQuestion(int questionId) {
        jdbc.update("DELETE FROM feedback_questions WHERE id=?", questionId);
		
	}
	
	
}
