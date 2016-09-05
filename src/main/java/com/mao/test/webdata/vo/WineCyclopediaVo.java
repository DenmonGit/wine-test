package com.mao.test.webdata.vo;

import com.mao.test.congfig.GlobalConfig;

public class WineCyclopediaVo {

	private String id;
	private String title;
	private String content;
	private Integer typeId;
	private String addTime;
	private String updateTime;
	private String authorId;
	private String cover;
	private String status;
	private Integer orderNumber;
	private Integer operateType;
	private String outsideUrl;
	
	public WineCyclopediaVo(){
		
	}
	public WineCyclopediaVo(WineCyclopediaVo vo){
		id=vo.getId();
		title=vo.getTitle();
		content=vo.getContent();
		typeId=vo.getTypeId();
		addTime=vo.getAddTime();
		updateTime=vo.getUpdateTime();
		authorId=vo.getAuthorId();
		cover=GlobalConfig.getProjectServerName()+vo.getCover();
		status=vo.getStatus();
		orderNumber=vo.getOrderNumber();
		operateType=vo.getOperateType();
		outsideUrl=vo.getOutsideUrl();
	}
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Integer getTypeId() {
		return typeId;
	}
	public void setTypeId(Integer typeId) {
		this.typeId = typeId;
	}
	public String getAddTime() {
		return addTime;
	}
	public void setAddTime(String addTime) {
		this.addTime = addTime;
	}
	public String getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}
	public String getAuthorId() {
		return authorId;
	}
	public void setAuthorId(String authorId) {
		this.authorId = authorId;
	}
	public String getCover() {
		return cover;
	}
	public void setCover(String cover) {
		this.cover = cover;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Integer getOrderNumber() {
		return orderNumber;
	}
	public void setOrderNumber(Integer orderNumber) {
		this.orderNumber = orderNumber;
	}
	public Integer getOperateType() {
		return operateType;
	}
	public void setOperateType(Integer operateType) {
		this.operateType = operateType;
	}
	public String getOutsideUrl() {
		return outsideUrl;
	}
	public void setOutsideUrl(String outsideUrl) {
		this.outsideUrl = outsideUrl;
	}
	
	
}
