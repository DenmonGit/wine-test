package com.mao.test.webdata.vo;

import java.util.List;

public class UserWineDetailVo {
	private List<String> img;
	private String remark;
	private String wineCode;
	private String userWineId;
	private String officalWineId;
	
	public String getUserWineId() {
		return userWineId;
	}
	public void setUserWineId(String userWineId) {
		this.userWineId = userWineId;
	}
	public List<String> getImg() {
		return img;
	}
	public void setImg(List<String> img) {
		this.img = img;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getWineCode() {
		return wineCode;
	}
	public void setWineCode(String wineCode) {
		this.wineCode = wineCode;
	}
	public String getOfficalWineId() {
		return officalWineId;
	}
	public void setOfficalWineId(String officalWineId) {
		this.officalWineId = officalWineId;
	}
	
	

}
