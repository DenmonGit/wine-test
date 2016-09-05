package com.mao.test.filter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.mao.test.webdata.service.AdminUserService;
import com.mao.test.webdata.vo.AdminUserInfoVo;

/**
 * 版本号拦截器
 * @author maoyaoke
 *
 */
public class SessionInterceptor implements HandlerInterceptor {
	private Logger LOG=LoggerFactory.getLogger(SessionInterceptor.class);
	
	@Autowired
	private AdminUserService adminUserService;
	

	public void afterCompletion(HttpServletRequest arg0, 
			HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		

	}

	public void postHandle(HttpServletRequest arg0,
			HttpServletResponse arg1, Object arg2, ModelAndView arg3)
			throws Exception {
		
		

	}

	public boolean preHandle(HttpServletRequest arg0, 
			HttpServletResponse arg1, Object arg2) throws Exception {
		
		LOG.info("在拦截器前处理");
		String basePath=arg0.getScheme()+"://"+arg0.getServerName()+":"+arg0.getServerPort()+arg0.getContextPath()+"/";
		HttpSession session=arg0.getSession();
		String adminInfo=(String) session.getAttribute("adminInfo");
		if(adminInfo==null||adminInfo.trim().equals("")){
			arg1.sendRedirect(basePath+"jf/index.jsp");
			return false;
		}
		AdminUserInfoVo userInfo=(AdminUserInfoVo) session.getAttribute("userInfo");
		if(userInfo==null){
			arg1.sendRedirect(basePath+"jf/index.jsp");
			return false;
		}
		adminUserService.checkUserModul(userInfo.getRoleId(),userInfo.getId(),arg0.getRequestURI());;
		return true;	
	}

}
