package com.mao.test.webdata.vo;

import java.util.List;

public class ModulVo {

	private int id;
	private String modulName;
	private String url;
	private int type;
	private int index;
	private List<ModulVo> children;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getModulName() {
		return modulName;
	}
	public void setModulName(String modulName) {
		this.modulName = modulName;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public int getIndex() {
		return index;
	}
	public void setIndex(int index) {
		this.index = index;
	}
	public List<ModulVo> getChildren() {
		return children;
	}
	public void setChildren(List<ModulVo> children) {
		this.children = children;
	}
	
	
}
