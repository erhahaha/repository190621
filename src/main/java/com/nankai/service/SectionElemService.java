package com.nankai.service;

import java.util.List;
import java.util.Map;

import com.nankai.bean.BasicInfo;
import com.nankai.bean.EleminmaxavgOfregion;
import com.nankai.bean.EleofsectionWithrg;

public interface SectionElemService {
	// 获得数据库中的所有的元素
	List<String> getelements();

	// 获得数据库中出现的所有的年份
	List<Integer> getyears();

	// 获得数据库中的所有的地区名称
	List<String> getregions();

	// 获得某年采样点数量分布
	List<Integer> analPoints(int year);

	// 查找出某一年所有地区某一元素的平均值
	List<String> findAvgOfeleyear(int year, String eleName);

	// 查找某一年某一地区的基本要素
	List<BasicInfo> findBasicInfo(int year, String regionName);

	// 查询这些年某区域重金属含量最大值，最小值，平均值
	List<EleminmaxavgOfregion> findEleStatisOfRegionforyears(String regionName, String eleName);

	// 查询这些年某一区域重金属含量最大值，最小值，平均值
	EleminmaxavgOfregion findElemOfRegion(int year, String regionName, String eleName);

	// 查询某年某区域重金属含量最大值，最小值，平均值
	Map<String, Object> findEleStatisOfRegion(int year, String regionName, String eleName);

	// 查询某区域重金属含量
	List<EleofsectionWithrg> findEleContentOfRegion(int year, String regionName, String eleName);

	List<String> analoverproof_elem(int year, String elemName);

	List<String> analoverproof_region(int year);

	List<String> securelevel(int year, String elemName);

	List<String> pollutionlevel(int year, String elemName);

	List<String> accumulatlevel(int year, String elemName);

	List<String> analmeanoverproof(int year, String elemName);

	Integer givenall(int year, String elemName, String regionName, int way, int level);

	List<String> level(int year, String elemName, int level);

	List<EleminmaxavgOfregion> findEleAllRegionforyears(String eleName);

}
