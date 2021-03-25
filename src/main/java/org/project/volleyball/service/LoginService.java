package org.project.volleyball.service;

import java.util.Map;

public interface LoginService {
	public Map<String, Object> login(String userid, String passwd) throws Exception;

}
