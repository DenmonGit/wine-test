package com.mao.test.webdata.vo;

import com.fasterxml.jackson.annotation.JsonIgnore;

public class ResultVo<T> {
	
	@JsonIgnore
	public static int SUCCESS=1;
	@JsonIgnore
	public static int FAILED=0;

	private int result;
	private String message="失败消息";
	private String error_code;
	private T object;
	
	public int getResult() {
		return result;
	}
	public void setResult(int result) {
		this.result = result;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getError_code() {
		return error_code;
	}
	public void setError_code(String error_code) {
		this.error_code = error_code;
	}
	public T getObject() {
		return object;
	}
	public void setObject(T object) {
		this.object = object;
	}
	
	
}
