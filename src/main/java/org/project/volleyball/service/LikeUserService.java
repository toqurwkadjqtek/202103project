package org.project.volleyball.service;

import org.project.volleyball.dto.LikeUserDTO;

public interface LikeUserService {
	//type
	//1.게시물조회
	//2.게시물좋아요
	//3.게시물싫어요
	//4.댓글좋아요
	//5.댓글싫어요
	public int insert(int type,int num,String userid) throws Exception;
	public LikeUserDTO selectOne(int type,int num,String userid) throws Exception;
	public int delete(int type,int num,String userid) throws Exception;
	public int deleteBoardReply(String gubun,int num) throws Exception;

}
