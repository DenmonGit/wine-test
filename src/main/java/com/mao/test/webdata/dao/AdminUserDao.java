package com.mao.test.webdata.dao;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mao.test.webdata.vo.AdminUserInfoVo;
import com.mao.test.webdata.vo.EasyTreeVo;
import com.mao.test.webdata.vo.ModulVo;
import com.mao.test.webdata.vo.RoleVo;

@Repository("adminUserDao")
public class AdminUserDao {
	public static String NAMESPACE="AdminUserDao.dao.";
	
	@Autowired
	private SqlSession sqlSession;
	

	public String getVersionInfo() {
		return sqlSession.selectOne(NAMESPACE+"getVersionInfo") ;
	}

	public AdminUserInfoVo adminLogin(String userName, String password) {
		Map<String,Object> para=new HashMap<>();
		para.put("loginName", userName);
		para.put("password", password);
		return sqlSession.selectOne(NAMESPACE+"adminLogin", para);
	}

	public List<ModulVo> getModulByParentId(int parentId) {
		return sqlSession.selectList(NAMESPACE+"getModulByParentId",parentId);
	}

	public List<ModulVo> getModulByParentAndRoleId(int parentId, int roleId) {
		Map<String,Object> para=new HashMap<>();
		para.put("parentId", parentId);
		para.put("roleId", roleId);
		return sqlSession.selectList(NAMESPACE+"getModulByParentAndRoleId",para);
	}

	public String getPassword(int id) {
		return sqlSession.selectOne(NAMESPACE+"getPassword", id);
	}

	public void updatePassword(int id, String password) {
		Map<String,Object> para=new HashMap<>();
		para.put("id", id);
		para.put("password", password);
		sqlSession.update(NAMESPACE+"updatePassword", para);
		
	}

	public List<EasyTreeVo> getModulTreeByParentId(int parentId) {
		return sqlSession.selectList(NAMESPACE+"getModulTreeByParentId",parentId);
	}

	public void deleteModul(int id) {
		sqlSession.delete(NAMESPACE+"deleteModul",id);
		
	}

	public void updateModul(String url, String modulName, int id, int index) {
		Map<String,Object> para=new HashMap<>();
		para.put("url", url);
		para.put("modulName", modulName);
		para.put("id", id);
		para.put("index", index);
		sqlSession.update(NAMESPACE+"updateModul",para);
	}

	public ModulVo getModulById(int id) {
		return sqlSession.selectOne(NAMESPACE+"getModulById",id);
	}

	public void insertModul(String url, String modulName, int parentId, int type, int index) {
		Map<String,Object> para=new HashMap<>();
		para.put("url", url);
		para.put("modulName", modulName);
		para.put("parentId", parentId);
		para.put("type", type);
		para.put("index", index);
		sqlSession.insert(NAMESPACE+"insertModul", para);
	}

	public List<RoleVo> getRoleList() {
		return sqlSession.selectList(NAMESPACE+"getRoleList");
	}

	public List<EasyTreeVo> getRoleCheckedModul(int parentId, int roleId) {
		Map<String,Object> para=new HashMap<String, Object>();
		para.put("parentId",parentId);
		para.put("roleId", roleId);
		return sqlSession.selectList(NAMESPACE+"getRoleCheckedModul", para);
	}

	public void roleDelete(int roleId) {
		sqlSession.delete(NAMESPACE+"roleDelete",roleId);
		
	}

	public void deleteRoleModul(int roleId) {
		sqlSession.delete(NAMESPACE+"deleteRoleModul", roleId);
	}
	
	public void insertRole(RoleVo vo) {
		
		sqlSession.insert(NAMESPACE+"insertRole", vo);
	}

	public void insertRoleModul(int roleId, Integer modulId) {
		Map<String,Object> para=new HashMap<>();
		para.put("roleId", roleId);
		para.put("modulId", modulId);
		sqlSession.insert(NAMESPACE+"insertRoleModul", para);
		
	}

	public void updateRoleName(RoleVo vo) {
		sqlSession.update(NAMESPACE+"updateRoleName",vo);
		
	}

	public List<AdminUserInfoVo> getAdminUserList(Map<String, Object> para) {
		return sqlSession.selectList(NAMESPACE+"getAdminUserList",para);
	}

	public long countAdminUserList() {
		return sqlSession.selectOne(NAMESPACE+"countAdminUserList");
	}

	public List<AdminUserInfoVo> getRoleIdAndName() {
		return sqlSession.selectList(NAMESPACE+"getRoleIdAndName");
	}

	public AdminUserInfoVo getAdminUserInfoById(int id) {
		return sqlSession.selectOne(NAMESPACE+"getAdminUserInfoById", id);
	}

	public void updateState(int id, int state) {
		Map<String,Object> para=new HashMap<>();
		para.put("id", id);
		para.put("state", state);
		sqlSession.update(NAMESPACE+"updateState", para);
		
	}

	public Object getAdminByName(String loginName) {
		return sqlSession.selectOne(NAMESPACE+"getAdminByName", loginName);
	}

	public void insertAdmin(Map<String, Object> para) {
		sqlSession.insert(NAMESPACE+"insertAdmin", para);
	}

}
