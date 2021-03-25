package org.project.volleyball.dao;

import java.util.List;

import org.project.volleyball.dto.BoardFileDTO;

public interface BoardFileDAO {

	public int insert(BoardFileDTO bfdto) throws Exception;
	public List<BoardFileDTO> selectList(int bnum) throws Exception;
	public BoardFileDTO selectOne(int fnum) throws Exception;
	public int delete(int fnum) throws Exception;
	public int deleteBoard(int bnum) throws Exception;

}
