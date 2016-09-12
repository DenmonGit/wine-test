package com.mao.test.webdatav1.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mao.test.webdatav1.vo.BrandListVo;

@Repository("brandDao")
public class BrandDao {
	private String NAMESPACE="brandDao.dao.";
	@Autowired
	private SqlSession sqlSession;

	public void deleteBrandByChateauCode(String code) {
		
		
	}

	public List<BrandListVo> getBrandList(Map<String, Object> para) {
		return sqlSession.selectList(NAMESPACE+"getBrandList", para);
	}

	public long countBrandList(Map<String, Object> para) {
		return sqlSession.selectOne(NAMESPACE+"countBrandList", para);
	}

	public String getMaxBrandCode(String chateauCode) {
		System.out.println("the maxBrandCode:"+sqlSession.selectOne(NAMESPACE+"getMaxBrandCode", chateauCode));
		return sqlSession.selectOne(NAMESPACE+"getMaxBrandCode", chateauCode);
	}

	public int checkBrandIsExist(String brandCode) {
		return sqlSession.selectOne(NAMESPACE+"checkBrandIsExist", brandCode);
	}

	public void addBrandDict(Map<String, Object> para) {
		sqlSession.insert(NAMESPACE+"addBrandDict", para);
		
	}

	public void updateBrandDictParentName(Map<String, Object> para) {
		sqlSession.update(NAMESPACE+"updateBrandDictParentName", para);
		
	}

	public void updateBrandDict(Map<String, Object> para) {
		sqlSession.update(NAMESPACE+"updateBrandDict", para);
		
	}

	public void deleteBrandDict(String id) {
		sqlSession.delete(NAMESPACE+"deleteBrandDict", id);
		
	}

}
