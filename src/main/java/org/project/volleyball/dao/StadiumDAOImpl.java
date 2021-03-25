package org.project.volleyball.dao;

import org.apache.ibatis.session.SqlSession;
import org.project.volleyball.dto.StadiumDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class StadiumDAOImpl implements StadiumDAO{
	
	@Autowired
	public SqlSession session;

	@Override
	public StadiumDTO selectOne(String scode) throws Exception {
		return session.selectOne("org.project.volleyball.StadiumMapper.selectOne",scode);
	}
	

}
