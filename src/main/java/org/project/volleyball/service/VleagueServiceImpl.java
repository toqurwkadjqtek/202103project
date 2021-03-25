package org.project.volleyball.service;

import java.util.List;

import org.project.volleyball.dao.VleagueDAO;
import org.project.volleyball.dto.VleagueDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class VleagueServiceImpl implements VleagueService{
	private static final Logger logger = LoggerFactory.getLogger(VleagueServiceImpl.class);
	
	@Autowired
	private VleagueDAO vdao;

	@Override
	public List<VleagueDTO> selectList(VleagueDTO vdto) throws Exception {
		logger.info(vdto.toString());
		return vdao.selectList(vdto);
	}

	@Override
	public VleagueDTO selectOne(VleagueDTO vdto) throws Exception {
		return vdao.selectOne(vdto);
	}
	
}
