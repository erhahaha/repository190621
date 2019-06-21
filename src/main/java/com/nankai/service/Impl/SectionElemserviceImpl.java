package com.nankai.service.Impl;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nankai.bean.BasicInfo;
import com.nankai.bean.EleminmaxavgOfregion;
import com.nankai.bean.EleofsectionWithrg;
import com.nankai.dao.SectionDao;
import com.nankai.service.SectionElemService;
import com.nankai.utils.SectionOverUtil;

@Service
public class SectionElemserviceImpl implements SectionElemService {

	@Autowired
	private SectionDao sectiondao;

	private SectionOverUtil overutils;
	
	//按特定条件查找
	@Override
	public Integer givenall(int year, String elemName, String regionName, int way,int level) {
		return Integer.parseInt(sectiondao.overproofpoints(year, regionName, elemName,way, level));	
	}

	// 判断土壤超标情况
	@Override
	public List<String> analoverproof_elem(int year, String elemName) {
		List<String> regions = sectiondao.findregions();
		List<String> result = new ArrayList<>();
		if(sectiondao.overproofpoints(year, regions.get(0), elemName, 1, 0) ==null){
			adddata1(year, regions,1);
		}
		for (int i = 0; i < regions.size(); i++) {
			// 以区域划分，两个数为一组，第一组为未超标数，第二组为超标数
			result.add(sectiondao.overproofpoints(year, regions.get(i), elemName, 1, 0));
			result.add(String.valueOf(Integer.parseInt(sectiondao.overproofpoints(year, regions.get(i), elemName, 1, 1))
					  +Integer.parseInt( sectiondao.overproofpoints(year, regions.get(i), elemName, 1, 2))
					 + Integer.parseInt(sectiondao.overproofpoints(year, regions.get(i), elemName, 1, 3))));
		}
		return result;
	}
	
	@Override
	public List<String> analoverproof_region(int year) {
		List<String> elems = sectiondao.findelements();
		List<String> regions = sectiondao.findregions();
		List<String> result = new ArrayList<>();
		if(sectiondao.overproofpoints(year, regions.get(0), elems.get(0), 1, 0) ==null){
			adddata1(year, regions,1);
		}
		int num =0;
		for (int j = 0; j < regions.size(); j++) {
			result.add(regions.get(j)+"区");
			for (int i = 0; i < elems.size(); i++) {
				int temp = Integer.parseInt(sectiondao.overproofpoints(year, regions.get(j), elems.get(i), 1, 1))
								  +Integer.parseInt( sectiondao.overproofpoints(year, regions.get(j), elems.get(i), 1, 2))
								 + Integer.parseInt(sectiondao.overproofpoints(year, regions.get(j), elems.get(i), 1, 3));
				result.add(String.valueOf(temp));
				num+=temp;
			}
			result.add(String.valueOf(num));
			num = 0;
		}
		result.add("总计");
		for (int i = 0; i <= 8; i++){
			result.add(String.valueOf(Integer.parseInt(result.get(1+i))+Integer.parseInt(result.get(11+i))
							+Integer.parseInt(result.get(21+i))+Integer.parseInt(result.get(31+i))
							+Integer.parseInt(result.get(41+i))+Integer.parseInt(result.get(51+i))
							+Integer.parseInt(result.get(61+i))+Integer.parseInt(result.get(71+i))
							+Integer.parseInt(result.get(81+i))+Integer.parseInt(result.get(91+i))
							+Integer.parseInt(result.get(101+i))+Integer.parseInt(result.get(111+i))));
		}
		return result;
	}
	
	// 判断土壤平均超标倍数情况
	@Override
	public List<String> analmeanoverproof(int year, String elemName) {
		List<String> regions = sectiondao.findregions();
		List<String> result = new ArrayList<>();
		DecimalFormat df = new DecimalFormat("0.000");// 设置double后小数点的位数
		if(sectiondao.overproofpoints(year, regions.get(0), elemName, 4, 0) ==null){
			adddata3(year, regions,4);
		}
		for (int i = 0; i < regions.size(); i++) {
			String temp=sectiondao.overproofpoints(year, regions.get(i), elemName, 4, 0);
			if(temp.equals("0.0")){
				result.add("0");
			}else{
				result.add(df.format(Double.valueOf(sectiondao.overproofpoints(year, regions.get(i), elemName, 4, 0))));
			}
		}
		return result;
	}
	
	// 判断土壤安全等级及全量累积指数情况
		@Override
		public List<String> level(int year, String elemName,int level) {
			List<String> result = new ArrayList<>();
			List<String> regions = sectiondao.findregions();
			if(sectiondao.overproofpoints(year, regions.get(0), elemName, level, 0) ==null){
				if(elemName!="All"){
					adddata1(year, regions,level);
				}else{
					adddata2(year, regions,level);
				}
			}
			for (int i = 0; i < regions.size(); i++) {
				// 以区域划分，4个数为一组，第一组为无风险，第二组为低风险，第三组为中度风险，第二组为高风险
				result.add(sectiondao.overproofpoints(year, regions.get(i), elemName, level, 0));
				result.add(sectiondao.overproofpoints(year, regions.get(i), elemName, level, 1));
				result.add(sectiondao.overproofpoints(year, regions.get(i), elemName, level, 2));
				result.add(sectiondao.overproofpoints(year, regions.get(i), elemName, level, 3));
			}
			int[] temp=new int[4];
			for (int i = 0; i < result.size(); i++) {
				if(i%4==0) temp[0] += Integer.parseInt(result.get(i));
				if(i%4==1) temp[1] += Integer.parseInt(result.get(i));
				if(i%4==2) temp[2] += Integer.parseInt(result.get(i));
				if(i%4==3) temp[3] += Integer.parseInt(result.get(i));
			}
			result.clear();
			result.add(String.valueOf(temp[0]));
			result.add(String.valueOf(temp[1]));
			result.add(String.valueOf(temp[2]));
			result.add(String.valueOf(temp[3]));
			return result;
		}

	// 判断土壤安全等级
	@Override
	public List<String> securelevel(int year, String elemName) {
		List<String> result = new ArrayList<>();
		/*List<String> regions = sectiondao.findregions();
		if(sectiondao.overproofpoints(year, regions.get(0), elemName, 1, 0) ==null){
			if(elemName!="All"){
				adddata1(year, regions,1);
			}else{
				adddata2(year, regions,1);
			}
		}
		for (int i = 0; i < regions.size(); i++) {
			// 以区域划分，4个数为一组，第一组为无风险，第二组为低风险，第三组为中度风险，第二组为高风险
			result.add(sectiondao.overproofpoints(year, regions.get(i), elemName, 1, 0));
			result.add(sectiondao.overproofpoints(year, regions.get(i), elemName, 1, 1));
			result.add(sectiondao.overproofpoints(year, regions.get(i), elemName, 1, 2));
			result.add(sectiondao.overproofpoints(year, regions.get(i), elemName, 1, 3));
		}
		int[] temp=new int[4];
		for (int i = 0; i < result.size(); i++) {
			if(i%4==0) temp[0] += Integer.parseInt(result.get(i));
			if(i%4==1) temp[1] += Integer.parseInt(result.get(i));
			if(i%4==2) temp[2] += Integer.parseInt(result.get(i));
			if(i%4==3) temp[3] += Integer.parseInt(result.get(i));
		}
		result.clear();
		result.add(String.valueOf(temp[0]));
		result.add(String.valueOf(temp[1]));
		result.add(String.valueOf(temp[2]));
		result.add(String.valueOf(temp[3]));*/
		return result;
	}
	
	// 判断土壤污染情况
	@Override
	public List<String> pollutionlevel(int year, String elemName) {
		List<String> regions = sectiondao.findregions();
		List<String> result = new ArrayList<>();
		if(sectiondao.overproofpoints(year, regions.get(0), elemName, 2, 0) ==null){
			if(elemName!="All"){
				adddata1(year, regions,2);
			}else{
				adddata2(year, regions,2);
			}
		}
		for (int i = 0; i < regions.size(); i++) {
			// 以区域划分，4个数为一组，第一组为无风险，第二组为低风险，第三组为中度风险，第二组为高风险
			result.add(sectiondao.overproofpoints(year, regions.get(i), elemName, 2, 0));
			result.add(sectiondao.overproofpoints(year, regions.get(i), elemName, 2, 1));
			result.add(sectiondao.overproofpoints(year, regions.get(i), elemName, 2, 2));
			result.add(sectiondao.overproofpoints(year, regions.get(i), elemName, 2, 3));
			result.add(sectiondao.overproofpoints(year, regions.get(i), elemName, 2, 4));
		}
		int[] temp=new int[5];
		for (int i = 0; i < result.size(); i++) {
			if(i%5==0) temp[0] += Integer.parseInt(result.get(i));
			if(i%5==1) temp[1] += Integer.parseInt(result.get(i));
			if(i%5==2) temp[2] += Integer.parseInt(result.get(i));
			if(i%5==3) temp[3] += Integer.parseInt(result.get(i));
			if(i%5==4) temp[4] += Integer.parseInt(result.get(i));
		}
		result.clear();
		result.add(String.valueOf(temp[0]));
		result.add(String.valueOf(temp[1]));
		result.add(String.valueOf(temp[2]));
		result.add(String.valueOf(temp[3]));
		result.add(String.valueOf(temp[4]));
		return result;
	}

	// 判断全量累积指数情况
	@Override
	public List<String> accumulatlevel(int year, String elemName) {
		List<String> result = new ArrayList<>();
		/*List<String> regions = sectiondao.findregions();
		if(sectiondao.overproofpoints(year, regions.get(0), elemName, 3, 0)==null){
			if(elemName!="All"){
				adddata1(year, regions,3);
			}else{
				adddata2(year, regions,3);
			}
		}
		for (int i = 0; i < regions.size(); i++) {
			// 以区域划分，4个数为一组，第一组为无风险，第二组为低风险，第三组为中度风险，第二组为高风险
			result.add(sectiondao.overproofpoints(year, regions.get(i), elemName, 3, 0));
			result.add(sectiondao.overproofpoints(year, regions.get(i), elemName, 3, 1));
			result.add(sectiondao.overproofpoints(year, regions.get(i), elemName, 3, 2));
			result.add(sectiondao.overproofpoints(year, regions.get(i), elemName, 3, 3));
		}
		int[] temp=new int[4];
		for (int i = 0; i < result.size(); i++) {
			if(i%4==0) temp[0] += Integer.parseInt(result.get(i));
			if(i%4==1) temp[1] += Integer.parseInt(result.get(i));
			if(i%4==2) temp[2] += Integer.parseInt(result.get(i));
			if(i%4==3) temp[3] += Integer.parseInt(result.get(i));
		}
		result.clear();
		result.add(String.valueOf(temp[0]));
		result.add(String.valueOf(temp[1]));
		result.add(String.valueOf(temp[2]));
		result.add(String.valueOf(temp[3]));*/
		return result;
	}
	
	// 单个计算插入操作
	private void adddata1(int year, List<String> regions,int way) {
		int num=0;//用来表示划分了几个等级
		switch(way){
			case 1:
			case 3: num = 4; break;
			case 2: num = 5; break;
		}
		List<String> elems = sectiondao.findelements();
		int[] count = new int[8*num];
		for (int i = 0; i < regions.size(); i++) {
			List<BasicInfo> basical = sectiondao.selectAllSectionInfo(year, regions.get(i));
			for (int j = 0; j < basical.size(); j++) {
				if(way==1)
					count=addoverproof(basical.get(j), count);
				else if(way==2)
					count=addpollutionlevel(basical.get(j), count);
				else if(way==3)
					count=addaccumulatlevel(basical.get(j), count);
			}
			int elemlocal = 0;
			for (int j = 0; j < elems.size(); j++) {
				sectiondao.insertAnalInfo(year, regions.get(i), elems.get(j), way, elemlocal % num,String.valueOf(count[elemlocal]));
				elemlocal++;
				if ((elemlocal % num) != 0)
					j--;
			}
			count = new int[8*num];
		}
	}	
	
	//添加超标指数
	private int[] addoverproof(BasicInfo basic , int[] count){
		int result = 0;
		result = SectionOverUtil.overproof_one("Cd", basic.getElemCd(),basic.getElemPH(),basic.getCproduct());
		countresult(count, 0, result);
		result = SectionOverUtil.overproof_one("Hg", basic.getElemHg(), basic.getElemPH(),basic.getCproduct());
		countresult(count, 4, result);
		result = SectionOverUtil.overproof_one("As", basic.getElemAs(), basic.getElemPH(),basic.getCproduct());
		countresult(count, 8, result);
		result = SectionOverUtil.overproof_one("Cu", basic.getElemCu(), basic.getElemPH(),basic.getCproduct());
		countresult(count, 12, result);
		result = SectionOverUtil.overproof_one("Pb", basic.getElemPb(), basic.getElemPH(),basic.getCproduct());
		countresult(count, 16, result);
		result = SectionOverUtil.overproof_one("Cr", basic.getElemCr(), basic.getElemPH(),basic.getCproduct());
		countresult(count, 20, result);
		result = SectionOverUtil.overproof_one("Zn", basic.getElemZn(), basic.getElemPH(),basic.getCproduct());
		countresult(count, 24, result);
		result = SectionOverUtil.overproof_one("Ni", basic.getElemNi(), basic.getElemPH(),basic.getCproduct());
		countresult(count, 28, result);
		return count;
	}
	
	//添加污染等级指数
	private int[] addpollutionlevel(BasicInfo basic , int[] count){
		int result = 0;
		result = SectionOverUtil.pollutionlevel_one("Cd", basic.getElemCd(),basic.getElemPH(),basic.getCproduct());
		countresult2(count, 0, result);
		result = SectionOverUtil.pollutionlevel_one("Hg", basic.getElemHg(), basic.getElemPH(),basic.getCproduct());
		countresult2(count, 5, result);
		result = SectionOverUtil.pollutionlevel_one("As", basic.getElemAs(), basic.getElemPH(),basic.getCproduct());
		countresult2(count, 10, result);
		result = SectionOverUtil.pollutionlevel_one("Cu", basic.getElemCu(), basic.getElemPH(),basic.getCproduct());
		countresult2(count, 15, result);
		result = SectionOverUtil.pollutionlevel_one("Pb", basic.getElemPb(), basic.getElemPH(),basic.getCproduct());
		countresult2(count, 20, result);
		result = SectionOverUtil.pollutionlevel_one("Cr", basic.getElemCr(), basic.getElemPH(),basic.getCproduct());
		countresult2(count, 25, result);
		result = SectionOverUtil.pollutionlevel_one("Zn", basic.getElemZn(), basic.getElemPH(),basic.getCproduct());
		countresult2(count, 30, result);
		result = SectionOverUtil.pollutionlevel_one("Ni", basic.getElemNi(), basic.getElemPH(),basic.getCproduct());
		countresult2(count, 35, result);
		return count;
	}
	
	//添加全量累积指数
	private int[] addaccumulatlevel(BasicInfo basic , int[] count){
		int result = 0;
		result = SectionOverUtil.accumulatlevel_one("Cd", basic.getElemCd());
		countresult(count, 0, result);
		result = SectionOverUtil.accumulatlevel_one("Hg", basic.getElemHg());
		countresult(count, 4, result);
		result = SectionOverUtil.accumulatlevel_one("As", basic.getElemAs());
		countresult(count, 8, result);
		result = SectionOverUtil.accumulatlevel_one("Cu", basic.getElemCu());
		countresult(count, 12, result);
		result = SectionOverUtil.accumulatlevel_one("Pb", basic.getElemPb());
		countresult(count, 16, result);
		result = SectionOverUtil.accumulatlevel_one("Cr", basic.getElemCr());
		countresult(count, 20, result);
		result = SectionOverUtil.accumulatlevel_one("Zn", basic.getElemZn());
		countresult(count, 24, result);
		result = SectionOverUtil.accumulatlevel_one("Ni", basic.getElemNi());
		countresult(count, 28, result);
		return count;
	}
	
	//综合插入操作
	private void adddata2(int year, List<String> regions,int way){
		int num=0;//用来表示划分了几个等级
		switch(way){
			case 1:
			case 3: num = 4; break;
			case 2: num = 5; break;
		}
		List<String> elems = sectiondao.findelements();
		int[] count = new int[num];
		for (int i = 0; i < regions.size(); i++) {
			List<BasicInfo> basical = sectiondao.selectAllSectionInfo(year, regions.get(i));
			List<String> elemcontents =new ArrayList<>();
			for (int j = 0; j < basical.size(); j++) {
				elemcontents.add(basical.get(j).getElemCd());
				elemcontents.add(basical.get(j).getElemHg());
				elemcontents.add(basical.get(j).getElemAs());
				elemcontents.add(basical.get(j).getElemCu());
				elemcontents.add(basical.get(j).getElemPb());
				elemcontents.add(basical.get(j).getElemCr());
				elemcontents.add(basical.get(j).getElemZn());
				elemcontents.add(basical.get(j).getElemNi());
				if(way==1)
					countresult(count, 0, SectionOverUtil.overproof_all(elems, elemcontents,basical.get(j).getElemPH(),basical.get(j).getCproduct()));
				else if(way==2)
					countresult2(count, 0, SectionOverUtil.pollutionlevel_all(elems, elemcontents,basical.get(j).getElemPH(),basical.get(j).getCproduct()));
				else if(way==3)
					countresult(count, 0, SectionOverUtil.accumulatlevel_all(elems, elemcontents));
			}
			for (int j = 0; j < num; j++) {
				sectiondao.insertAnalInfo(year, regions.get(i), "All", way, j, String.valueOf(count[j]));
			}
			count = new int[num];
		}
	}
	
	//平均超标倍数插入操作
	private void adddata3(int year, List<String> regions,int way){
		List<Double> listCd = new ArrayList<Double>();
		List<Double> listHg = new ArrayList<Double>();
		List<Double> listAs = new ArrayList<Double>();
		List<Double> listCu = new ArrayList<Double>();
		List<Double> listPb = new ArrayList<Double>();
		List<Double> listCr = new ArrayList<Double>();
		List<Double> listZn = new ArrayList<Double>();
		List<Double> listNi = new ArrayList<Double>();
		List<String> elems = sectiondao.findelements();
		for (int i = 0; i < regions.size(); i++) {
			List<BasicInfo> basical = sectiondao.selectAllSectionInfo(year, regions.get(i));
			for (int j = 0; j < basical.size(); j++) {
				listCd.add(SectionOverUtil.overproof_mean("Cd",basical.get(j).getElemCd(),basical.get(j).getElemPH(),basical.get(j).getCproduct()));
				listHg.add(SectionOverUtil.overproof_mean("Hg",basical.get(j).getElemHg(),basical.get(j).getElemPH(),basical.get(j).getCproduct()));
				listAs.add(SectionOverUtil.overproof_mean("As",basical.get(j).getElemAs(),basical.get(j).getElemPH(),basical.get(j).getCproduct()));
				listCu.add(SectionOverUtil.overproof_mean("Cu",basical.get(j).getElemCu(),basical.get(j).getElemPH(),basical.get(j).getCproduct()));
				listPb.add(SectionOverUtil.overproof_mean("Pb",basical.get(j).getElemPb(),basical.get(j).getElemPH(),basical.get(j).getCproduct()));
				listCr.add(SectionOverUtil.overproof_mean("Cr",basical.get(j).getElemCr(),basical.get(j).getElemPH(),basical.get(j).getCproduct()));
				listZn.add(SectionOverUtil.overproof_mean("Zn",basical.get(j).getElemZn(),basical.get(j).getElemPH(),basical.get(j).getCproduct()));
				listNi.add(SectionOverUtil.overproof_mean("Ni",basical.get(j).getElemNi(),basical.get(j).getElemPH(),basical.get(j).getCproduct()));
			}
			sectiondao.insertAnalInfo(year, regions.get(i), "Cd", way, 0, String.valueOf(SectionOverUtil.calculatemean(listCd)));
			sectiondao.insertAnalInfo(year, regions.get(i), "Hg", way, 0, String.valueOf(SectionOverUtil.calculatemean(listHg)));
			sectiondao.insertAnalInfo(year, regions.get(i), "As", way, 0, String.valueOf(SectionOverUtil.calculatemean(listAs)));
			sectiondao.insertAnalInfo(year, regions.get(i), "Cu", way, 0, String.valueOf(SectionOverUtil.calculatemean(listCu)));
			sectiondao.insertAnalInfo(year, regions.get(i), "Pb", way, 0, String.valueOf(SectionOverUtil.calculatemean(listPb)));
			sectiondao.insertAnalInfo(year, regions.get(i), "Cr", way, 0, String.valueOf(SectionOverUtil.calculatemean(listCr)));
			sectiondao.insertAnalInfo(year, regions.get(i), "Zn", way, 0, String.valueOf(SectionOverUtil.calculatemean(listZn)));
			sectiondao.insertAnalInfo(year, regions.get(i), "Ni", way, 0, String.valueOf(SectionOverUtil.calculatemean(listNi)));
			listCd.clear();listHg.clear();listAs.clear();listCu.clear();listPb.clear();listCr.clear();listZn.clear();listNi.clear();
		}
	}
	
	// 查询某区域重金属含量
	@Override
	public List<EleofsectionWithrg> findEleContentOfRegion(int year, String regionName, String eleName) {
		List<EleofsectionWithrg> resultmap;
		resultmap = sectiondao.selectEleContentOfRegion(year, regionName, eleName);
		return resultmap;
	}

	// 查询某年某区域重金属含量最大值，最小值，平均值
	@Override
	public Map<String, Object> findEleStatisOfRegion(int year, String regionName, String eleName) {
		Map<String, Object> resultmap;
		resultmap = sectiondao.selectEleStatisOfRegion(year, regionName, eleName);
		return resultmap;
	}

	@Override
	public EleminmaxavgOfregion findElemOfRegion(int year, String regionName, String eleName) {
		EleminmaxavgOfregion result =new EleminmaxavgOfregion();
		if(regionName.equals("All"))
		{
			result = sectiondao.selectElemOfAll(year, eleName);
			result.setRegionName("总体");
		}else{
			result = sectiondao.selectElemOfRegion(year, regionName, eleName);
		}
		return result;
	}

	// 查询这些年某区域重金属含量最大值，最小值，平均值
	@Override
	public List<EleminmaxavgOfregion> findEleStatisOfRegionforyears(String regionName, String eleName) {
		List<EleminmaxavgOfregion> resultmap = sectiondao.selectEleStatisOfRegionforyears(regionName, eleName);
		DecimalFormat df = new DecimalFormat("0.000");// 设置double后小数点的位数
		for (int i = 0; i < resultmap.size(); i++) {
			// double test
			// =Double.valueOf(df.format(Double.valueOf(resultmap.get(i).getMincontent())));
			resultmap.get(i).setMaxcontent(df.format(Double.valueOf(resultmap.get(i).getMaxcontent())));
			resultmap.get(i).setAvgcontent(df.format(Double.valueOf(resultmap.get(i).getAvgcontent())));
			resultmap.get(i).setMincontent(df.format(Double.valueOf(resultmap.get(i).getMincontent())));
		}
		return resultmap;
	}
	
	@Override
	public List<EleminmaxavgOfregion> findEleAllRegionforyears(String eleName) {
		List<EleminmaxavgOfregion> resultmap = sectiondao.selectEleAllOfRegionforyears(eleName);
		DecimalFormat df = new DecimalFormat("0.000");// 设置double后小数点的位数
		for (int i = 0; i < resultmap.size(); i++) {
			// double test
			// =Double.valueOf(df.format(Double.valueOf(resultmap.get(i).getMincontent())));
			resultmap.get(i).setRegionName("天津市");
			resultmap.get(i).setMaxcontent(df.format(Double.valueOf(resultmap.get(i).getMaxcontent())));
			resultmap.get(i).setAvgcontent(df.format(Double.valueOf(resultmap.get(i).getAvgcontent())));
			resultmap.get(i).setMincontent(df.format(Double.valueOf(resultmap.get(i).getMincontent())));
		}
		return resultmap;
	}

	@Override
	public List<BasicInfo> findBasicInfo(int year, String regionName) {
		List<EleofsectionWithrg> result = sectiondao.selectInfoOfRegion(year, regionName);
		List<BasicInfo> resultmap = new ArrayList<>();
		DecimalFormat df = new DecimalFormat("0.000");// 设置double后小数点的位数
		BasicInfo bi = null;
		for (int i = 0; i < result.size(); i++) {
			if (i % 11 <= 8) {
				if (i % 11 == 0) {
					bi = new BasicInfo();
					bi.setName(regionName);
					bi.setYear(year);
					bi.setsectionNumber(result.get(i).getSectionNumber());
				}
				String data = df.format(Double.valueOf(result.get(i).getElecontent()));
				if (result.get(i).getEleName().equals("Cd")) {
					bi.setElemCd(data);
				} else if (result.get(i).getEleName().equals("Hg")) {
					bi.setElemHg(data);
				} else if (result.get(i).getEleName().equals("As")) {
					bi.setElemAs(data);
				} else if (result.get(i).getEleName().equals("Cu")) {
					bi.setElemCu(data);
				} else if (result.get(i).getEleName().equals("Pb")) {
					bi.setElemPb(data);
				} else if (result.get(i).getEleName().equals("Cr")) {
					bi.setElemCr(data);
				} else if (result.get(i).getEleName().equals("Zn")) {
					bi.setElemZn(data);
				} else if (result.get(i).getEleName().equals("Ni")) {
					bi.setElemNi(data);
				} else if (result.get(i).getEleName().equals("pH")) {
					bi.setElemPH(data);
				}
			}
			if (i % 11 == 8) {
				bi.setCproduct("0");
				resultmap.add(bi);
			}
		}
		return resultmap;
	}

	@Override
	public List<String> findAvgOfeleyear(int year, String eleName) {
		List<String> result = sectiondao.selectAvgOfeleyear(year, eleName);
		DecimalFormat df = new DecimalFormat("0.000");// 设置double后小数点的位数
		for (int i = 0; i < result.size(); i++) {
			result.set(i, df.format(Double.valueOf(result.get(i))));
		}
		return result;
	}

	@Override
	public List<String> getregions() {
		return sectiondao.findregions();
	}

	@Override
	public List<Integer> getyears() {
		return sectiondao.findyears();
	}

	@Override
	public List<String> getelements() {
		return sectiondao.findelements();
	}

	@Override
	public List<Integer> analPoints(int year) {
		List<String> regions = getregions();
		List<Integer> numbers = new ArrayList<>();
		for (String region : regions) {
			numbers.add(sectiondao.samplepoints(year, region));
		}
		return numbers;
	}
	
	private void countresult(int[] a, int elemstart, int result) {
		switch (result) {
		case 0:
			a[elemstart]++;
			break;
		case 1:
			a[elemstart + 1]++;
			break;
		case 2:
			a[elemstart + 2]++;
			break;
		case 3:
			a[elemstart + 3]++;
			break;
		}
	}

	private void countresult2(int[] a, int elemstart, int result) {
		switch (result) {
		case 0:
			a[elemstart]++;
			break;
		case 1:
			a[elemstart + 1]++;
			break;
		case 2:
			a[elemstart + 2]++;
			break;
		case 3:
			a[elemstart + 3]++;
			break;
		case 4:
			a[elemstart + 4]++;
			break;
		}
	}
}
