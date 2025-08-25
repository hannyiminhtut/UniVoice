package com.univoice.DAOS;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.univoice.models.FeedbackSession;

@Repository
public class FeedbackSessionImple implements FeedbackSessionDAO {
	

	@Autowired
	private JdbcTemplate jdbc;

	

	@Override
	public FeedbackSession findById(int id) {
		return jdbc.queryForObject(
	            "SELECT * FROM feedback_sessions WHERE id=?",
	            (rs, n) -> {
	                FeedbackSession s = new FeedbackSession();
	                s.setId(rs.getInt("id"));
	                s.setTitle(rs.getString("title"));
	                s.setDeadlineDate(rs.getString("deadline_date"));
	                s.setPublished(rs.getBoolean("published"));
	                return s;
	            }, id
	        );
	}

	@Override
	public void publish(int id) {
		jdbc.update("UPDATE feedback_sessions SET published=1 WHERE id=?", id);
		
	}

	@Override
	public List<FeedbackSession> findAll() {
		 return jdbc.query("SELECT * FROM feedback_sessions ORDER BY created_at DESC",
		            (rs, n) -> {
		                FeedbackSession s = new FeedbackSession();
		                s.setId(rs.getInt("id"));
		                s.setTitle(rs.getString("title"));
		                s.setDeadlineDate(rs.getString("deadline_date"));
		                s.setPublished(rs.getBoolean("published"));
		                return s;
		            });
	}

	@Override
	public int createSession(String title, String deadlineDate) {
		// 1. Check if session already exists
        String checkSql = "SELECT id FROM feedback_sessions WHERE title = ? AND deadline_date = ?";
        List<Integer> existing = jdbc.query(checkSql, 
            new Object[]{title, deadlineDate},
            (rs, rowNum) -> rs.getInt("id"));

        if (!existing.isEmpty()) {
            // ✅ Reuse existing session ID
            return existing.get(0);
        }

        // 2. Insert new session only if not exists
        String insertSql = "INSERT INTO feedback_sessions (title, deadline_date, published, created_at) VALUES (?, ?, 0, NOW())";
        jdbc.update(insertSql, title, deadlineDate);

        // 3. Return generated ID
        return jdbc.queryForObject("SELECT LAST_INSERT_ID()", Integer.class);
	}

}
