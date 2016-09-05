package com.mao.test.webdata.constants;
/**
 * 错误代码处理
 *
 */
public class ErrorCodeConstants {
	/**
	 * 0成功
	 */
	public static int RESULT_SUCCESS=0;
	/**
	 * 1参数错误
	 */
	public static int RESULT_PARAM_ERROR=1;
	
	/**
	 * 100锁获取错误
	 */
	public static int LOCK_ERROR=100;
	/**
	 * 997登录信息错误
	 */
	public static int RESULT_TOKEN_ERROR=997;
	/**
	 * -1 未定义的错误
	 */
	public static int SYSTEM_UNKNOW = -1;
	/**
	 * 999系统错误
	 */
	public static int SYSTEM_ERROR = 999;
	
	/**
	 * 998版本过低错误
	 */
	public static int VERSION_NO_ALLOW_ERROR=998;
	
	public static int SESSION_TIME_OUT = 996;
	
	public static String SYSTEM_UNKNOW_MESSAGE = "发生未知的异常情况";
	
	public static String SUPER_ADMIN_CODE ="super";
	
	public static String SUPER_ADMIN_PASSWORD ="super";
}
