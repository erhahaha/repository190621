package com.nankai.bean;

public class EleOverProof {

	private int year;
	private long sectionID;
	private String regionID;
	private String name;//农产品名
	private int EleNum;
	private double elecontent;
	private String topline;
	private double pn;//单因子指数
	
	
	
	public double getPn() {
		return pn;
	}
	public void setPn(double pn) {
		this.pn = pn;
	}
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public long getSectionID() {
		return sectionID;
	}
	public void setSectionID(long sectionID) {
		this.sectionID = sectionID;
	}
	public String getRegionID() {
		return regionID;
	}
	public void setRegionID(String regionID) {
		this.regionID = regionID;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getEleNum() {
		return EleNum;
	}
	public void setEleNum(int eleNum) {
		EleNum = eleNum;
	}
	public double getElecontent() {
		return elecontent;
	}
	public void setElecontent(double elecontent) {
		this.elecontent = elecontent;
	}
	public String getTopline() {
		return topline;
	}
	public void setTopline(String topline) {
		this.topline = topline;
	}
	
	
	
	
	
	
}
