package org.project.volleyball.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.project.volleyball.dto.MemberDTO;
import org.project.volleyball.service.LoginService;
import org.project.volleyball.service.MemberService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class LoginController {
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	private LoginService lservice;
	
	@Autowired
	private MemberService mservice;
	
	@RequestMapping(value="login",method=RequestMethod.POST)
	public String login(String userid,String passwd,RedirectAttributes rdAtt,HttpSession session) throws Exception {
		logger.info(userid);
		logger.info(passwd);
		Map<String,Object> resultMap=lservice.login(userid,passwd);
		rdAtt.addFlashAttribute("msg",resultMap.get("msg"));
		if((Integer)resultMap.get("result")==1) {
			MemberDTO mdto=mservice.selectOne(userid);
			session.setAttribute("userid",userid);
			session.setAttribute("nickname",mdto.getNickname());
			session.setMaxInactiveInterval(120*60);
		}
		return "redirect:/";
	}
	
	@RequestMapping("logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}

}
