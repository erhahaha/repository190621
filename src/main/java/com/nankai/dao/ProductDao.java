package com.nankai.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.nankai.bean.BasicInfo;
import com.nankai.bean.Product;
import com.nankai.bean.Section;

public interface ProductDao {
	
	

	/*
	 * 新增农作物记录
	 * */
	int insertProductInfo(Product product);
	
	/*
	 * 向product_element表中添加记录
	 * */
	int insertProduct_elementInfo(@Param("product_id")int product_id,@Param("element_id")int element_id,@Param("elecontent")String elecontent);

	
	/*
	 * 查询某年某区域选取了哪些农作物作为样本
	 * */
	List<Section> selectproductOfRegion(@Param("year")int year,@Param("regionName")String regionName);
	

	/*
	 * 查询某年某区域农作物中某元素的最大值 
	 * */
	Map<String,Object> selectproductElemax(@Param("year")int year,@Param("regionName")String regionName,@Param("eleid")int eleid);
	

	/*
	 * 查询某年某区域农作物中某元素的最小值 
	 * */
	Map<String,Object> selectproductElemin(@Param("year")int year,@Param("regionName")String regionName,@Param("eleid")int eleid);
	

	/*
	 * 查询某年某区域农作物中某元素的平均值 
	 * */
	Map<String,Object> selectproductEleavg(@Param("year")int year,@Param("regionName")String regionName,@Param("eleid")int eleid);
	
	List<BasicInfo> selectProductInfo(@Param("year")int year,@Param("regionName")String regionName);

}
