package org.project.volleyball.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.project.volleyball.dto.BoardDTO;
import org.project.volleyball.dto.PageDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDAOImpl implements BoardDAO{
	
	@Autowired
	private SqlSession session;
	
	@Override
	public List<BoardDTO> selectList(PageDTO pdto) throws Exception {
		return session.selectList("org.project.volleyball.BoardMapper.selectList",pdto);
	}
	
	@Override
	public BoardDTO selectOne(int bnum) throws Exception {
		return session.selectOne("org.project.volleyball.BoardMapper.selectOne",bnum);
	}
	
	@Override
	public int insert(BoardDTO bdto) throws Exception {
		return session.insert("org.project.volleyball.BoardMapper.insert",bdto);
	}
	
	@Override
	public int update(BoardDTO bdto) throws Exception {
		return session.update("org.project.volleyball.BoardMapper.update",bdto);
	}
	
	@Override
	public int delete(int bnum) throws Exception {
		return session.delete("org.project.volleyball.BoardMapper.delete",bnum);
	}

	@Override
	public int updateReadcount(int bnum) throws Exception {
		return session.update("org.project.volleyball.BoardMapper.updateReadcount",bnum);
	}

	@Override
	public int updateLikecnt(int bnum) throws Exception {
		return session.update("org.project.volleyball.BoardMapper.updateLikecnt",bnum);
	}

	@Override
	public int updateDisLikecnt(int bnum) throws Exception {
		return session.update("org.project.volleyball.BoardMapper.updateDisLikecnt",bnum);
	}

	@Override
	public int updateLikecntMinus(int bnum) throws Exception {
		return session.update("org.project.volleyball.BoardMapper.updateLikecntMinus",bnum);
	}

	@Override
	public int updateDisLikecntMinus(int bnum) throws Exception {
		return session.update("org.project.volleyball.BoardMapper.updateDisLikecntMinus",bnum);
	}

	@Override
	public int selectTotCnt(PageDTO pdto) {
		return session.selectOne("org.project.volleyball.BoardMapper.selectTotCnt",pdto);
	}

}
