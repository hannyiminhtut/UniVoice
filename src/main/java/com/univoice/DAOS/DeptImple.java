package com.univoice.DAOS;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.univoice.models.Department;

@Repository
public class DeptImple implements DeptDAO {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Override
	public void saveDept(Department dept) {
		
		String sql = "INSERT INTO departments (name, email, password) VALUES (?, ?, ?)";
	    jdbcTemplate.update(sql, dept.getName(), dept.getEmail(), dept.getPassword());
		
	}

	@Override
	public int getTotalDept() {
		
		String sql = "SELECT count(*) FROM departments";
		return jdbcTemplate.queryForObject(sql, Integer.class);
	}

	@Override
	public List<Department> getAllDepartments() {
		
		String sql = "SELECT id, name FROM departments";
	    return jdbcTemplate.query(sql, (rs, rowNum) -> {
	        Department dept = new Department();
	        dept.setId(rs.getInt("id"));
	        dept.setName(rs.getString("name"));
	        return dept;
	    });
	}

	@Override
	public void issueAssignToDept(int issueId, int deptId) {
		
		String sql = "Update issues SET dept_id=?, status='assigned' WHERE issue_id=?";
		jdbcTemplate.update(sql, deptId, issueId);
	}

}
