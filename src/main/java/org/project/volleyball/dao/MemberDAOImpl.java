package org.project.volleyball.dao;

import org.apache.ibatis.session.SqlSession;
import org.project.volleyball.dto.MemberDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAOImpl implements MemberDAO{
	private static final Logger LOGGER = LoggerFactory.getLogger(MemberDAOImpl.class);
	
	@Autowired
	private SqlSession session;

	@Override
	public int insert(MemberDTO mdto) throws Exception {
		return session.insert("org.project.volleyball.MemberMapper.insert",mdto);
	}

	@Override
	public MemberDTO selectOne(String userid) throws Exception {
		return session.selectOne("org.project.volleyball.MemberMapper.selectOne",userid);
	}
	
	@Override
	public MemberDTO selectOneNickname(String nickname) throws Exception {
		return session.selectOne("org.project.volleyball.MemberMapper.selectOneNickname",nickname);
	}

	@Override
	public int updateEmailAuth(String userid) throws Exception {
		return session.update("org.project.volleyball.MemberMapper.updateEmailAuth",userid);
	}

	@Override
	public int update(MemberDTO mdto) throws Exception {
		return session.update("org.project.volleyball.MemberMapper.update",mdto);
	}

	@Override
	public int delete(String userid) throws Exception {
		return session.delete("org.project.volleyball.MemberMapper.delete",userid);
	}
	
}
