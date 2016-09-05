package com.mao.test.entity;

import org.springframework.web.multipart.MultipartFile;

public class Image {
	private Integer id;
	private String server_path;
	private Integer type;
	
	private MultipartFile uploadFile;

	public Image(){
		
	}

	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getServer_path() {
		return server_path;
	}

	public void setServer_path(String server_path) {
		this.server_path = server_path;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public MultipartFile getUploadFile() {
		return uploadFile;
	}

	public void setUploadFile(MultipartFile uploadFile) {
		this.uploadFile = uploadFile;
	}
	
	@Override
	public String toString(){
		return "Image[id="+id+",server_path="+server_path+",type="+type+",uploadFile="+uploadFile+"]";
		
	}
	
}
