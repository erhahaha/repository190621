package com.nankai.bean;

import java.util.List;

public class Element {
	
	private int id;
	private String name;
	
	//一种重金属对应多个农作物
	public List<Product> productList;
	
	//一种重金属对应多个地段
	public List<Section> sectionList;
	
	public List<Product> getProductList() {
		return productList;
	}
	public void setProductList(List<Product> productList) {
		this.productList = productList;
	}
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
