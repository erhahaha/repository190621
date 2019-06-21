package com.nankai.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


import com.nankai.service.Impl.ProductStatisticsService;

@Controller
@RequestMapping("/proStatis")
public class ProductStatisticsController {

	@Autowired
	ProductStatisticsService productStatisticsService; 
	
	
	@RequestMapping("/getProEleExtre")
	public String getProEleExtre(String year,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception{
		
		//response.setContentType("text/html;charset=utf-8");
		//PrintWriter out=response.getWriter();
		/**
		 * 重金属极值和平均值
		 * */
		List<Map<String,Object>> eleExtreListWheat= productStatisticsService.findProEleExtre("=\'小麦\' ",Integer.parseInt(year));
		List<Map<String,Object>> eleExtreListRice= productStatisticsService.findProEleExtre("in(\'水稻\',\'稻谷\')",Integer.parseInt(year));
		List<Map<String,Object>> eleExtreListCorn= productStatisticsService.findProEleExtre("=\'玉米\' ",Integer.parseInt(year));
		//其他类
		List<Map<String,Object>> eleExtreListOther= productStatisticsService.findProEleExtre("in('高粱','鲜食玉米','桃','西瓜','葡萄','甜瓜','枣','冬枣','黄豆')",Integer.parseInt(year));
		//蔬菜
		List<Map<String,Object>> eleExtreListVegetables= productStatisticsService.findProEleExtre("NOT in('玉米','小麦','水稻','稻谷','高粱','鲜食玉米','桃','西瓜','葡萄','甜瓜','枣','冬枣','黄豆')",Integer.parseInt(year));
		model.addAttribute("eleExtreListWheat",eleExtreListWheat);
		model.addAttribute("eleExtreListRice",eleExtreListRice);
		model.addAttribute("eleExtreListCorn",eleExtreListCorn);
		model.addAttribute("eleExtreListOther",eleExtreListOther);
		model.addAttribute("eleExtreListVegetables",eleExtreListVegetables);
		
		/**
		 * 采样点数量统计
		 * */
		Map<String, Object>[] scnCountListWheat= productStatisticsService.findProscnCount("=\'小麦\' ",Integer.parseInt(year));
		Map<String, Object>[] scnCountListRice= productStatisticsService.findProscnCount("in(\'水稻\',\'稻谷\')",Integer.parseInt(year));
		Map<String, Object>[] scnCountListCorn= productStatisticsService.findProscnCount("=\'玉米\' ",Integer.parseInt(year));
		//其他类
		Map<String, Object>[] scnCountListOther= productStatisticsService.findProscnCount("in('高粱','鲜食玉米','桃','西瓜','葡萄','甜瓜','枣','冬枣','黄豆')",Integer.parseInt(year));
		//蔬菜
		Map<String, Object>[] scnCountListVegetables= productStatisticsService.findProscnCount("NOT in('玉米','小麦','水稻','稻谷','高粱','鲜食玉米','桃','西瓜','葡萄','甜瓜','枣','冬枣','黄豆')",Integer.parseInt(year));
		long[] sum=new long[13];
		for(int i=0;i<12;i++){
			sum[i]=(long)scnCountListWheat[i].get("count")+(long)scnCountListRice[i].get("count")+(long)scnCountListCorn[i].get("count")+
					(long)scnCountListOther[i].get("count")+(long)scnCountListVegetables[i].get("count");
		}
		sum[12]=(long)scnCountListWheat[12].get("allcount")+(long)scnCountListRice[12].get("allcount")+(long)scnCountListCorn[12].get("allcount")+
				(long)scnCountListOther[12].get("allcount")+(long)scnCountListVegetables[12].get("allcount");
		model.addAttribute("sum",sum);
		model.addAttribute("scnCountListWheat",scnCountListWheat);
		model.addAttribute("scnCountListRice",scnCountListRice);
		model.addAttribute("scnCountListCorn",scnCountListCorn);
		model.addAttribute("scnCountListOther",scnCountListOther);
		model.addAttribute("scnCountListVegetables",scnCountListVegetables);
		
		/**
		 * 表16.	天津市行政区县农产品各类重金属超标情况
		 * */

		model.addAttribute("sectionEleOver",productStatisticsService.sectionEleOver(Integer.parseInt(year)));
		
		/**
		 * 表17.	不同种植类型的农产品重金属超标情况
		 * */
		model.addAttribute("productEleOver", productStatisticsService.productEleOver(Integer.parseInt(year)));
		
		/**
		 * 表19.	小麦类农产品重金属各区县数量超标情况
		 * 各类农作物在每个行政区的超标点
		 * */
		model.addAttribute("proSecOver", productStatisticsService.proInSectionOverPoint);
		
		/**
		 * 图11. 各类农产品重金属浓度平均超标倍数情况
		 * */
		model.addAttribute("avgMulti",productStatisticsService.proEleAvgMulti);
		
		
		/**
		 * 统计农产品等级
		 * */
		productStatisticsService.StaProDataWithPn(Integer.parseInt(year));
		model.addAttribute("proClassGrade", productStatisticsService.proClassGradeCount);
		model.addAttribute("proSecGrade", productStatisticsService.proSecGradeCount);
		
		/**三级农产品的极值统计
		 * */
		model.addAttribute("proExtreThGrade", productStatisticsService.proExtreThGrade);
		
		return "productStatistics";
	}
	
	//跳转到productStatistics.jsp的路径配置
		@RequestMapping("/productStatistics")
		public String productStatistics(){
			return "productStatistics";
		}
}
