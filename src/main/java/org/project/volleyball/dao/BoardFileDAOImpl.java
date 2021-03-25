package org.project.volleyball.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.project.volleyball.dto.BoardFileDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BoardFileDAOImpl implements BoardFileDAO{
	
	@Autowired
	private SqlSession session;
	
	@Override
	public int insert(BoardFileDTO bfdto) throws Exception {
		return session.insert("org.project.volleyball.BoardFileMapper.insert",bfdto);
	}

	@Override
	public List<BoardFileDTO> selectList(int bnum) throws Exception {
		return session.selectList("org.project.volleyball.BoardFileMapper.selectList",bnum);
	}

	@Override
	public BoardFileDTO selectOne(int fnum) throws Exception {
		return session.selectOne("org.project.volleyball.BoardFileMapper.selectOne",fnum);
	}

	@Override
	public int delete(int fnum) throws Exception {
		return session.delete("org.project.volleyball.BoardFileMapper.delete",fnum);
	}

	@Override
	public int deleteBoard(int bnum) throws Exception {
		return session.delete("org.project.volleyball.BoardFileMapper.deleteBoard",bnum);
	}

}
