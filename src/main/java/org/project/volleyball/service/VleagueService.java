package org.project.volleyball.service;

import java.util.List;

import org.project.volleyball.dto.VleagueDTO;

public interface VleagueService {
	public List<VleagueDTO> selectList(VleagueDTO vdto) throws Exception;
	public VleagueDTO selectOne(VleagueDTO vdto) throws Exception;

}
