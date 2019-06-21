package com.nankai.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.nankai.bean.EleOverProof;

public interface ProductStatisticsDao {

	/**
	 * 查找某年某类农产品中各重金属极值和平均值
	 * @param proScope 农产品种类（in(……) ;not in(……);=……） 
	 * @param year 年份
	 * @return
	 */
	List<Map<String, Object>> selectproEleExtre(@Param("proScope")String proScope,@Param("year")int year);
	
	/**
	 * 某年某区域的某类农产品的  测量区块数量（点位数）
	 * @param proScope 农产品种类（in(……) ;not in(……);=……） 
	 * @param year 年份
	 * @return
	 */
	List<Map<String, Object>> selectproScnCount(@Param("proScope")String proScope,@Param("year")int year);
	
	
	/**
	 * 某年某区域每种种农产品中某元素的超标点位
	 * @param table 
	 * @param year 年份
	 * @return
	 */
	List<EleOverProof> selectOverProofSection(@Param("table")String table,@Param("year")int year);
	
	
	/**
	 * 选出某种元素带有单因子指数的点位数据
	 * @param table
	 * @param year 年份
	 * @return
	 */
	List<EleOverProof> selectDataWithPn(@Param("table")String table,@Param("year")int year);
	
	
	
	
}
