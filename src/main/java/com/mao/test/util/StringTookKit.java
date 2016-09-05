package com.mao.test.util;

import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class StringTookKit {

	private final static Logger LOG=LoggerFactory.getLogger(StringTookKit.class);

	public static boolean judgeString(String str) {
		boolean flag=false;
		if(str!=null&&!(str.trim()).equals("")&&!str.equalsIgnoreCase("null")){
			flag=true;
		}
		return flag;
	}

	/**
	 * 获取32位UUID
	 * @return
	 */
	 public static String get32BitUUID() {
		return UUID.randomUUID().toString().replace("-", "");
	}
	
}
