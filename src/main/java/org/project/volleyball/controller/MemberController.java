package org.project.volleyball.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.project.volleyball.dto.MemberDTO;
import org.project.volleyball.service.MemberService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/member")
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService mservice;
	
	//가입폼으로
	@RequestMapping(value="add",method=RequestMethod.GET)
	public String add() {
		return "/member/add";
	}
	
	//가입
	@RequestMapping(value="add",method=RequestMethod.POST)
	public String add(MemberDTO mdto,RedirectAttributes rdAtt,HttpSession session) throws Exception {
		logger.info(mdto.toString());
		Map<String,Object> resultMap=mservice.insert(mdto);
		if((Integer)resultMap.get("cnt")==1) {
			session.setAttribute(mdto.getUserid(),resultMap.get("authKey")); //인증키 세션에 넣기(key:이메일,value:인증키)
			session.setMaxInactiveInterval(30*60);
			rdAtt.addFlashAttribute("msg",resultMap.get("msg"));
			return "redirect:/"; //절대경로
		}else {
			return "redirect:/member/add";
		}
		
	}
	
	//아이디 중복체크
	@ResponseBody
	@RequestMapping(value="idCheck",method=RequestMethod.POST)
	public Map<String, String> idCheck(String userid) throws Exception {
		logger.info(userid);
		Map<String,String> resultMap=mservice.idCheck(userid);
		//jackson-databind: map이나 dto,list를 json형태로 변환
		return resultMap;
	}
	
	//닉네임 중복체크
	@ResponseBody
	@RequestMapping(value="nickCheck",method=RequestMethod.POST)
	public Map<String, String> nickCheck(String nickname) throws Exception {
		logger.info(nickname);
		Map<String,String> resultMap=mservice.nickCheck(nickname);
		//jackson-databind: map이나 dto,list를 json형태로 변환
		return resultMap;
	}
	
	//주소찾기폼으로
	@RequestMapping(value="jusoPopup")
	public String jusoPopup() {
		return "/member/jusoPopup";
	}
	
	//이메일에서 인증 클릭했을 때
	@RequestMapping("signUpConfirm")
	public String signUpConfirm(@RequestParam Map<String,String> map,RedirectAttributes rdAtt,HttpSession session) throws Exception {
		//이메일,인증키가 일치할 경우 emailauth 업데이트
		logger.info(map.toString());
		//세션: 1)java:123456 2)hong:123457
		String sessionAuthKey=(String)session.getAttribute(map.get("userid")); //세션에 저장된 인증키
		if(sessionAuthKey==null) { //인증 세션이 종료되어 key 사라짐
			logger.info("인증만료");
			rdAtt.addFlashAttribute("msg","인증이 만료되었습니다");
			return "redirect:/member/add";
		}
		logger.info(sessionAuthKey);
		if(sessionAuthKey.equals(map.get("authKey"))) {
			Map<String,Object> resultMap=mservice.updateEmailAuth(map.get("userid"));
			rdAtt.addFlashAttribute("msg",resultMap.get("msg"));
			logger.info(resultMap.get("msg").toString());
		}else {
			rdAtt.addFlashAttribute("msg","인증키가 일치하지 않습니다");
		}
		//redirect는 주소 변경
		return "redirect:/";
	}
	
	//내정보
	@ResponseBody
	@RequestMapping(value="info",method=RequestMethod.GET)
	public MemberDTO info(HttpSession session,Model model) throws Exception {
		String userid=(String)session.getAttribute("userid");
		MemberDTO mdto=mservice.selectOne(userid);
		return mdto;
	}
	
	//수정폼으로
	@RequestMapping(value="modify",method=RequestMethod.GET)
	public String modify(HttpSession session,Model model) throws Exception {
		String userid=(String)session.getAttribute("userid");
		MemberDTO mdto=mservice.selectOne(userid);
		model.addAttribute("mdto",mdto);
		return "/member/modify";
	}
	
	@RequestMapping(value="modify",method=RequestMethod.POST)
	public String modify(MemberDTO mdto,RedirectAttributes rdAtt,HttpSession session) throws Exception {
		logger.info(mdto.toString());
		session.setAttribute("userid",mdto.getUserid());
		MemberDTO dbdto=mservice.selectOne(mdto.getUserid());
		session.setAttribute("nickname",dbdto.getNickname());
		Map<String,Object> resultMap=mservice.update(mdto);
		//rdAtt.addFlashAttribute("msg",resultMap.get("msg"));
		if((Integer)resultMap.get("cnt")==1) {
			session.setAttribute("nickname",mdto.getNickname());
			return "redirect:/";
		}
		return "redirect:/member/modify";
	}
	
	@ResponseBody
	@RequestMapping(value="reSession")
	public String reSession(String userid,HttpSession session) throws Exception {
		MemberDTO mdto=mservice.selectOne(userid);
		session.setAttribute("userid",userid);
		session.setAttribute("nickname",mdto.getNickname());
		return "success";
	}
	
	@RequestMapping(value="delete")
	public String delete(HttpSession session,RedirectAttributes rdAtt) throws Exception {
		String userid=(String)session.getAttribute("userid");
		Map<String,Object> resultMap=mservice.delete(userid);
		//rdAtt.addFlashAttribute("msg",resultMap.get("msg"));
		if((Integer)resultMap.get("cnt")==1) {
			session.invalidate();
		}
		return "redirect:/";
	}

}
