package org.project.volleyball.service;

import java.util.HashMap;
import java.util.Map;

import org.project.volleyball.dao.StadiumDAO;
import org.project.volleyball.dto.StadiumDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StadiumServiceImpl implements StadiumService{
	
	@Autowired
	private StadiumDAO sdao;

	@Override
	public Map<String, Double> selectOne(String scode) throws Exception {
		StadiumDTO sdto=sdao.selectOne(scode);
		Map<String,Double> smap=new HashMap<>();
		smap.put("y",sdto.getSlat());
		smap.put("x",sdto.getSlong());
		return smap;
	}

}
