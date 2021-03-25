package org.project.volleyball.dao;

import java.util.List;

import org.project.volleyball.dto.VleagueDTO;

public interface VleagueDAO {
	public List<VleagueDTO> selectList(VleagueDTO vdto) throws Exception;
	public VleagueDTO selectOne(VleagueDTO vdto) throws Exception;

}
