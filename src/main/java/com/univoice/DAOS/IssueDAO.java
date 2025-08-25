package com.univoice.DAOS;

import java.util.List;

import com.univoice.models.Issue;

public interface IssueDAO {
	
	List<Issue> getAllIssues();
	
	Issue getIssueById(int issueId);
	
	List<Issue> findIssuesByDeptId(int id);
	
	String getDeptNameByIssueId(int issue_id);
	
	int updateNote(int iD,String note);
	
	int updateStatus(int solveId);
	
	int updateNoteRead(int noteId);
	
	int markIssueAsRead(int issueID);

}
