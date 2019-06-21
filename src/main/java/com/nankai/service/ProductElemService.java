package com.nankai.service;

import java.util.List;
import java.util.Map;

import com.nankai.bean.BasicInfo;
import com.nankai.bean.Section;

public interface ProductElemService{

	List<Section> findproductOfRegion(int year, String regionName);

	Map<String, Object> findEleStatisOfRegion(int year, String regionName, int eleid);

	List<BasicInfo> findBasicInfo(int year, String regionName);

}
