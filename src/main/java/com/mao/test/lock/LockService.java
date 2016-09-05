package com.mao.test.lock;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import com.mao.test.common.BusinessException;
import com.mao.test.webdata.constants.ErrorCodeConstants;

/**
 * 单服务器简单锁实现
 * 不适用多服务器
 * @author maoyaoke
 *
 */
public class LockService {
	private static Map<String, Long> lockMap=new ConcurrentHashMap<>();
	private static String KEY="LOCK";
	private static long LOCK_TIME_OUT=60*1000;//一分钟解除锁定
	public synchronized static void tryLock(String lockKey){
		Long key=lockMap.get(lockKey);
		if(key!=null&&(key+LOCK_TIME_OUT)>System.currentTimeMillis()){
			throw new BusinessException(ErrorCodeConstants.LOCK_ERROR,"事务正在提交。。。请稍后操作!");
			
		}else{
			lockMap.put(lockKey, System.currentTimeMillis());
		}
	}
	public synchronized static void unLock(String lockKey){
		lockMap.remove(lockKey);
	}

}
