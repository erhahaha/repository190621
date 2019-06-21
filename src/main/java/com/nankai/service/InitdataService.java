package com.nankai.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface InitdataService {

	List<Integer> getyears();

	List<String> getregions();

	List<String> getelements();

	List<String> gettowns(int year, String regionName);
}
