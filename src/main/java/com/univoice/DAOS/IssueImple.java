package com.univoice.DAOS;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.univoice.models.Issue;

@Repository
public class IssueImple implements IssueDAO {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Override
	public List<Issue> getAllIssues() {
		
		String sql = "SELECT issue_id, title, created_at,status,note,read_note FROM issues  ORDER BY created_at DESC";

        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            Issue i = new Issue();
            i.setIssue_id(rs.getInt("issue_id"));
            i.setTitle(rs.getString("title"));
            i.setCreated_at(rs.getString("created_at"));
            i.setStatus(rs.getString("status"));
            i.setNote(rs.getString("note"));
            i.setNote_read(rs.getBoolean("read_note"));
            return i;
        });
		
	}

	@Override
	public Issue getIssueById(int issueId) {
		String sql = "SELECT * FROM issues WHERE issue_id = ?";
        return jdbcTemplate.queryForObject(sql, (rs, rowNum) -> {
            Issue i = new Issue();
            i.setIssue_id(rs.getInt("issue_id"));
            i.setTitle(rs.getString("title"));
            i.setDescription(rs.getString("description"));
            i.setLocation(rs.getString("location"));
            i.setImg(rs.getString("img"));
            i.setCreated_at(rs.getString("created_at"));
            i.setStatus(rs.getString("status"));
            i.setDept_id(rs.getInt("dept_id"));
            i.setNote(rs.getString("note"));
            return i;
        }, issueId);
		
	}

	

	@Override
	public List<Issue> findIssuesByDeptId(int id) {
	    String sql = "SELECT * FROM issues WHERE dept_id = ?";
	    return jdbcTemplate.query(sql, 
	        new BeanPropertyRowMapper<>(Issue.class), id);
	}

	@Override
	public String getDeptNameByIssueId(int issue_id) {
		 String sql = "SELECT d.name " +
                 "FROM issues i " +
                 "JOIN departments d ON i.dept_id = d.id " +
                 "WHERE i.issue_id = ?";
    try {
        return jdbcTemplate.queryForObject(sql, new Object[]{issue_id}, String.class);
    } catch (EmptyResultDataAccessException e) {
        return null; // or throw custom exception
    }
		
	}

	@Override
	public int updateNote(int iD, String note) {
		
		String sql = "UPDATE issues SET note = ? WHERE issue_id = ?";
	    return jdbcTemplate.update(sql, note, iD);
		
	}

	@Override
	public int updateStatus(int solveId) {
		
		String sql = "UPDATE issues SET status = 'resolved', resolved_at = now() WHERE issue_id = ?";
		return jdbcTemplate.update(sql, solveId);
		
		
	}

	@Override
	public int updateNoteRead(int noteId) {
		
		String sql = "UPDATE issues SET read_note = TRUE WHERE issue_id = ?";
		return jdbcTemplate.update(sql,noteId);
	}

	@Override
	public int markIssueAsRead(int issueID) {

		String sql = "UPDATE issues SET read_dept = TRUE WHERE issue_id = ?";
		return jdbcTemplate.update(sql,issueID);

	}


}
