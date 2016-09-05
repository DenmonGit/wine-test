package com.mao.test.webdata.vo;

public class AdminUserInfoVo {
	private int id;
	private String nickName;
	private String loginName;
	private int roleId;
	private String roleName;
	private int state;

	public AdminUserInfoVo(){}
	
	public AdminUserInfoVo(int id,String nickName,String loginName,int roleId){
		this.id=id;
		this.nickName=nickName;
		this.loginName=loginName;
		this.roleId=roleId;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public int getRoleId() {
		return roleId;
	}

	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}
	
	
}
