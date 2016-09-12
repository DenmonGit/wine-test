package com.mao.test.webdatav1.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mao.test.webdata.vo.EasyUiComboBoxVo;
import com.mao.test.webdatav1.vo.ChateauParentNameVo;
import com.mao.test.webdatav1.vo.ChateauVo;

@Repository("chateauDao")
public class ChateauDao {
	private String NAMESPACE="ChateauDao.dao.";

	@Autowired
	private SqlSession sqlSession;
	
	public List<ChateauVo> getChateauList(Map<String, Object> para) {
		return sqlSession.selectList(NAMESPACE+"getChateauList",para);
	}

	public long countChateauList(Map<String, Object> para) {
		return sqlSession.selectOne(NAMESPACE+"countChateauList", para);
	}

	public String getMaxChateauCode(String areaCode) {
		//System.out.println("the MaxCode:"+sqlSession.selectOne(NAMESPACE+"getMaxChateauCode", areaCode));
		return sqlSession.selectOne(NAMESPACE+"getMaxChateauCode", areaCode);
		
	}

	public int checkChateauIsExist(String chateaucode) {
		return sqlSession.selectOne(NAMESPACE+"checkChateauIsExist", chateaucode);
	}

	public void addChateauDict(Map<String, Object> para) {
		sqlSession.insert(NAMESPACE+"addChateauDict", para);
		
	}

	public void updateAddChateauDictArea(Map<String, Object> paraForArea) {
		sqlSession.update(NAMESPACE+"updateAddChateauDictArea", paraForArea);
		
	}

	public void updateChateauDict(Map<String, Object> para) {
		sqlSession.update(NAMESPACE+"updateChateauDict", para);
		
	}

	public ChateauVo getChateauByid(String code) {
		return sqlSession.selectOne(NAMESPACE+"getChateauBycode", code);
	}

	public void deleteChateau(String code) {
		sqlSession.delete(NAMESPACE+"deleteChateau", code);
	}

	public List<EasyUiComboBoxVo<String>> getChateauByAreaCode(String areaCode) {
		return sqlSession.selectList(NAMESPACE+"getChateauByAreaCode", areaCode);
	}

	public ChateauParentNameVo getParentStrByCode(String chateauCode) {
		return sqlSession.selectOne(NAMESPACE+"getParentStrByCode", chateauCode);
	}

}
