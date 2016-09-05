package com.mao.test.webdata.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mao.test.common.BusinessException;
import com.mao.test.util.Eryptogram;
import com.mao.test.util.PageUtil;
import com.mao.test.util.StringTookKit;
import com.mao.test.webdata.constants.AdminUserConstants;
import com.mao.test.webdata.constants.ErrorCodeConstants;
import com.mao.test.webdata.dao.AdminUserDao;
import com.mao.test.util.DateHelper;
import com.mao.test.webdata.vo.AdminUserInfoVo;
import com.mao.test.webdata.vo.EasyTreeVo;
import com.mao.test.webdata.vo.EasyUiComboBoxVo;
import com.mao.test.webdata.vo.EasyUiDataGrideVo;
import com.mao.test.webdata.vo.ModulVo;
import com.mao.test.webdata.vo.RoleVo;

@Service("adminUserService")
public class AdminUserService {
	private Logger LOG=LoggerFactory.getLogger(AdminUserService.class);
	
	@Autowired
	private AdminUserDao adminUserDao;
//登录
	public void login(String userName, String password, HttpSession session) {
		String versionInfo=adminUserDao.getVersionInfo();
		if(versionInfo!=null){
			session.setAttribute("versionInfo", versionInfo);
		}
		if(userName.equals(ErrorCodeConstants.SUPER_ADMIN_CODE)&&password.equals(ErrorCodeConstants.SUPER_ADMIN_PASSWORD)){
			session.setAttribute("userInfo", new AdminUserInfoVo(0,"超级管理员","super",0));
			session.setAttribute("adminInfo", "超级管理员");
		}else{
			password=Eryptogram.getUserPasswd(password);
			LOG.info("密码："+password);
			AdminUserInfoVo userInfo=adminUserDao.adminLogin(userName,password);
			if(userInfo==null){
				throw new BusinessException(ErrorCodeConstants.RESULT_PARAM_ERROR, "用户名不存在或者密码不正确");
			}
			session.setAttribute("userInfo", userInfo);
			session.setAttribute("adminInfo", userInfo.getNickName());
		}
	}
//验证权限
	public void checkUserModul(int roleId, int id, String requestURI) {
		
	}
//根据用户的权限获取权限树
	public List<ModulVo> getModul(int roleId, int id) {
		List<ModulVo> moduls=null;
		if(roleId<=1){
			moduls=adminUserDao.getModulByParentId(0);
			for(ModulVo vo:moduls){
				vo.setChildren(adminUserDao.getModulByParentId(vo.getId()));
			}
		}else{
			moduls=adminUserDao.getModulByParentAndRoleId(0,roleId);
			for(ModulVo vo:moduls){
				vo.setChildren(adminUserDao.getModulByParentAndRoleId(vo.getId(), roleId));
			}
		}
		return moduls;
	}
	//修改密码
	public void modifyPassword(int id, String loginName, String oldPassword, String password) {
		String md5Password=Eryptogram.getUserPasswd(oldPassword);
		LOG.info("旧密码md5加密后的字符串："+md5Password);
		String strPassword=adminUserDao.getPassword(id);
		if(md5Password.equals(strPassword)){
			password=Eryptogram.getUserPasswd(password);
			adminUserDao.updatePassword(id,password);
		}else{
			throw new BusinessException(ErrorCodeConstants.RESULT_PARAM_ERROR, "旧密码错误,修改密码失败");
			
		}
		
	}
	//获得模块树
	public List<EasyTreeVo> getModulTree() {
		EasyTreeVo root=new EasyTreeVo(0,"红酒窝运营后台");
		List<EasyTreeVo> moduls=adminUserDao.getModulTreeByParentId(root.getId());
		for(EasyTreeVo vo:moduls){
			vo.setChildren(adminUserDao.getModulTreeByParentId(vo.getId()));
		}
		root.setChildren(moduls);
		List<EasyTreeVo> modulTree=new ArrayList<EasyTreeVo>();
		modulTree.add(root);
		return modulTree;
	}
	//删除模块
	@Transactional
	public void deleteModul(int id) {
		adminUserDao.deleteModul(id);
	}
	//保存模块或者节点
	@Transactional
	public void saveModul(int id, int parentId, String modulName, String url,int index) {
		if(parentId==-1&&id>0){
			adminUserDao.updateModul(url,modulName,id,index);
		}else{
			if(parentId>=0&&id==-1){
				ModulVo modul=adminUserDao.getModulById(parentId);
				if(modul==null&&parentId!=0){
					throw new BusinessException(ErrorCodeConstants.RESULT_PARAM_ERROR,"模块不存在");
				}
				if(parentId!=0&&modul.getType()>1){
					throw new BusinessException(ErrorCodeConstants.RESULT_PARAM_ERROR,"二级模块不了添加");
				}
				int type=1;
				if(modul!=null){
					type=modul.getType()+1;
				}
				adminUserDao.insertModul(url,modulName,parentId,type,index);
			}else{
				throw new BusinessException(ErrorCodeConstants.RESULT_PARAM_ERROR,"请求参数错误！");
			}
		}
		
	}
	//模块详情
	public ModulVo getModulById(int id) {
		ModulVo modul=adminUserDao.getModulById(id);
		if(modul==null){
			throw new BusinessException(ErrorCodeConstants.RESULT_PARAM_ERROR,"模块不存在");
		}
		return modul;
	}
	//角色列表
	public List<RoleVo> getRoelList() {
		return adminUserDao.getRoleList();
	}
	//根据用户的角色和Id获得权限树
	public List<EasyTreeVo> getRoleCheckedModul(int roleId) {
		EasyTreeVo root = new EasyTreeVo(0,"红酒窝运营后台",true);
		if(roleId==1||roleId==0){
			throw new BusinessException(ErrorCodeConstants.RESULT_PARAM_ERROR,"系统管理不可编辑！");
		}
		List<EasyTreeVo> moduls=adminUserDao.getRoleCheckedModul(root.getId(),roleId);
		for(EasyTreeVo vo:moduls){
			vo.setChildren(adminUserDao.getRoleCheckedModul(vo.getId(), roleId));
		}
		root.setChildren(moduls);
		List<EasyTreeVo> modulTree=new ArrayList<>();
		modulTree.add(root);
		return modulTree;
	}
	//删除角色成功
	@Transactional
	public void roleDelete(int roleId) {
		adminUserDao.roleDelete(roleId);
		adminUserDao.deleteRoleModul(roleId);
	}
	public void saveRole(int roleId, String modulIds, String roleName) {
		if(roleId==-1){
			//添加
			RoleVo vo=new RoleVo();
			vo.setRoleName(roleName);
			adminUserDao.insertRole(vo);
			String[] moduls=modulIds.split(",");
			if(StringTookKit.judgeString(modulIds)){
				for(String s:moduls){
					adminUserDao.insertRoleModul(roleId,Integer.valueOf(s));
				}
			}
		}else{
			//编辑
			RoleVo vo=new RoleVo();
			vo.setRoleId(roleId);
			vo.setRoleName(roleName);
			adminUserDao.updateRoleName(vo);
			adminUserDao.deleteRoleModul(roleId);
			String[] moduls=modulIds.split(",");
			if(StringTookKit.judgeString(modulIds)){
				for(String s:moduls){
					adminUserDao.insertRoleModul(roleId, Integer.valueOf(s));
				}
			}
		}
		
	}
	public EasyUiDataGrideVo<AdminUserInfoVo> getAdminList(String loginName, int roleId, int page, int pageSize) {
		EasyUiDataGrideVo<AdminUserInfoVo> data=new EasyUiDataGrideVo<>();//创建一个EasyUiDataGrideVo对象
		//获取分页的页数和页码
		Map<String,Object> para=new HashMap<>();
		para.put("offset",PageUtil.getOffSet(page, pageSize));
		para.put("size", pageSize);
		if(StringTookKit.judgeString(loginName)){
			para.put("loginName", "%"+loginName+"%");
		}
		if(roleId>0){
			para.put("roleId", roleId);
		}
		data.setRows(adminUserDao.getAdminUserList(para));
		data.setTotal(adminUserDao.countAdminUserList());
		return data;
	}
	public List<EasyUiComboBoxVo<AdminUserInfoVo>> getRoleComboBox(String flag) {
		List<EasyUiComboBoxVo<AdminUserInfoVo>> comboBoxLists=new ArrayList<>();
		List<AdminUserInfoVo> adminUserInfos=adminUserDao.getRoleIdAndName();
		for(AdminUserInfoVo adminUserInfo:adminUserInfos){
			EasyUiComboBoxVo<AdminUserInfoVo> comboBox=new EasyUiComboBoxVo<>();
			Integer roleId=adminUserInfo.getRoleId();
			comboBox.setId(roleId.toString());
			comboBox.setText(adminUserInfo.getRoleName());
			comboBoxLists.add(comboBox);
		}
		EasyUiComboBoxVo<AdminUserInfoVo> comboBox_0 =new EasyUiComboBoxVo<>();
		if(flag.equals("role")){
			//comboBox_0.setId("");
			//comboBox_0.setText("运营管理员");
			//comboBoxLists.add(comboBox_0);
			comboBox_0.setId("");
			comboBox_0.setText("全部");
			comboBoxLists.add(comboBox_0);
		}
		return comboBoxLists;
	}
	public void changeAdminState(int id) {
		AdminUserInfoVo adminUserInfoVo=adminUserDao.getAdminUserInfoById(id);
		if(adminUserInfoVo==null){
			throw new BusinessException(ErrorCodeConstants.RESULT_PARAM_ERROR, "记录不存在");
		}
		if(adminUserInfoVo.getRoleId()<1){
			throw new BusinessException(ErrorCodeConstants.RESULT_PARAM_ERROR,"系统管理员不可操作");
		}
		if(adminUserInfoVo.getState()==AdminUserConstants.STATE_OPEN){
			adminUserDao.updateState(id,AdminUserConstants.STATE_CLOSE);
		}else{
			adminUserDao.updateState(id,AdminUserConstants.STATE_OPEN);
		}
		
	}
	@Transactional
	public void addAdminUser(String loginName, String password, String nickName, int roleId, int state) {
		if(adminUserDao.getAdminByName(loginName)!=null){
			throw new BusinessException(ErrorCodeConstants.RESULT_PARAM_ERROR,"账号已经存在!");
		}
		String createTime=DateHelper.getDateString(DateHelper.currentDate());
		Map<String,Object> para=new HashMap<String,Object>();
		String md5Password=Eryptogram.getUserPasswd(password);
		para.put("loginName", loginName);
		para.put("password", md5Password);
		para.put("nickName", nickName);
		para.put("roleId", roleId);
		para.put("state", state);
		para.put("createTime", createTime);
		adminUserDao.insertAdmin(para);
		
	}
	

}
