package com.mao.test.common;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mao.test.webdata.constants.ErrorCodeConstants;

//全局异常处理
@ControllerAdvice
public class GlobalExceptionHandler {

	private static final Log LOG=LogFactory.getLog(GlobalExceptionHandler.class);
	
	@ExceptionHandler
	public @ResponseBody BaseResponse<String> handle(BusinessException ex){
		BaseResponse<String> rep=new BaseResponse<>();
		LOG.error(ex.getErrorMessage());
		rep.setErrcode(ex.getErrorNum());
		rep.setErrmsg(ex.getErrorMessage());
		return rep;
		
	}
	
	@ExceptionHandler
	public @ResponseBody BaseResponse<String> handle(Exception ex){
		BaseResponse<String> rep=new BaseResponse<>();
		LOG.error(ex.getMessage());
		ex.printStackTrace();
		rep.setErrcode(ErrorCodeConstants.SYSTEM_ERROR);
		rep.setErrmsg(ex.getMessage());
		return rep;
		
	}
}
