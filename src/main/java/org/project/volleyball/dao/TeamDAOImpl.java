package org.project.volleyball.dao;

import org.apache.ibatis.session.SqlSession;
import org.project.volleyball.dto.TeamDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TeamDAOImpl implements TeamDAO{
	
	@Autowired
	private SqlSession session;

	@Override
	public TeamDTO selectOne(String tcode) throws Exception {
		return session.selectOne("org.project.volleyball.TeamMapper.selectOne",tcode);
	}

}
