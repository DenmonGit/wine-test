package com.mao.test.common;

import com.mao.test.webdata.constants.ErrorCodeConstants;

/**
 * 业务异常类
 * @author maoyaoke
 *
 */
public class BusinessException extends RuntimeException{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	Integer errorNum=ErrorCodeConstants.SYSTEM_UNKNOW;
	String errorMessage=ErrorCodeConstants.SYSTEM_UNKNOW_MESSAGE;
	
	public BusinessException(){}
	
	public BusinessException(int errorNum,String errorMessage){
		this.errorNum=errorNum;
		this.errorMessage=errorMessage;
		
	}

	public Integer getErrorNum() {
		return errorNum;
	}

	public void setErrorNum(Integer errorNum) {
		this.errorNum = errorNum;
	}

	public String getErrorMessage() {
		return errorMessage;
	}

	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}
	
	
}
