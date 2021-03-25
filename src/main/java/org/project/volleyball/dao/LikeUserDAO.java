package org.project.volleyball.dao;

import org.project.volleyball.dto.LikeUserDTO;

public interface LikeUserDAO {
	
	public int insert(LikeUserDTO ludto) throws Exception;
	public LikeUserDTO selectOne(LikeUserDTO ludto) throws Exception;
	public int delete(LikeUserDTO ludto) throws Exception;
	public int deleteBoardReply(LikeUserDTO ludto) throws Exception;

}
