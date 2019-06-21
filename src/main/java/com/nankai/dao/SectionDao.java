package com.nankai.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.nankai.bean.BasicInfo;
import com.nankai.bean.EleminmaxavgOfregion;
import com.nankai.bean.EleofsectionWithrg;
import com.nankai.bean.Section;

public interface SectionDao {

	/*
	 * 新增地段记录
	 */
	int insertSectionInfo(Section section);

	/*
	 * 向section_element表中添加记录
	 */
	int insertSection_elementInfo(@Param("section_id") int section_id, @Param("element_id") int element_id,
			@Param("elecontent") String elecontent);

	/*
	 * 获得某年采样点数量分布
	 */
	int samplepoints(@Param("year") int year, @Param("regionName") String regionName);

	/*
	 * 查询某年某区域某重金属的含量
	 */
	List<EleofsectionWithrg> selectEleContentOfRegion(@Param("year") int year, @Param("regionName") String regionName,
			@Param("eleName") String eleName);

	List<EleofsectionWithrg> selectInfoOfRegion(@Param("year") int year, @Param("regionName") String regionName);

	/*
	 * 查询某年某区域某重金属的含量
	 */
	Map<String, Object> selectEleStatisOfRegion(@Param("year") int year, @Param("regionName") String regionName,
			@Param("eleName") String eleName);

	/*
	 * 查询这些年某区域某重金属的含量
	 */
	List<EleminmaxavgOfregion> selectEleStatisOfRegionforyears(@Param("regionName") String regionName,
			@Param("eleName") String eleName);

	/*
	 * 查询整个天津市某重金属的含量
	 */
	List<EleminmaxavgOfregion> selectEleAllOfRegionforyears(@Param("eleName") String eleName);
	
	List<Integer> findyears();

	List<String> findregions();

	List<String> findelements();

	EleminmaxavgOfregion selectElemOfRegion(@Param("year") int year, @Param("regionName") String regionName,
			@Param("eleName") String eleName);
	
	EleminmaxavgOfregion selectElemOfAll(@Param("year") int year, 	@Param("eleName") String eleName);

	// 查询某年所有区域某重金的平均值
	List<String> selectAvgOfeleyear(@Param("year") int year, @Param("eleName") String eleName);

	// 查询表中各安全等级的数量
	String overproofpoints(@Param("year") int year, @Param("regionName") String regionName, @Param("elemName") String elem,
			@Param("way") int way, @Param("level") int level);

	// 查询某年某区域所有信息
	List<BasicInfo> selectAllSectionInfo(@Param("year") int year, @Param("regionName") String regionName);

	// 添加分析后的信息
	int insertAnalInfo(@Param("year") int year, @Param("regionName") String regionName, @Param("elemName") String elem,
			@Param("way") int way, @Param("level") int level, @Param("amount") String amount);

	List<Integer> findproductids(@Param("year") int year);
	
	void deleteproduct(@Param("id") int id);
	
	void deleteregionanal(@Param("year") int year);
}
