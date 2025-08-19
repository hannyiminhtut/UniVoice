package com.univoice.DAOS;

import java.util.List;

import com.univoice.models.Department;

public interface DeptDAO {
	
	void saveDept(Department dept);
	
	int getTotalDept();
	
	List<Department> getAllDepartments();
	
	void issueAssignToDept(int issueId,int deptId);

}
