package org.project.volleyball.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.project.volleyball.dto.VleagueDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class VleagueDAOImpl implements VleagueDAO{
	private static final Logger logger = LoggerFactory.getLogger(VleagueDAOImpl.class);
	
	@Autowired
	private SqlSession session;

	@Override
	public List<VleagueDTO> selectList(VleagueDTO vdto) throws Exception {
		logger.info(vdto.toString());
		return session.selectList("org.project.volleyball.VleagueMapper.selectList",vdto);
	}

	@Override
	public VleagueDTO selectOne(VleagueDTO vdto) throws Exception {
		return session.selectOne("org.project.volleyball.VleagueMapper.selectOne",vdto);
	}

}
