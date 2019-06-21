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

import com.nankai.bean.BasicInfo;
import com.nankai.bean.ResultInfoVO;
import com.nankai.bean.Section;
import com.nankai.service.ProductElemService;

@Controller
@RequestMapping("/productelem")
public class ProductElemController {
	
	@Autowired
	private ProductElemService productelementservice;
	
	@RequestMapping("/enterproduct")
	public String hrefpage() {
		return "product";
	}
	
	// 查询某一年所有地区某一元素的最大值，最小值，平均值
		@RequestMapping(value = "/elemOfProduct", method = RequestMethod.POST)
		@ResponseBody
		public ResultInfoVO eleConOfsections(String year,String regionName) {
			ResultInfoVO vo = new ResultInfoVO();
			int thisyear = Integer.parseInt(year);
			List resultmaplist = new ArrayList<Map<String,Object>>();
			for(int eleid=1;eleid<9;eleid++){
				Map<String,Object> resultmap=productelementservice.findEleStatisOfRegion(thisyear, regionName, eleid);
				resultmaplist.add(resultmap);
			}
			List<Section> productsmap=productelementservice.findproductOfRegion(thisyear, regionName);
			//List<String> productsmap=productelementservice.findproductOfRegion(thisyear, regionName);
			Map<String, Object> map = new HashMap();
			map.put("resultmap", resultmaplist);
			map.put("products", productsmap);
			vo.setObject(map);
			return vo;
		}
		
		@RequestMapping(value = "/infoOfProduct", method = RequestMethod.POST)
		@ResponseBody
		public ResultInfoVO infoOfProduct(String year,String regionName) {
			ResultInfoVO vo = new ResultInfoVO();
			int thisyear = Integer.parseInt(year);
			List<BasicInfo> result=productelementservice.findBasicInfo(thisyear, regionName);
			Map<String, Object> map = new HashMap();
			map.put("result", result);
			vo.setObject(map);
			return vo;
		}
}
