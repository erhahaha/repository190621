package com.nankai.bean;

public class Section_element {

	private int id;
	private int section_id;
	private int element_id;
	private String elecontent;
	
	private Section section;
	private Element element;
	
	public Section getSection() {
		return section;
	}
	public void setSection(Section section) {
		this.section = section;
	}
	public Element getElement() {
		return element;
	}
	public void setElement(Element element) {
		this.element = element;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getSection_id() {
		return section_id;
	}
	public void setSection_id(int section_id) {
		this.section_id = section_id;
	}
	public int getElement_id() {
		return element_id;
	}
	public void setElement_id(int element_id) {
		this.element_id = element_id;
	}
	public String getElecontent() {
		return elecontent;
	}
	public void setElecontent(String elecontent) {
		this.elecontent = elecontent;
	}
}
