package com.mao.test.webdata.vo;

public class AdVo {
	private String adId;
	private String author;
	private String title;
	private String cover;
	private String content;
	private String status;
	private String addTime;
	private String releaseTime;
	private int operatorType;
	private String wineStoreAddr;
	
	public AdVo(){}
	public AdVo(String adId,String author,String title,String cover,String content,String status,
			String addTime,String releaseTime,int operatorType,String wineStoreAddr){
		
		this.adId=adId;
		this.author=author;
		this.title=title;
		this.cover=cover;
		this.status=status;
		this.addTime=addTime;
		this.releaseTime=releaseTime;
		this.operatorType=operatorType;
		this.wineStoreAddr=wineStoreAddr;
	}
	
	public String getAdId() {
		return adId;
	}
	public void setAdId(String adId) {
		this.adId = adId;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCover() {
		return cover;
	}
	public void setCover(String cover) {
		this.cover = cover;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getAddTime() {
		return addTime;
	}
	public void setAddTime(String addTime) {
		this.addTime = addTime;
	}
	public String getReleaseTime() {
		return releaseTime;
	}
	public void setReleaseTime(String releaseTime) {
		this.releaseTime = releaseTime;
	}
	public int getOperatorType() {
		return operatorType;
	}
	public void setOperatorType(int operatorType) {
		this.operatorType = operatorType;
	}
	public String getWineStoreAddr() {
		return wineStoreAddr;
	}
	public void setWineStoreAddr(String wineStoreAddr) {
		this.wineStoreAddr = wineStoreAddr;
	}
	
	
	
	

}
