package com.mao.test.entity;

public class AdVersion {
	private String adId;
	private String action;
	private String addTime;
	public AdVersion(){
		
	}
	public AdVersion(String action,String addTime,String adId){
		this.action=action;
		this.addTime=addTime;
		this.adId=adId;
	}
	
	
	
	public String getAdId() {
		return adId;
	}
	public void setAdId(String adId) {
		this.adId = adId;
	}
	public String getAction() {
		return action;
	}
	public void setAction(String action) {
		this.action = action;
	}
	public String getAddTime() {
		return addTime;
	}
	public void setAddTime(String addTime) {
		this.addTime = addTime;
	}
	

}
