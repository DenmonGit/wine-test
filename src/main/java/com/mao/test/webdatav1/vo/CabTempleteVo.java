package com.mao.test.webdatav1.vo;

import com.mao.test.util.DateHelper;

public class CabTempleteVo {

	private String templeteId;
	private String cabName;
	private int cabRow;
	private int cabColumn;
	private String addTime;
	private int totalUse;
	private String image;
	private String updateTime;
	private String background;
	private String status;
	
	public CabTempleteVo(){}
	public CabTempleteVo(String templeteId,String cabName,int cabRow,int cabColumn,String image,
			String background){
		this(templeteId, cabName, cabRow, cabColumn,DateHelper.getDateString(DateHelper.currentDate()) , 0, image, DateHelper.getDateString(DateHelper.currentDate()), background,"001");
	}
	public CabTempleteVo(String templeteId, String cabName, int cabRow, int cabColumn, String addTime, int totalUse,
			String image, String updateTime, String background, String status) {
		super();
		this.templeteId = templeteId;
		this.cabName = cabName;
		this.cabRow = cabRow;
		this.cabColumn = cabColumn;
		this.addTime = addTime;
		this.totalUse = totalUse;
		this.image = image;
		this.updateTime = updateTime;
		this.background = background;
		this.status = status;
	}
	@Override
	public String toString() {
		return "CabTempleteVo [templeteId=" + templeteId + ", cabName=" + cabName + ", cabRow=" + cabRow
				+ ", cabColumn=" + cabColumn + ", addTime=" + addTime + ", totalUse=" + totalUse + ", image=" + image
				+ ", updateTime=" + updateTime + ", background=" + background + "]";
	}
	public String getTempleteId() {
		return templeteId;
	}
	public void setTempleteId(String templeteId) {
		this.templeteId = templeteId;
	}
	public String getCabName() {
		return cabName;
	}
	public void setCabName(String cabName) {
		this.cabName = cabName;
	}
	public int getCabRow() {
		return cabRow;
	}
	public void setCabRow(int cabRow) {
		this.cabRow = cabRow;
	}
	public int getCabColumn() {
		return cabColumn;
	}
	public void setCabColumn(int cabColumn) {
		this.cabColumn = cabColumn;
	}
	public String getAddTime() {
		return addTime;
	}
	public void setAddTime(String addTime) {
		this.addTime = addTime;
	}
	public int getTotalUse() {
		return totalUse;
	}
	public void setTotalUse(int totalUse) {
		this.totalUse = totalUse;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}
	public String getBackground() {
		return background;
	}
	public void setBackground(String background) {
		this.background = background;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	
	
	
	
   
}
