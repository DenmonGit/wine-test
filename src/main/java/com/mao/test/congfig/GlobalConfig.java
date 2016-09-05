package com.mao.test.congfig;

import org.springframework.stereotype.Component;

/**
 * 配置变量
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Company: </p>
 * @author mao
 * @date 2016年8月13日 上午10:19:14
 */
@Component("globalConfig")
public class GlobalConfig {

	/*
	 * 图片相关内容
	 */
	private static String imgServer;
	private static String imgSetUrl;
	private static String projectServerName;
	private static String jttUrl;
	private static String wineLabelUrl;
	
	
	
	
	public static String getImgServer() {
		return imgServer;
	}
	public static void setImgServer(String imgServer) {
		GlobalConfig.imgServer = imgServer;
	}
	public static String getImgSetUrl() {
		return imgSetUrl;
	}
	public static void setImgSetUrl(String imgSetUrl) {
		GlobalConfig.imgSetUrl = imgSetUrl;
	}
	public static String getProjectServerName() {
		return projectServerName;
	}
	public static void setProjectServerName(String projectServerName) {
		GlobalConfig.projectServerName = projectServerName;
	}
	public static String getJttUrl() {
		return jttUrl;
	}
	public static void setJttUrl(String jttUrl) {
		GlobalConfig.jttUrl = jttUrl;
	}
	public static String getWineLabelUrl() {
		return wineLabelUrl;
	}
	public static void setWineLabelUrl(String wineLabelUrl) {
		GlobalConfig.wineLabelUrl = wineLabelUrl;
	}
	
	
	
}
