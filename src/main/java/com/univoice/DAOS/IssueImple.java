package com.univoice.DAOS;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.univoice.models.Issue;

@Repository
public class IssueImple implements IssueDAO {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Override
	public List<Issue> getAllIssues() {
		
		String sql = "SELECT issue_id, title, created_at,status FROM issues  ORDER BY created_at DESC";

        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            Issue i = new Issue();
            i.setIssue_id(rs.getInt("issue_id"));
            i.setTitle(rs.getString("title"));
            i.setCreated_at(rs.getString("created_at"));
            i.setStatus(rs.getString("status"));
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
            return i;
        }, issueId);
		
	}

}
