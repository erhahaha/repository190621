package com.nankai.bean;

import java.io.Serializable;
/*
 * @
 */
//编写一个包装类
public class ResultInfoVO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/*
	 * 返回成功
	 */
	public static final int OK = 0;
	public static final int ERROR = 1;
	
	private Object object;
	private String rtnMessage;
	
	private Integer result;
	
	private String msgCode;//第三方消息码
	
	public Object getObject() {
		return object;
	}

	public void setObject(Object object) {
		this.object = object;
	}

	public String getRtnMessage() {
		return rtnMessage;
	}

	public void setRtnMessage(String rtnMessage) {
		this.rtnMessage = rtnMessage;
	}

	public Integer getResult() {
		return result;
	}

	public void setResult(Integer result) {
		this.result = result;
	}

	public String getMsgCode() {
		return msgCode;
	}

	public void setMsgCode(String msgCode) {
		this.msgCode = msgCode;
	}

	public static int getError() {
		return ERROR;
	}

	
	
}
