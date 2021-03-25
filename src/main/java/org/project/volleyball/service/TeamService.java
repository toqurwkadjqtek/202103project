package org.project.volleyball.service;

import org.project.volleyball.dto.TeamDTO;

public interface TeamService {
	public TeamDTO selectOne(String tcode) throws Exception;

}
