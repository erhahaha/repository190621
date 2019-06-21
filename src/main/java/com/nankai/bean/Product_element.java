package com.nankai.bean;

public class Product_element {

	private int id;
	private int product_id;
	private int element_id;
	
	
	private Product product;
	private Element element;
	
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
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
	public int getProduct_id() {
		return product_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
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
	private String elecontent;
}
