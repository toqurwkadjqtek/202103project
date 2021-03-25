package org.project.volleyball.service;

import java.util.List;

import org.project.volleyball.dto.ReplyDTO;

public interface ReplyService {
	public void insert(ReplyDTO rdto) throws Exception;
	public List<ReplyDTO> selectList(int bnum) throws Exception;
	public void update(ReplyDTO rdto) throws Exception;
	public String delete(int rnum) throws Exception;
	public void deleteBoard(int bnum) throws Exception;
	public ReplyDTO selectOne(int rnum) throws Exception;
	public int selectReplyCnt(ReplyDTO rdto) throws Exception;
	public int updateLikecnt(int rnum,String userid) throws Exception;
	public int updateDisLikecnt(int rnum,String userid) throws Exception;

}
