package com.nankai.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nankai.bean.ResultInfoVO;
import com.nankai.service.InitdataService;

@Controller
@RequestMapping("/init")
public class initController {

	@Autowired
	private InitdataService idService;

	@RequestMapping(value = "/initData", method = RequestMethod.POST)
	@ResponseBody
	public ResultInfoVO initPage() {
		ResultInfoVO vo = new ResultInfoVO();
		int result = -1;
		String rtnMessage = "";
		List<Integer> years = idService.getyears();
		List<String> regions = idService.getregions();
		List<String> elements = idService.getelements();
		Map<String, Object> map = new HashMap();
		if (years != null && regions != null) {
			map.put("years", years);
			map.put("regions", regions);
			map.put("elements", elements);
			result = 0;
			rtnMessage = "OK";
		}
		vo.setObject(map);
		vo.setRtnMessage(rtnMessage);
		vo.setResult(result);
		return vo;
	}

	@RequestMapping(value = "/inittowns", method = RequestMethod.POST)
	@ResponseBody
	public ResultInfoVO initTowns(String year, String region) {
		ResultInfoVO vo = new ResultInfoVO();
		int thisyear = Integer.parseInt(year);
		List<String> towns=new ArrayList<>();
		List<String> temps = idService.gettowns(thisyear, region);
		int index = 0;
		for (String temp : temps) {
			if (!temp.equals("0.0")){
				towns.add(temp);
			}
		}
		Map<String, Object> map = new HashMap();
		map.put("towns", towns);
		vo.setObject(map);
		return vo;
	}
}
