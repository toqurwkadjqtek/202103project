package org.project.volleyball.service;

import java.util.HashMap;
import java.util.Map;

import org.project.volleyball.dao.MemberDAO;
import org.project.volleyball.dto.MemberDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class LoginServiceImpl implements LoginService{
	private static final Logger logger = LoggerFactory.getLogger(LoginServiceImpl.class);
	
	@Autowired
	private MemberDAO mdao;
	
	@Autowired
	private BCryptPasswordEncoder bcryptEncoder;
	
	@Override
	public Map<String, Object> login(String userid, String passwd) throws Exception {
		Map<String,Object> resultMap=new HashMap<>();
		MemberDTO mdto=mdao.selectOne(userid);
		//아이디 존재여부
		if(mdto==null) {
			resultMap.put("result",-1);
			resultMap.put("msg","아이디가 존재하지 않습니다");
			return resultMap;
		}
		
		//비밀번호 일치여부
		if(!bcryptEncoder.matches(passwd,mdto.getPasswd())) {
			resultMap.put("result",0);
			resultMap.put("msg","비밀번호가 일치하지 않습니다");
			return resultMap;
		}
		
		//이메일 인증여부
		if(!mdto.getEmailauth().equals("1")) {
			resultMap.put("result",-2);
			resultMap.put("msg","인증되지 않은 회원입니다");
			return resultMap;
		}
		
		//로그인 성공
		resultMap.put("result",1);

		return resultMap;
	}

}
