package org.project.volleyball.dao;

import java.util.List;

import org.project.volleyball.dto.ReplyDTO;

public interface ReplyDAO {

	public void insert(ReplyDTO rdto) throws Exception;
	public void updateRestep(ReplyDTO rdto) throws Exception;
	public List<ReplyDTO> selectList(int bnum) throws Exception;
	public void update(ReplyDTO rdto) throws Exception;
	public void delete(int rnum) throws Exception;
	public void deleteBoard(int bnum) throws Exception;
	public ReplyDTO selectOne(int rnum) throws Exception;
	public int selectReplyCnt(ReplyDTO rdto) throws Exception;
	public int updateLikecnt(int rnum) throws Exception;
	public int updateDisLikecnt(int rnum) throws Exception;
	public int updateLikecntMinus(int rnum) throws Exception;
	public int updateDisLikecntMinus(int rnum) throws Exception;

}
