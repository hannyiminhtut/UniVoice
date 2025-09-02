package com.univoice.DAOS;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.univoice.models.Department;
import com.univoice.models.Issue;
import com.univoice.models.Student;

@Repository
public class StudentImple implements StudentDAO {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Override
	public void saveStudent(Student student) {
		
		 String sql = "INSERT INTO students (name, email, password) VALUES (?, ?, ?)";
	     jdbcTemplate.update(sql, student.getName(), student.getEmail(), student.getPassword());
		
		
	}

	@Override
	public Student findbyEmailandPassword(String email, String password) {
		String sql = "SELECT * FROM students WHERE email = ? AND password = ?";
        List<Student> list = jdbcTemplate.query(sql, (rs, rowNum) -> {
            Student s = new Student();
            s.setUser_id(rs.getInt("student_id"));
            s.setName(rs.getString("name"));
            s.setEmail(rs.getString("email"));
            s.setPassword(rs.getString("password"));
            s.setImage(rs.getString("image"));
            return s;
        }, email, password);
        return list.isEmpty() ? null : list.get(0);
    }

	@Override
	public int getTotalStud() {
		String sql = "SELECT count(*) FROM students";
		return jdbcTemplate.queryForObject(sql, Integer.class);
	}

	@Override
	public void sendIssue(Issue issue) {
	    String sql = "INSERT INTO issues (title, description, img, student_id, location) VALUES (?, ?, ?, ?,?)";
	    jdbcTemplate.update(
	        sql,
	        issue.getTitle(),
	        issue.getDescription(),
	        issue.getImg(),
	        issue.getStudent_id(),
	        issue.getLocation()
	        
	    );
	}

	@Override
	public List<Student> getAllStudents() {
		String sql = "SELECT * FROM students";
		return jdbcTemplate.query(sql, (rs, rowNum) -> {
	        Student stud = new Student();
	        stud.setUser_id(rs.getInt("student_id"));
	        stud.setName(rs.getString("name"));
	        stud.setPassword(rs.getString("password"));
	        stud.setImage(rs.getString("image"));
	        stud.setEmail(rs.getString("email"));
	        return stud;
	    });
		
	}

	@Override
	public Student findById(int id) {
		String sql = "SELECT * FROM students WHERE student_id=? ";
		List<Student> list = jdbcTemplate.query(sql, (rs, rowNum) -> {
            Student s = new Student();
            s.setUser_id(rs.getInt("student_id"));
            s.setName(rs.getString("name"));
            s.setEmail(rs.getString("email"));
            s.setPassword(rs.getString("password"));
            s.setImage(rs.getString("image"));
            return s;
        }, id);
        return list.isEmpty() ? null : list.get(0);
	}

	@Override
	public int updateProfile(Student student) {
		final String sql =
	            "UPDATE students SET name = ?, email = ?, password = ?, image = ? WHERE student_id = ?";
	        return jdbcTemplate.update(sql,
	                student.getName(),
	                student.getEmail(),
	                student.getPassword(),
	                student.getImage(),
	                student.getUser_id());
	}
	
	 @Override
	    public int updateProfileWithoutPassword(Student s) {
	        final String sql =
	            "UPDATE students SET name = ?, email = ?, image = ? WHERE student_id = ?";
	        return jdbcTemplate.update(sql,
	                s.getName(), s.getEmail(), s.getImage(), s.getUser_id());
	    }



}
