package com.univoice.DAOS;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
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
	                s.setDeadline_date(rs.getString("deadline_date"));
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
		                s.setDeadline_date(rs.getString("deadline_date"));
		                s.setPublished(rs.getBoolean("published"));
		                s.setCreated_at(rs.getString("created_at"));
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

	@Override
	public boolean hasPendingFeedback(int studentId) {
		String sql = """
		        SELECT COUNT(*) 
		        FROM feedback_sessions fs
		        WHERE fs.published = true
		          AND fs.id NOT IN (
		              SELECT fr.session_id 
		              FROM feedback_responses fr 
		              WHERE fr.student_id = ?
		          )
		        """;
		    Integer count = jdbc.queryForObject(sql, Integer.class, studentId);
		    return count != null && count > 0;
	}

	@Override
	public List<FeedbackSession> getPendingSessionsForStudent(int studentId) {
	    String sql = """
	            SELECT fs.* 
	            FROM feedback_sessions fs
	            WHERE fs.published = 1
	            AND NOT EXISTS (
	                SELECT 1 FROM feedback_responses fr 
	                WHERE fr.session_id = fs.id AND fr.student_id = ?
	            )
	        """;

	    return jdbc.query(
	        sql,
	        new Object[]{studentId},
	        new BeanPropertyRowMapper<>(FeedbackSession.class)
	    );
	}
	
	@Override
	public int saveFeedbackResponse(int sessionId, int studentId) {
	    String sql = "INSERT INTO feedback_responses (session_id, student_id) VALUES (?, ?)";
	    jdbc.update(sql, sessionId, studentId);

	    // Get the auto-increment ID of last insert
	    Integer id = jdbc.queryForObject("SELECT LAST_INSERT_ID()", Integer.class);
	    return id;
	}

	@Override
	public int getTotal() {
		
		String sql = "SELECT count(*) FROM feedback_sessions";
		return jdbc.queryForObject(sql, Integer.class);
		
	}

	@Override
	public int deleteSession(int id) {
		final String sql = "DELETE FROM feedback_sessions WHERE id = ?";
	    return jdbc.update(sql, id);
	}


	

}
