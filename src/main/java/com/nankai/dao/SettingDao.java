package com.nankai.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface SettingDao {
	// 查询一种元素根据田种分了几种标准
	List<String> kindofelem(@Param("kind") int kind, @Param("elem") String elem);

	// 查询一种元素一种田地不同PH值的标准
	List<String> selectStandard(@Param("kind") int kind, @Param("elem") String elem,
			@Param("elemkind") String elemkind);
	
	//查询一种标准的范围
	List<String> findranges(@Param("kind") int kind);

	List<String> findelements();
}
