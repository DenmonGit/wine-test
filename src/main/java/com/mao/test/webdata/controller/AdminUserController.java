package com.mao.test.webdata.controller;

import java.io.IOException;
import java.util.List;

import javax.management.relation.Role;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.deser.Deserializers.Base;
import com.mao.test.common.BaseResponse;
import com.mao.test.common.BusinessException;
import com.mao.test.lock.LockService;
import com.mao.test.webdata.constants.ErrorCodeConstants;
import com.mao.test.webdata.service.AdminUserService;
import com.mao.test.webdata.vo.AdminUserInfoVo;
import com.mao.test.webdata.vo.EasyTreeVo;
import com.mao.test.webdata.vo.EasyUiComboBoxVo;
import com.mao.test.webdata.vo.EasyUiDataGrideVo;
import com.mao.test.webdata.vo.ModulVo;
import com.mao.test.webdata.vo.RoleVo;

@Controller
@RequestMapping("/webdata/admin")
//用户管理控制器
public class AdminUserController {
	private static final String ADMIN_INSERT_LOCK_KEY="admin:insert";
	private Logger LOG=LoggerFactory.getLogger(AdminUserController.class);

	private static String SAVE_LOCK_KEY="admin:save";
	
	@Autowired
	private AdminUserService adminUserService;
	
	//登录
	@RequestMapping(value="/login")
	public @ResponseBody BaseResponse<String> login(@RequestParam(required=true) String userName,
			@RequestParam(required=true) String password,HttpSession session){
		LOG.info("访问/admin/login,登录名是："+userName+"--密码是："+password);
		BaseResponse<String> br=new BaseResponse<>();
		adminUserService.login(userName,password,session);
				return br; 
		
	}
	//获取用户登录后的权限模块
	@RequestMapping("/modulList")
	public @ResponseBody BaseResponse<List<ModulVo>> getUserModul(HttpSession session){
		LOG.info("访问/modulList,"+session.getAttribute("adminInfo"));
		BaseResponse<List<ModulVo>> br=new BaseResponse<>();
		AdminUserInfoVo userInfo=(AdminUserInfoVo) session.getAttribute("userInfo");
		if(userInfo!=null){
			br.setObject(adminUserService.getModul(userInfo.getRoleId(),userInfo.getId()));
		}else{
			throw new BusinessException(ErrorCodeConstants.SESSION_TIME_OUT, "session过期");
		}
		return br;
	}
	//注销用户
	@RequestMapping("/logout")
	public void logout(HttpSession session,HttpServletResponse response){
		LOG.info("注销用户，访问/logout");
		session.removeAttribute("userInfo");
		session.removeAttribute("adminInfo");
		session.removeAttribute("versioninfo");
		try{
			response.sendRedirect("../");
		}catch(IOException ex){
			ex.printStackTrace();
		}
	}
	
	//修改密码
	@RequestMapping("/modifyPassword")
	public @ResponseBody BaseResponse<String> updateModifyPassword(HttpSession session,
			@RequestParam(required=true)String oldPassword,@RequestParam(required=true)String password){
		LOG.info("修改密码,访问/modifyPassword");
		BaseResponse<String> br=new BaseResponse<>();
		AdminUserInfoVo userInfo=(AdminUserInfoVo) session.getAttribute("userInfo");
		adminUserService.modifyPassword(userInfo.getId(),userInfo.getLoginName(),oldPassword,password);
		session.removeAttribute("userInfo");
		session.removeAttribute("adminInfo");
		session.removeAttribute("versionInfo");
		return br;
		
	}
	//获取模块树
	@RequestMapping("/modulTree")
	public @ResponseBody List<EasyTreeVo> getModulTree(){
		LOG.info("获取模块树，访问/modulTree");
		return adminUserService.getModulTree();
		
	}
	//删除模块
	@RequestMapping("/deleteModul")
	public @ResponseBody BaseResponse<String> deleteModul(@RequestParam(required=true)int id){
		LOG.info("删除模块或者节点,传入的id是："+id);
		BaseResponse<String> br=new BaseResponse<>();
		adminUserService.deleteModul(id);
		br.setErrmsg("删除模块或者节点成功！");
		return br;
		
	}
	//保存模块
	@RequestMapping("/saveModul")
	public @ResponseBody BaseResponse<String> saveModul(@RequestParam(required=true) int id,
			@RequestParam(required=true) int parentId,@RequestParam(required=true) String modulName,
			@RequestParam(required=false) String url,@RequestParam(required=true) int index){
		LOG.info("保存模块/saveModul");
		BaseResponse<String> br=new BaseResponse<>();
		try{
			LockService.tryLock(SAVE_LOCK_KEY);
			adminUserService.saveModul(id,parentId,modulName,url,index);
		}catch(BusinessException ex){
			if(ex.getErrorNum()==ErrorCodeConstants.LOCK_ERROR){
				br.setErrcode(ErrorCodeConstants.LOCK_ERROR);
				br.setErrmsg("正在处理。。。。请勿操作！");
			}else{
				throw ex;
			}
		}finally{
			LockService.unLock(SAVE_LOCK_KEY);
		}
		br.setErrmsg("保存模块成功");
				return br;
		
		
	}
	//模块详情
	@RequestMapping("/modulDetail")
	public @ResponseBody BaseResponse<ModulVo> modulDetail(@RequestParam(required=true)int id){
		LOG.info("访问模块详情:/modulDetail");
		BaseResponse<ModulVo> br=new BaseResponse<>();
		br.setObject(adminUserService.getModulById(id));
		return br;
	}
	//获取角色
	@RequestMapping("roleList")
	public @ResponseBody BaseResponse<List<RoleVo>> getRoleList(){
		LOG.info("访问角色列表：/roleList");
		BaseResponse<List<RoleVo>> br=new BaseResponse<>();
		br.setObject(adminUserService.getRoelList());
		return br;
		
	}
	//根据用户角色和用户的Id来获取权限树，有的打钩
	@RequestMapping("/roleCheckedModul")
	public @ResponseBody BaseResponse<List<EasyTreeVo>> getRoleCheckedModul(
			@RequestParam(required=true) int roleId){
		LOG.info("访问用户角色权限树"+roleId);
		BaseResponse<List<EasyTreeVo>> br=new BaseResponse<>();
		br.setObject(adminUserService.getRoleCheckedModul(roleId));
		return br;
	}
	//删除角色
	@RequestMapping("/roleDelete")
	public @ResponseBody BaseResponse<String> roleDelete(@RequestParam(required=true) int roleId){
		LOG.info("删除角色");
		BaseResponse<String> br=new BaseResponse<>();
		adminUserService.roleDelete(roleId);
		br.setErrmsg("删除角色成功");
		return br;
	}
	//保存角色
	@RequestMapping("/saveRole")
	public @ResponseBody BaseResponse<String> saveRole(@RequestParam(required=true)int roleId,
			@RequestParam(required=true) String modulIds,@RequestParam(required=true) String roleName){
		LOG.info("保存角色，访问/saveRoel");
		BaseResponse<String> br=new BaseResponse<>();
		adminUserService.saveRole(roleId,modulIds,roleName);
		br.setErrmsg("保存角色成功");
		return br;
		
	}
	//管理员用户列表显示
	@RequestMapping("/adminList")
	public @ResponseBody EasyUiDataGrideVo<AdminUserInfoVo> getAdminList(
			@RequestParam(required=false)String loginName,
			@RequestParam(required=false,defaultValue="0")int roleId,
			@RequestParam(required=false,defaultValue="1")int page,
			@RequestParam(required=false,defaultValue="15")int rows){
		LOG.info("访问管理员用户列表--loginName:"+loginName+"--roleId:"+roleId);
		return adminUserService.getAdminList(loginName,roleId,page,rows);
	}
	
	//获取角色列表
	@RequestMapping("/getRoleComboBox")
	public  @ResponseBody List<EasyUiComboBoxVo<AdminUserInfoVo>> getRoleComboBox(){
		LOG.info("访问角色列表");
		String flag="role";
		List<EasyUiComboBoxVo<AdminUserInfoVo>> comboxBox=adminUserService.getRoleComboBox(flag);
		return comboxBox;
		
	}
	//获取添加管理员时的角色列表
	@RequestMapping("/getAddRoleComboBox")
	public @ResponseBody List<EasyUiComboBoxVo<AdminUserInfoVo>> getAddRoleComboBox(){
		LOG.info("获得添加管理员时的角色列表");
		String flag="addRole";
		List<EasyUiComboBoxVo<AdminUserInfoVo>> comboxBox=adminUserService.getRoleComboBox(flag);
		return comboxBox;
	}
	//action 改变管理员的状态
	@RequestMapping("/action")
	public @ResponseBody BaseResponse<String> changeAdminState(@RequestParam(required=true)int id){
		LOG.info("改变管理员状态");
		BaseResponse<String> br=new BaseResponse<>();
		adminUserService.changeAdminState(id);
		return br;
		
	}
	//添加管理员用户
	@RequestMapping("/addAdminUser")
	public @ResponseBody BaseResponse<String> addAdminUser(String loginName,String password,String nickName,int roleId,int state){
		LOG.info("添加管理员用户");
		BaseResponse<String> br=new BaseResponse<>();
		try{
			LockService.tryLock(ADMIN_INSERT_LOCK_KEY+loginName);
			adminUserService.addAdminUser(loginName,password,nickName,roleId,state);
		}catch(BusinessException ex){
			if(ex.getErrorNum()==ErrorCodeConstants.LOCK_ERROR){
				br.setErrcode(ErrorCodeConstants.LOCK_ERROR);
				br.setErrmsg("正在处理请求。。。请勿连续操作！");
			}else{
				LockService.unLock(ADMIN_INSERT_LOCK_KEY+loginName);
			}
		}
		return br;
		
	}
	
}
