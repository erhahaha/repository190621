package com.nankai.controller;

import java.text.DecimalFormat;
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
import com.nankai.bean.EleminmaxavgOfregion;
import com.nankai.bean.EleofsectionWithrg;
import com.nankai.bean.ResultInfoVO;
import com.nankai.service.SectionElemService;

@Controller
@RequestMapping("/sectionelem")
public class SecionElemController {
	private static final int regionNum = 12;
	private static final int elemNum = 8;

	@Autowired
	private SectionElemService sectionelementservice;

	@RequestMapping("/enterdata")
	public String enterdata() {
		return "data";
	}

	@RequestMapping("/entertrend")
	public String entertrend() {
		return "trend";
	}

	@RequestMapping("/tableshows")
	public String tableshows() {
		return "tableshow";
	}

	@RequestMapping("/enterhome")
	public String home() {
		return "home";
	}
	
	@RequestMapping("/analdata")
	public String analdata() {
		return "analdata";
	}

	@RequestMapping("/analtrend")
	public String analtrend() {
		return "analtrend";
	}

	// 查询某一年所有地区某一元素的最大值，最小值，平均值
	@RequestMapping(value = "/elemOfSection", method = RequestMethod.POST)
	@ResponseBody
	public ResultInfoVO eleConOfsections(String year, String kind) {
		ResultInfoVO vo = new ResultInfoVO();
		int thisyear = Integer.parseInt(year);
		List<String> regions = sectionelementservice.getregions();
		List<String> maxdata = new ArrayList<>();
		List<String> meandata = new ArrayList<>();
		List<String> mindata = new ArrayList<>();
		EleminmaxavgOfregion resultmapstatis =new EleminmaxavgOfregion();
		for (int i = 0; i < regions.size(); i++) {
			resultmapstatis = sectionelementservice.findElemOfRegion(thisyear, regions.get(i), kind);
			maxdata.add(resultmapstatis.getMaxcontent());
			meandata.add(resultmapstatis.getMincontent());
			mindata.add(resultmapstatis.getAvgcontent());
		}
		resultmapstatis = sectionelementservice.findElemOfRegion(thisyear, "All", kind);
		maxdata.add(resultmapstatis.getMaxcontent());
		meandata.add(resultmapstatis.getMincontent());
		mindata.add(resultmapstatis.getAvgcontent());
		Map<String, Object> map = new HashMap();
		map.put("maxdata", maxdata);
		map.put("meandata", meandata);
		map.put("mindata", mindata);
		vo.setObject(map);
		return vo;
	}

	// 查询某一年某一地区某一元素的所有含量
	@RequestMapping(value = "/eleConOfsection", method = RequestMethod.POST)
	@ResponseBody
	public ResultInfoVO eleConOfsection(String year, String regionName, String kind) {
		ResultInfoVO vo = new ResultInfoVO();
		int thisyear = Integer.parseInt(year);
		List<EleofsectionWithrg> resultmap = sectionelementservice.findEleContentOfRegion(thisyear, regionName, kind);
		Map<String, Object> map = new HashMap();
		map.put("resultmap", resultmap);
		vo.setObject(map);
		return vo;
	}

	// 查询某地区某一元素所有的最大值，最小值，平均值
	@RequestMapping(value = "/eleConofregionforyears", method = RequestMethod.POST)
	@ResponseBody
	public ResultInfoVO eleConofregionforyears(String kind, String regionName) {
		ResultInfoVO vo = new ResultInfoVO();
		List<EleminmaxavgOfregion> resultmap = new ArrayList<>();
		if(regionName.equals("天津市区")){
			resultmap =	sectionelementservice.findEleAllRegionforyears(kind);
		}else{
			resultmap =	sectionelementservice.findEleStatisOfRegionforyears(regionName, kind);
		}
		Map<String, Object> map = new HashMap();
		map.put("resultmap", resultmap);
		vo.setObject(map);
		return vo;
	}

	@RequestMapping(value = "/infoOfRegion", method = RequestMethod.POST)
	@ResponseBody
	public ResultInfoVO selectAllofRegion(String year, String region) {
		int thisyear = Integer.parseInt(year);
		ResultInfoVO vo = new ResultInfoVO();
		List<BasicInfo> allresult = sectionelementservice.findBasicInfo(thisyear, region);
		Map<String, Object> map = new HashMap();
		map.put("allresult", allresult);
		vo.setObject(map);
		return vo;
	}

	@RequestMapping(value = "/analOfSamplePoints", method = RequestMethod.POST)
	@ResponseBody
	public ResultInfoVO analOfSamplePoints(String year) {
		List<Integer> numsOfpoints = sectionelementservice.analPoints(Integer.parseInt(year));
		ResultInfoVO vo = new ResultInfoVO();
		Map<String, Object> map = new HashMap();
		map.put("numsOfpoints", numsOfpoints);
		vo.setObject(map);
		return vo;
	}

	// 所有区域所有重金属所有年的平均值
	@RequestMapping(value = "/eleAvgOfAll", method = RequestMethod.POST)
	@ResponseBody
	public ResultInfoVO selectAvgOfAll() {
		ResultInfoVO vo = new ResultInfoVO();
		List<String> elems = sectionelementservice.getelements();
		List<Integer> years = sectionelementservice.getyears();
		List<String> allresult = new ArrayList<>();
		int numOfyear = regionNum * years.size();
		for (int i = 0; i < elems.size(); i++) {
			for (int j = 0; j < years.size(); j++) {
				List<String> result = sectionelementservice.findAvgOfeleyear(years.get(j), elems.get(i));
				allresult.add(result.get(0));
				allresult.add(result.get(8));
				allresult.add(result.get(1));
				allresult.add(result.get(10));
				allresult.add(result.get(7));
				allresult.add(result.get(2));
				allresult.add(result.get(3));
				allresult.add(result.get(5));
				allresult.add(result.get(4));
				allresult.add(result.get(9));
				allresult.add(result.get(11));
				allresult.add(result.get(6));
			}
		}
		List<String> CdList = new ArrayList<>();
		List<String> HgList = new ArrayList<>();
		List<String> AsList = new ArrayList<>();
		List<String> CuList = new ArrayList<>();
		List<String> PbList = new ArrayList<>();
		List<String> CrList = new ArrayList<>();
		List<String> ZnList = new ArrayList<>();
		List<String> NiList = new ArrayList<>();
		for (int i = 0; i < allresult.size(); i++) {
			switch (i / numOfyear) {
			case 0:
				CdList.add(allresult.get(i));
				break;
			case 1:
				HgList.add(allresult.get(i));
				break;
			case 2:
				AsList.add(allresult.get(i));
				break;
			case 3:
				CuList.add(allresult.get(i));
				break;
			case 4:
				PbList.add(allresult.get(i));
				break;
			case 5:
				CrList.add(allresult.get(i));
				break;
			case 6:
				ZnList.add(allresult.get(i));
				break;
			case 7:
				NiList.add(allresult.get(i));
				break;
			}
		}
		int a = years.get(0);
		Map<String, Object> mapCd = dislist(CdList, years);
		Map<String, Object> mapHg = dislist(HgList, years);
		Map<String, Object> mapAs = dislist(AsList, years);
		Map<String, Object> mapCu = dislist(CuList, years);
		Map<String, Object> mapPb = dislist(PbList, years);
		Map<String, Object> mapCr = dislist(CrList, years);
		Map<String, Object> mapZn = dislist(ZnList, years);
		Map<String, Object> mapNi = dislist(NiList, years);
		Map<String, Object> map = new HashMap();
		map.put("CdList", mapCd);
		map.put("HgList", mapHg);
		map.put("AsList", mapAs);
		map.put("CuList", mapCu);
		map.put("PbList", mapPb);
		map.put("CrList", mapCr);
		map.put("ZnList", mapZn);
		map.put("NiList", mapNi);
		map.put("startyear", years.get(0));
		map.put("years", years);
		vo.setObject(map);
		return vo;
	}

	public Map<String, Object> dislist(List<String> array, List<Integer> years) {
		Map<String, Object> map = new HashMap();
		int Num = years.get(0) - 1;
		List<String> list = new ArrayList<String>();
		for (int i = 0; i < array.size(); i++) {
			if (i % regionNum == 0) {
				if (i != 0) {
					map.put("y" + Num, list);
				}
				list = new ArrayList<String>();
				Num++;
			}
			list.add(array.get(i));
		}
		map.put("y" + Num, list);
		return map;
	}

	@RequestMapping(value = "/kindofanal", method = RequestMethod.POST)
	@ResponseBody
	public ResultInfoVO kindofanal(String kind, String way, String year, String elem) {
		int thisyear = Integer.parseInt(year);
		List<String> result = new ArrayList<>();
		List<String> percent = new ArrayList<>();
		List<String> elems = sectionelementservice.getelements();
		List<String> regions = sectionelementservice.getregions();
		DecimalFormat df = new DecimalFormat("0.000");// 设置double后小数点的位数
		if (kind.equals("overproof") && way.equals("op_count")) {
			result = sectionelementservice.analoverproof_region(thisyear);
			List<Integer> numsOfpoints = sectionelementservice.analPoints(Integer.parseInt(year));
			int temp = 0;
			for (Integer integer : numsOfpoints) {
				temp += integer;
			}
			for (int i = 0; i < elemNum; i++) {
				percent.add(String.valueOf(df.format(100 * Double.parseDouble(result.get(121 + i)) / temp)));
			}
		} else if (kind.equals("overproof") && way.equals("op_pointall")) {
			List<String> temp = sectionelementservice.analoverproof_elem(thisyear, elem);
			int overproof = 0;
			int all = 0;
			for (int i = 0; i < temp.size(); i++) {
				if (i % 2 == 1) {
					overproof += Integer.parseInt(temp.get(i));
				}
				all += Integer.parseInt(temp.get(i));
			}
			result.add(String.valueOf(overproof));
			result.add(String.valueOf(df.format(100 * (overproof * 1.0) / all)) + "%");
			result.add(String.valueOf(all - overproof));
			result.add(String.valueOf(df.format(100 * (all - overproof) * 1.0 / all)) + "%");
			result.add(String.valueOf((all - overproof) / overproof) + ":1");
			percent.add(String.valueOf(overproof));
			percent.add(String.valueOf(all - overproof));
		} else if (kind.equals("overproof") && way.equals("op_pointregion")) {
			List<String> temp = sectionelementservice.analoverproof_elem(thisyear, elem);
			int all = 0;
			for (int i = 0; i < temp.size(); i++) {
				if (i % 2 == 1) {
					all += Integer.parseInt(temp.get(i));
					result.add(temp.get(i));
				}
			}
			percent.addAll(result);
			for (int i = 0; i < regionNum; i++) {
				if (result.get(i).equals("0")) {
					result.add("0");
				} else {
					result.add(String.valueOf(df.format(100 * (Double.parseDouble(result.get(i)) / all))));
				}
			}
		} else if (kind.equals("overproof") && way.equals("op_mean")) {
			result = sectionelementservice.analmeanoverproof(thisyear, elem);
		} else if (kind.equals("securelevel") && way.equals("ot_all")) {
			result = sectionelementservice.level(thisyear, "All", 1);
			result_percent(result, percent, df);
		} else if (kind.equals("securelevel") && way.equals("ot_region")) {
			result = sectionelementservice.level(thisyear, elem, 1);
			result_percent(result, percent, df);
		} else if (kind.equals("pollutionlevel") && way.equals("ot_all")) {
			result = sectionelementservice.pollutionlevel(thisyear, "All");
			result_percent(result, percent, df);
		} else if (kind.equals("pollutionlevel") && way.equals("ot_region")) {
			result = sectionelementservice.pollutionlevel(thisyear, elem);
			result_percent(result, percent, df);
		} else if (kind.equals("accumulatlevel") && way.equals("ot_all")) {
			result = sectionelementservice.level(thisyear, "All", 3);
			result_percent(result, percent, df);
		} else if (kind.equals("accumulatlevel") && way.equals("ot_region")) {
			result = sectionelementservice.level(thisyear, elem, 3);
			result_percent(result, percent, df);
		}
		ResultInfoVO vo = new ResultInfoVO();
		Map<String, Object> map = new HashMap();
		map.put("result", result);
		map.put("percent", percent);
		vo.setObject(map);
		return vo;
	}

	private void result_percent(List<String> result, List<String> percent, DecimalFormat df) {
		percent.addAll(result);
		int all = 0;
		for (int i = 0; i < result.size(); i++) {
			all += Integer.parseInt(result.get(i));
		}
		for (int i = 0; i < percent.size(); i++) {
			result.add(String.valueOf(df.format(100.0 * Integer.parseInt(percent.get(i)) / all)));
		}
	}

	@RequestMapping(value = "/trendanal", method = RequestMethod.POST)
	@ResponseBody
	public ResultInfoVO trendanal(String way, String elem, String region) {
		List<String> result = new ArrayList<>();
		List<String> picture = new ArrayList<>();
		List<Integer> years = sectionelementservice.getyears();
		List<String> elems = sectionelementservice.getelements();
		List<String> regions = sectionelementservice.getregions();
		DecimalFormat df = new DecimalFormat("0.000");// 设置double后小数点的位数
		if (way.equals("count_all")) {
			for (int i = 0; i < years.size(); i++) {
				int all = 0;
				result.add(String.valueOf(years.get(i)));
				List<Integer> temp = sectionelementservice.analPoints(years.get(i));
				for (int j = 0; j < temp.size(); j++) {
					result.add(String.valueOf(temp.get(j)));
					all += temp.get(j);
				}
				result.add(String.valueOf(all));
			}
		}else if (way.equals("count_overproof")) {
			for (int i = 0; i < years.size(); i++) {
				int all = 0;
				List<String> temp = sectionelementservice.analoverproof_elem(years.get(i),elem);
				result.add(String.valueOf(years.get(i)));
				for (int j = 0; j < temp.size(); j++) {
					if(j%2==1){
						all+=Integer.parseInt(temp.get(j));
						result.add(temp.get(j));
					}
				}
				result.add(String.valueOf(all));
			}
		}else if (way.equals("count_nooverproof")) {
			for (int i = 0; i < years.size(); i++) {
				int all = 0;
				List<String> temp = sectionelementservice.analoverproof_elem(years.get(i),elem);
				result.add(String.valueOf(years.get(i)));
				for (int j = 0; j < temp.size(); j++) {
					if(j%2==0){
						all+=Integer.parseInt(temp.get(j));
						result.add(temp.get(j));
					}
				}
				result.add(String.valueOf(all));
			}
		}else if (way.equals("probabilit_overproof")) {
			for (int i = 0; i < years.size(); i++) {
				int noover = 0;
				int over = 0;
				if(region.equals( "总体")){
					for (int j = 0; j < regions.size(); j++) {
						noover += sectionelementservice.givenall(years.get(i), elem, regions.get(j), 1, 0);
						over += sectionelementservice.givenall(years.get(i), elem, regions.get(j), 1, 1)
								+sectionelementservice.givenall(years.get(i), elem, regions.get(j), 1, 2)
								+sectionelementservice.givenall(years.get(i), elem, regions.get(j), 1, 3);
					}
				}else{
					noover = sectionelementservice.givenall(years.get(i), elem, region, 1, 0);
					over = sectionelementservice.givenall(years.get(i), elem, region, 1, 1)
							+sectionelementservice.givenall(years.get(i), elem, region, 1, 2)
							+sectionelementservice.givenall(years.get(i), elem, region, 1, 3);
				}
				result.add(String.valueOf(years.get(i)));
				result.add(region);
				result.add(elem);
				result.add(String.valueOf(noover+over));
				result.add(String.valueOf(over));
				result.add(String.valueOf(df.format(100.0* over/(noover+over))));
				picture.add(String.valueOf(df.format(100.0* over/(noover+over))));
			}
		}
		ResultInfoVO vo = new ResultInfoVO();
		Map<String, Object> map = new HashMap();
		map.put("yearnum", years);
		map.put("result", result);
		map.put("picture", picture);
		vo.setObject(map);
		return vo;
	}
}
