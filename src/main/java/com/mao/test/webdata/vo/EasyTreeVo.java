package com.mao.test.webdata.vo;

import java.util.List;

public class EasyTreeVo {
	private int id;
	private String text;
	private List<EasyTreeVo> children;
	private boolean checked;
	public EasyTreeVo(){}
	public EasyTreeVo(int id,String text){
		this.id=id;
		this.text=text;
	}
	public EasyTreeVo(int id,String text,boolean checked){
		this.id=id;
		this.text=text;
		this.checked=checked;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public List<EasyTreeVo> getChildren() {
		return children;
	}
	public void setChildren(List<EasyTreeVo> children) {
		this.children = children;
	}
	public boolean isChecked() {
		return checked;
	}
	public void setChecked(boolean checked) {
		this.checked = checked;
	}
	
	

}
