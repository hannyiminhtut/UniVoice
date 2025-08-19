package com.univoice.DAOS;

import com.univoice.models.Issue;
import com.univoice.models.Student;

public interface StudentDAO {
	
	void saveStudent(Student student);
	
	Student findbyEmailandPassword(String email,String password);
	
	int getTotalStud();
	
	void sendIssue(Issue issue);

}
