package com.univoice.DAOS;

import java.util.List;

import com.univoice.models.Department;

public interface DeptDAO {
	
	void saveDept(Department dept);
	
	int getTotalDept();
	
	List<Department> getAllDepartments();
	
	void issueAssignToDept(int issueId,int deptId);
	
	String getNameById(int id);
	
	Department findbyEmailandPassword(String email,String password);
	
	int updateProfileImage(int deptId,String imagePath);
	
	Department findbyId(int iD);
	
	int update(Department dept);
	
	int deleteDept(int id);

}
