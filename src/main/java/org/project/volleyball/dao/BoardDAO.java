package org.project.volleyball.dao;

import java.util.List;

import org.project.volleyball.dto.BoardDTO;
import org.project.volleyball.dto.PageDTO;

public interface BoardDAO {

	public List<BoardDTO> selectList(PageDTO pdto) throws Exception;
	public BoardDTO selectOne(int bnum) throws Exception;
	public int insert(BoardDTO bdto) throws Exception;
	public int update(BoardDTO bdto) throws Exception;
	public int delete(int bnum) throws Exception;
	public int updateReadcount(int bnum) throws Exception; //조회수+1
	public int updateLikecnt(int bnum) throws Exception; //좋아요+1
	public int updateDisLikecnt(int bnum) throws Exception; //싫어요+1
	public int updateLikecntMinus(int bnum) throws Exception; //좋아요-1
	public int updateDisLikecntMinus(int bnum) throws Exception; //싫어요-1
	public int selectTotCnt(PageDTO pdto);

}
