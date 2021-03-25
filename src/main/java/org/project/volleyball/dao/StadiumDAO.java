package org.project.volleyball.dao;

import org.project.volleyball.dto.StadiumDTO;

public interface StadiumDAO {
	public StadiumDTO selectOne(String scode) throws Exception;

}
