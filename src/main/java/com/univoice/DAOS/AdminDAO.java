package com.univoice.DAOS;

import com.univoice.models.Admin;

public interface AdminDAO {
	
	Admin findbyEmailandPassword(String email,String password);

}
