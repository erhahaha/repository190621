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
import com.nankai.service.SettingStandardService;

@Controller
@RequestMapping("/changestandard")
public class StandardController {

	@Autowired
	private SettingStandardService settingstandardservice;

	@RequestMapping(value = "/selectStandard", method = RequestMethod.POST)
	@ResponseBody
	public ResultInfoVO selectStandard(String way) {
		List<String> result = new ArrayList<>();
		List<String> ranges = new ArrayList<>();
		if (way.equals("overproof")) {
			ranges =settingstandardservice.findranges(1);
			result = settingstandardservice.standards(1);
		} else if (way.equals("securelevel")) {

		} else if (way.equals("pollutionlevel")) {
			ranges =settingstandardservice.findranges(3);
			result = settingstandardservice.standards(3);
		} else if (way.equals("accumulatlevel")) {

		}
		ResultInfoVO vo = new ResultInfoVO();
		Map<String, Object> map = new HashMap();
		map.put("ranges", ranges);
		map.put("result", result);
		vo.setObject(map);
		return vo;
	}
}
