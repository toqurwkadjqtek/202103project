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
public class MemberServiceImpl implements MemberService{
	private static final Logger logger = LoggerFactory.getLogger(MemberServiceImpl.class);
	
	@Autowired
	private MemberDAO mdao;
	
	@Autowired
	private BCryptPasswordEncoder bcryptEncoder;
	
	@Autowired
	private FileService fservice;
	
	@Autowired
	private MailSendService mailservice;

	@Override
	public Map<String,Object> insert(MemberDTO mdto) throws Exception {
		logger.info(mdto.toString());
		mdto.setPasswd(bcryptEncoder.encode(mdto.getPasswd())); //암호화
		mdto.setFilename(fservice.fileUpload(mdto.getImgfile())); //파일처리
		logger.info(mdto.toString());
		int cnt=mdao.insert(mdto);
		Map<String,Object> resultMap=new HashMap<>();
		resultMap.put("cnt",cnt);
		if(cnt==1) {
			String authKey=mailservice.sendAuthMail(mdto.getNickname(),mdto.getUserid()); //이메일전송
			logger.info(authKey);
			resultMap.put("authKey",authKey);
			resultMap.put("msg","가입이 완료되었습니다");
			
		}else {
			resultMap.put("msg","가입 실패");
		}
		return resultMap;
	}

	@Override
	public Map<String,String> idCheck(String userid) throws Exception {
		Map<String,String> resultMap=new HashMap<>();
		//만약에 userid가 존재한다면
		if(mdao.selectOne(userid)!=null) {
			resultMap.put("msg","사용할 수 없는 아이디입니다");
			resultMap.put("yn","");
		}else {
			resultMap.put("msg","사용 가능한 아이디입니다");
			resultMap.put("yn","y");
		}
		return resultMap;
	}
	
	@Override
	public Map<String,String> nickCheck(String nickname) throws Exception {
		Map<String,String> resultMap=new HashMap<>();
		//만약에 userid가 존재한다면
		if(mdao.selectOneNickname(nickname)!=null) {
			resultMap.put("msg","사용할 수 없는 닉네임입니다");
			resultMap.put("yn","");
		}else {
			resultMap.put("msg","사용 가능한 닉네임입니다");
			resultMap.put("yn","y");
		}
		return resultMap;
	}

	@Override
	public Map<String,Object> updateEmailAuth(String userid) throws Exception {
		Map<String,Object> resultMap=new HashMap<>();
		MemberDTO mdto=mdao.selectOne(userid);
		if(mdto.getEmailauth().equals("1")) {
			resultMap.put("cnt",-1);
			resultMap.put("msg","이미 인증된 아이디입니다");
		}else {
			int cnt=mdao.updateEmailAuth(userid);
			resultMap.put("cnt",cnt);
			if(cnt==1) {
				resultMap.put("msg","인증이 완료되었습니다");
			}else {
				resultMap.put("msg","인증 실패");
			}
		}
		return resultMap;
	}

	@Override
	public MemberDTO selectOne(String userid) throws Exception {
		return mdao.selectOne(userid);
	}

	@Override
	public Map<String, Object> update(MemberDTO mdto) throws Exception {
		Map<String,Object> resultMap=new HashMap<>();
		MemberDTO dbdto=mdao.selectOne(mdto.getUserid());
		String filename="";
		logger.info(dbdto.toString());
		if(mdto.getPasswd().equals("")) {
			mdto.setPasswd(dbdto.getPasswd());
		}else {
			mdto.setPasswd(bcryptEncoder.encode(mdto.getPasswd()));
		}
		if(!mdto.getImgfile().isEmpty()) {
			filename=fservice.fileUpload(mdto.getImgfile());
		}else {
			filename=dbdto.getFilename();
		}
		mdto.setFilename(filename);
		int cnt=mdao.update(mdto);
		resultMap.put("cnt",cnt);
		if(cnt==1) {
			resultMap.put("msg","수정되었습니다");
		}else {
			resultMap.put("msg","수정 실패");
		}
		return resultMap;
	}

	@Override
	public Map<String, Object> delete(String userid) throws Exception {
		Map<String,Object> resultMap=new HashMap<>();
		int cnt=mdao.delete(userid);
		resultMap.put("cnt",cnt);
		if(cnt==1) {
			resultMap.put("msg","탈퇴가 완료되었습니다");
		}else {
			resultMap.put("msg","탈퇴 실패");
		}
		return resultMap;
	}

}
