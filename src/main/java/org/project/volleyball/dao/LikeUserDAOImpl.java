package org.project.volleyball.dao;

import org.apache.ibatis.session.SqlSession;
import org.project.volleyball.dto.LikeUserDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LikeUserDAOImpl implements LikeUserDAO{
	
	@Autowired
	private SqlSession session;

	@Override
	public int insert(LikeUserDTO ludto) throws Exception {
		return session.insert("org.project.volleyball.LikeUserMapper.insert",ludto);
	}

	@Override
	public LikeUserDTO selectOne(LikeUserDTO ludto) throws Exception {
		return session.selectOne("org.project.volleyball.LikeUserMapper.selectUser",ludto);
	}

	@Override
	public int delete(LikeUserDTO ludto) throws Exception {
		return session.delete("org.project.volleyball.LikeUserMapper.delete",ludto);
	}
	
	@Override
	public int deleteBoardReply(LikeUserDTO ludto) throws Exception {
		return session.delete("org.project.volleyball.LikeUserMapper.deleteBoardReply",ludto);
	}

}
