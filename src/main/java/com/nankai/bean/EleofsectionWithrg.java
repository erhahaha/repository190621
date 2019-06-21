package com.nankai.bean;

import java.io.Serializable;

public class EleofsectionWithrg  implements Serializable {
	private static final long serialVersionUID = 1L;

	private int sectionID;
	private String sectionNumber;
	private int year;
	private String longitude;
	private String latitude;
	private int region_id;
	private String regionName;
	private int element_id;
	public int getSectionID() {
		return sectionID;
	}
	public void setSectionID(int sectionID) {
		this.sectionID = sectionID;
	}
	public String getSectionNumber() {
		return sectionNumber;
	}
	public void setSectionNumber(String sectionNumber) {
		this.sectionNumber = sectionNumber;
	}
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public int getRegion_id() {
		return region_id;
	}
	public void setRegion_id(int region_id) {
		this.region_id = region_id;
	}
	public String getRegionName() {
		return regionName;
	}
	public void setRegionName(String regionName) {
		this.regionName = regionName;
	}
	public int getElement_id() {
		return element_id;
	}
	public void setElement_id(int element_id) {
		this.element_id = element_id;
	}
	public String getEleName() {
		return eleName;
	}
	public void setEleName(String eleName) {
		this.eleName = eleName;
	}
	public String getElecontent() {
		return elecontent;
	}
	public void setElecontent(String elecontent) {
		this.elecontent = elecontent;
	}
	private String eleName;
	private String elecontent;
}
