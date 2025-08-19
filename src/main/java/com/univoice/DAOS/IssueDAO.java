package com.univoice.DAOS;

import java.util.List;

import com.univoice.models.Issue;

public interface IssueDAO {
	
	List<Issue> getAllIssues();
	
	Issue getIssueById(int issueId);

}
