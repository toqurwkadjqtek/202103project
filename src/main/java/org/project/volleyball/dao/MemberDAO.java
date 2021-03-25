package org.project.volleyball.dao;

import org.project.volleyball.dto.MemberDTO;

public interface MemberDAO {

	public int insert(MemberDTO mdto) throws Exception;
	public MemberDTO selectOne(String userid) throws Exception;
	public MemberDTO selectOneNickname(String nickname) throws Exception;
	public int updateEmailAuth(String userid) throws Exception;
	public int update(MemberDTO mdto) throws Exception;
	public int delete(String userid) throws Exception;

}
