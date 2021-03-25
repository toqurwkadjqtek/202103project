package org.project.volleyball.dao;

import org.project.volleyball.dto.TeamDTO;

public interface TeamDAO {
	public TeamDTO selectOne(String tcode) throws Exception;

}
