package org.project.volleyball.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.project.volleyball.dto.ReplyDTO;
import org.project.volleyball.service.ReplyService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

//각 메소드의 @ResponseBody 생략
@RestController
@RequestMapping("/reply")
public class ReplyController {
	private static final Logger logger = LoggerFactory.getLogger(ReplyController.class);
	
	@Autowired
	private ReplyService rservice;
	
	//댓글 등록
	@RequestMapping(value="/",method=RequestMethod.POST,produces = "application/text;charset=utf-8")
	public String add(@RequestBody ReplyDTO rdto,HttpServletRequest request,HttpSession session) throws Exception {
		String userid=(String)session.getAttribute("userid");
		String nickname=(String)session.getAttribute("nickname");
		if(userid==null) {
			return "로그인해주세요";
		}
		rdto.setUserid(userid);
		rdto.setNickname(nickname);
		rdto.setIp(request.getRemoteAddr()); //접속ip
		rservice.insert(rdto);
		return "댓글이 등록되었습니다";
	}
	
	//댓글 수정
	@RequestMapping(value="/",method=RequestMethod.PUT,produces = "application/text;charset=utf-8")
	public String modify(@RequestBody ReplyDTO rdto,HttpServletRequest request,HttpSession session) throws Exception {
		String userid=(String)session.getAttribute("userid");
		String nickname=(String)session.getAttribute("nickname");
		if(userid==null||userid.equals(rdto.getUserid())) {
			return "작성하신 댓글이 아닙니다";
		}
		rdto.setNickname(nickname);
		rservice.update(rdto);
		return "success!";
	}
	
	//댓글 삭제
	@RequestMapping(value="/{rnum}",method=RequestMethod.DELETE,produces = "application/text;charset=utf-8")
	public String remove(@PathVariable("rnum") int rnum,HttpSession session) throws Exception {
		String userid=(String)session.getAttribute("userid");
		ReplyDTO rdto=rservice.selectOne(rnum);
		if(userid==null||!userid.equals(rdto.getUserid())) {
			return "작성하신 댓글이 아닙니다";
		}
		return rservice.delete(rnum);
	}
	
	//댓글 리스트
	@RequestMapping(value="/{bnum}",method=RequestMethod.GET)
	public List<ReplyDTO> list(@PathVariable("bnum") int bnum) throws Exception {
		List<ReplyDTO> rlist=rservice.selectList(bnum);
		return rlist;
	}
	
	//좋아요 버튼
	@ResponseBody
	@RequestMapping(value="/likeCnt/{rnum}")
	public Map<String,Integer> likeCnt(@PathVariable("rnum") int rnum,HttpSession session,HttpServletRequest request) throws Exception {
		String userid=(String)session.getAttribute("userid");
		if(userid==null) {
			userid=request.getRemoteAddr();
		}
		//좋아요 update
		rservice.updateLikecnt(rnum,userid);
		
		Map<String,Integer> resultMap=new HashMap<>();
		//좋아요 select
		ReplyDTO rdto=rservice.selectOne(rnum);
		resultMap.put("likecnt",rdto.getLikecnt());
		resultMap.put("dislikecnt",rdto.getDislikecnt());
		return resultMap;
	}
	
	//싫어요 버튼
	@ResponseBody
	@RequestMapping(value="/dislikeCnt/{rnum}")
	public Map<String,Integer> dislikeCnt(@PathVariable("rnum") int rnum,HttpSession session,HttpServletRequest request) throws Exception {
		String userid=(String)session.getAttribute("userid");
		if(userid==null) {
			userid=request.getRemoteAddr();
		}
		//싫어요 update
		rservice.updateDisLikecnt(rnum,userid);
		//좋아요/싫어요 select
		Map<String,Integer> resultMap=new HashMap<>();
		//싫어요 select
		ReplyDTO rdto=rservice.selectOne(rnum);
		resultMap.put("likecnt",rdto.getLikecnt());
		resultMap.put("dislikecnt",rdto.getDislikecnt());
		return resultMap;
	}

}
