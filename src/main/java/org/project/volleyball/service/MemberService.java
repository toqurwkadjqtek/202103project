package org.project.volleyball.service;

import java.util.Map;

import org.project.volleyball.dto.MemberDTO;

public interface MemberService {

	public Map<String,Object> insert(MemberDTO mdto) throws Exception; //가입
	public Map<String,String> idCheck(String userid) throws Exception; //아이디 중복체크
	public Map<String,String> nickCheck(String nickname) throws Exception; //이메일 중복체크
	public Map<String,Object> updateEmailAuth(String userid) throws Exception; //이메일인증
	public MemberDTO selectOne(String userid) throws Exception; //회원한명조회
	public Map<String,Object> update(MemberDTO mdto) throws Exception; //회원수정
	public Map<String,Object> delete(String userid) throws Exception;

}
