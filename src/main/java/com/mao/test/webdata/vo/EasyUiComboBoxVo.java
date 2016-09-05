package com.mao.test.webdata.vo;

public class EasyUiComboBoxVo<T> {

	private String id;
	private String text;
	private String group;
	private T otherType;
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getGroup() {
		return group;
	}
	public void setGroup(String group) {
		this.group = group;
	}
	public T getOtherType() {
		return otherType;
	}
	public void setOtherType(T otherType) {
		this.otherType = otherType;
	}
	
	
	
}
