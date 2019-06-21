package com.nankai.bean;

import java.io.Serializable;

public class BasicInfo  implements Serializable {
	private static final long serialVersionUID = 1L;

	private String name;
	private int year;
	private String sectionNumber;
	private String Cproduct;
	private String ElemCd;
	private String ElemHg;
	private String ElemAs;
	private String ElemCu;
	private String ElemPb;
	private String ElemCr;
	private String ElemZn;
	private String ElemNi;
	private String ElemPH;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public String getsectionNumber() {
		return sectionNumber;
	}
	public void setsectionNumber(String sectionNumber) {
		this.sectionNumber = sectionNumber;
	}
	public String getCproduct() {
		return Cproduct;
	}
	public void setCproduct(String cproduct) {
		this.Cproduct = cproduct;
	}
	public String getElemCd() {
		return ElemCd;
	}
	public void setElemCd(String elemCd) {
		this.ElemCd = elemCd;
	}
	public String getElemHg() {
		return ElemHg;
	}
	public void setElemHg(String elemHg) {
		this.ElemHg = elemHg;
	}
	public String getElemAs() {
		return ElemAs;
	}
	public void setElemAs(String elemAs) {
		this.ElemAs = elemAs;
	}
	public String getElemCu() {
		return ElemCu;
	}
	public void setElemCu(String elemCu) {
		this.ElemCu = elemCu;
	}
	public String getElemPb() {
		return ElemPb;
	}
	public void setElemPb(String elemPb) {
		this.ElemPb = elemPb;
	}
	public String getElemCr() {
		return ElemCr;
	}
	public void setElemCr(String elemCr) {
		this.ElemCr = elemCr;
	}
	public String getElemZn() {
		return ElemZn;
	}
	public void setElemZn(String elemZn) {
		this.ElemZn = elemZn;
	}
	public String getElemNi() {
		return ElemNi;
	}
	public void setElemNi(String elemNi) {
		this.ElemNi = elemNi;
	}
	public String getElemPH() {
		return ElemPH;
	}
	public void setElemPH(String elemPH) {
		this.ElemPH = elemPH;
	}
}
