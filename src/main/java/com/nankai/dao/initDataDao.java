package com.nankai.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface initDataDao {
	List<Integer> findyears();
	
	List<String>  findregions();
	
	List<String>  findelements();
	
	List<String>  findtowns(@Param("year") int year, @Param("regionName") String regionName);
}
