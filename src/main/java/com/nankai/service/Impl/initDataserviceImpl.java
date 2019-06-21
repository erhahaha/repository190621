package com.nankai.service.Impl;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nankai.dao.initDataDao;
import com.nankai.service.InitdataService;

@Service
public class initDataserviceImpl implements InitdataService{
	@Autowired
	initDataDao idDao;

	@Override
	public List<Integer> getyears() {
		return idDao.findyears();
	}
	
	@Override
	public List<String> getregions() {
		return idDao.findregions();
	}
	
	@Override
	public List<String> getelements() {
		return idDao.findelements();
	}
	
	@Override
	public List<String> gettowns( int year, String regionName) {
		return idDao.findtowns(year,  regionName);
	}
}
