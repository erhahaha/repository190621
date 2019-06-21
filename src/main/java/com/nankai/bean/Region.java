package com.nankai.bean;

import java.util.List;

public class Region {

	private int id;
	private String name;
	
	//一个地区含有多个地段
	public List<Section> sectionList;
	
	public List<Section> getSectionList() {
		return sectionList;
	}
	public void setSectionList(List<Section> sectionList) {
		this.sectionList = sectionList;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}
