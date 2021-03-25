package org.project.volleyball.controller;

import java.util.List;
import java.util.Map;

import org.project.volleyball.dto.VleagueDTO;
import org.project.volleyball.service.StadiumService;
import org.project.volleyball.service.VleagueService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("vleague")
public class VleagueController {
	private static final Logger logger = LoggerFactory.getLogger(VleagueController.class);
	
	@Autowired
	private VleagueService vservice;
	
	@Autowired
	private StadiumService sservice;
	
	@RequestMapping(value = "/schedule", method = RequestMethod.GET)
	public String schedule() throws Exception {
		return "/vleague/schedule";
	}
	
	@ResponseBody
	@RequestMapping(value = "/scheduleList", method = RequestMethod.GET)
	public List<VleagueDTO> scheduledata(VleagueDTO vdto) throws Exception {
		return vservice.selectList(vdto);
	}
	
	@RequestMapping(value = "/stadium", method = RequestMethod.GET)
	public String stadium() throws Exception {
		return "/vleague/stadium";
	}
	
	@ResponseBody
	@RequestMapping(value = "/map", method = RequestMethod.GET)
	public Map<String,Double> map(String scode) throws Exception {
		Map<String,Double> resultMap=sservice.selectOne(scode);
		return resultMap;
	}

}
