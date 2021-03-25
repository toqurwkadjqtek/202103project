package org.project.volleyball.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.project.volleyball.dto.BoardDTO;
import org.project.volleyball.dto.PageDTO;
import org.project.volleyball.service.BoardService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/board")
@SessionAttributes("pdto") //세션을 생성
public class BoardController {
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired
	private BoardService bservice;
	
	//등록폼
	@RequestMapping(value="add",method=RequestMethod.GET)
	public String add() {
		return "/board/add";
	}
	
	@RequestMapping(value="add",method=RequestMethod.POST)
	public String add(BoardDTO bdto,List<MultipartFile> uploadfiles,HttpSession session,RedirectAttributes rdAtt,HttpServletRequest request) throws Exception {
		String userid=(String)session.getAttribute("userid");
		String nickname=(String)session.getAttribute("nickname");
		if(userid==null) {
			rdAtt.addFlashAttribute("msg","로그인해주세요");
			return "redirect:/board/add";
		}
		bdto.setUserid(userid);
		bdto.setNickname(nickname);
		bdto.setIp(request.getRemoteAddr());
		Map<String,Object> resultMap=bservice.insert(bdto,uploadfiles);
		rdAtt.addFlashAttribute("msg",resultMap.get("msg"));
		return "redirect:/board/";
	}
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String setCurPage(PageDTO pdto,Model model) throws Exception {
		pdto.setCurPage(1);
		model.addAttribute("pdto",pdto);
		return "redirect:list";
	}

	//조회폼
	@RequestMapping(value="/list",method=RequestMethod.GET)
	public String list(@ModelAttribute("pdto") PageDTO pdto,Model model) {
		//@ModelAttribute("pdto")=>@SessionAttributes("pdto")에 저장
		model.addAttribute("pdto",pdto);
		logger.info(pdto.toString());
		return "/board/list";
	}
	
	@ResponseBody
	@RequestMapping(value="/list/",method=RequestMethod.GET)
	public Map<String,Object> listdata(@ModelAttribute("pdto") PageDTO pdto) throws Exception {
		return bservice.selectList(pdto);
	}
	
	//한건조회폼
	@RequestMapping(value="/detail/{bnum}",method=RequestMethod.GET)
	public String detail(@PathVariable("bnum") int bnum,Model model,HttpSession session,HttpServletRequest request) throws Exception {
		String userid=(String)session.getAttribute("userid");
		if(userid==null) {
			userid=request.getRemoteAddr();
		}
		bservice.updateReadcount(bnum,userid); //조회수+1
		Map<String,Object> resultMap=bservice.selectOne(bnum); //한건조회
		model.addAttribute("bdto",resultMap.get("bdto"));
		model.addAttribute("bflist",resultMap.get("bflist"));
		return "/board/detail";
	}
	
	//좋아요 버튼
	@ResponseBody
	@RequestMapping(value="/likeCnt/{bnum}")
	public Map<String,Integer> likeCnt(@PathVariable("bnum") int bnum,HttpSession session,HttpServletRequest request) throws Exception {
		String userid=(String)session.getAttribute("userid");
		if(userid==null) {
			userid=request.getRemoteAddr();
		}
		//좋아요 update
		bservice.updateLikecnt(bnum,userid);
		
		Map<String,Integer> resultMap=new HashMap<>();
		//좋아요 select
		BoardDTO bdto=bservice.selectOneBoard(bnum);
		resultMap.put("likecnt",bdto.getLikecnt());
		resultMap.put("dislikecnt",bdto.getDislikecnt());
		return resultMap;
	}
	
	//싫어요 버튼
	@ResponseBody
	@RequestMapping(value="/dislikeCnt/{bnum}")
	public Map<String,Integer> dislikeCnt(@PathVariable("bnum") int bnum,HttpSession session,HttpServletRequest request) throws Exception {
		String userid=(String)session.getAttribute("userid");
		if(userid==null) {
			userid=request.getRemoteAddr();
		}
		//싫어요 update
		bservice.updateDisLikecnt(bnum,userid);
		//좋아요/싫어요 select
		Map<String,Integer> resultMap=new HashMap<>();
		//싫어요 select
		BoardDTO bdto=bservice.selectOneBoard(bnum);
		resultMap.put("likecnt",bdto.getLikecnt());
		resultMap.put("dislikecnt",bdto.getDislikecnt());
		return resultMap;
	}
	
	//수정폼
	@RequestMapping(value="/modify/{bnum}",method=RequestMethod.GET)
	public String modify(@PathVariable("bnum") int bnum,Model model) throws Exception {
		Map<String,Object> resultMap=bservice.selectOne(bnum);
		model.addAttribute("bdto",resultMap.get("bdto"));
		model.addAttribute("bflist",resultMap.get("bflist"));
		return "/board/modify";
	}
	
	@RequestMapping(value="/modify",method=RequestMethod.POST)
	public String modify(BoardDTO bdto,@RequestParam(value="fileDelete",required=false) List<Integer> fileDeleteList,
			List<MultipartFile> uploadfiles,HttpSession session,RedirectAttributes rdAtt) throws Exception {
		String userid=(String)session.getAttribute("userid");
		String nickname=(String)session.getAttribute("nickname");
		bdto.setUserid((bservice.selectOneBoard(bdto.getBnum())).getUserid());
		bdto.setNickname(nickname);
		if(userid==null||!userid.equals(bdto.getUserid())) {
			rdAtt.addFlashAttribute("msg","일치하지 않는 아이디");
			return "redirect:/board/detail/"+bdto.getBnum();
		}
		Map<String,Object> resultMap=bservice.update(bdto,uploadfiles,fileDeleteList);
		//rdAtt.addFlashAttribute("msg",resultMap.get("msg"));
		return "redirect:/board/detail/"+bdto.getBnum();
	}
	
	//삭제
	@RequestMapping(value="/delete/{bnum}",method=RequestMethod.GET)
	public String delete(@PathVariable("bnum") int bnum,RedirectAttributes rdAtt,HttpSession session) throws Exception {
		String userid=(String)session.getAttribute("userid");
		BoardDTO bdto=bservice.selectOneBoard(bnum);
		if(userid==null||!userid.equals(bdto.getUserid())) {
			rdAtt.addFlashAttribute("msg","일치하지 않는 아이디");
			return "redirect:/board/detail"+bnum;
		}
		Map<String,Object> resultMap=bservice.delete(bnum);
		//rdAtt.addFlashAttribute("msg",resultMap.get("msg"));
		return "redirect:/board/";
	}

}
