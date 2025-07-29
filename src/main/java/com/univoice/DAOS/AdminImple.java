package com.univoice.DAOS;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.univoice.models.Admin;



@Repository
public class AdminImple implements AdminDAO {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Override
	public Admin findbyEmailandPassword(String email, String password) {
		String sql = "SELECT * FROM admin WHERE email = ? AND password = ?";
        List<Admin> list = jdbcTemplate.query(sql, (rs, rowNum) -> {
            Admin a = new Admin();
            a.setId(rs.getInt("id"));
            a.setName(rs.getString("name"));
            a.setEmail(rs.getString("email"));
            a.setPassword(rs.getString("password"));
            return a;
        }, email, password);
        return list.isEmpty() ? null : list.get(0);
    }
	

	

}
