package org.project.volleyball.controller;

import java.util.List;

import org.project.volleyball.dto.VleagueDTO;
import org.project.volleyball.service.VleagueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value="/onair")
public class OnairController {
	
	@Autowired
	private VleagueService vservice;
	
	@RequestMapping(value="/men")
	public String onairMen(Model model) {
		model.addAttribute("gubun","1");
		return "/onair/onair";
	}
	
	@RequestMapping(value="/women")
	public String onairWomen(Model model) {
		model.addAttribute("gubun","2");
		return "/onair/onair";
	}
	
	@RequestMapping(value="/sample")
	public String onairSample() {
		return "/onair/sample";
	}
	
	@ResponseBody
	@RequestMapping(value="/check",method=RequestMethod.GET)
	public VleagueDTO checkToday(VleagueDTO vdto) throws Exception {
		return vservice.selectOne(vdto);
	}

}
