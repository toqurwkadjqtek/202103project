package org.project.volleyball.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.project.volleyball.dto.ReplyDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReplyDAOImpl implements ReplyDAO{
	
	@Autowired
	private SqlSession session;
	
	@Override
	public void insert(ReplyDTO rdto) throws Exception{
		session.insert("org.project.volleyball.ReplyMapper.insert",rdto);
	}

	@Override
	public void updateRestep(ReplyDTO rdto) throws Exception {
		session.update("org.project.volleyball.ReplyMapper.updateRestep",rdto);
	}

	@Override
	public List<ReplyDTO> selectList(int bnum) throws Exception {
		return session.selectList("org.project.volleyball.ReplyMapper.selectList",bnum);
	}

	@Override
	public void update(ReplyDTO rdto) throws Exception {
		session.update("org.project.volleyball.ReplyMapper.update",rdto);
	}

	@Override
	public void delete(int rnum) throws Exception {
		session.delete("org.project.volleyball.ReplyMapper.delete",rnum);
	}

	@Override
	public ReplyDTO selectOne(int rnum) throws Exception {
		return session.selectOne("org.project.volleyball.ReplyMapper.selectOne",rnum);
	}
	
	@Override
	public int selectReplyCnt(ReplyDTO rdto) throws Exception {
		return session.selectOne("org.project.volleyball.ReplyMapper.selectReplyCnt",rdto);
	}

	@Override
	public void deleteBoard(int bnum) throws Exception {
		session.delete("org.project.volleyball.ReplyMapper.deleteBoard",bnum);
	}
	
	@Override
	public int updateLikecnt(int rnum) throws Exception {
		return session.update("org.project.volleyball.ReplyMapper.updateLikecnt",rnum);
	}

	@Override
	public int updateDisLikecnt(int rnum) throws Exception {
		return session.update("org.project.volleyball.ReplyMapper.updateDisLikecnt",rnum);
	}

	@Override
	public int updateLikecntMinus(int rnum) throws Exception {
		return session.update("org.project.volleyball.ReplyMapper.updateLikecntMinus",rnum);
	}

	@Override
	public int updateDisLikecntMinus(int rnum) throws Exception {
		return session.update("org.project.volleyball.ReplyMapper.updateDisLikecntMinus",rnum);
	}
}
