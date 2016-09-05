package com.mao.test.webdatav1.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mao.test.webdatav1.vo.CabTempleteVo;

@Repository("cabTempleteDao")
public class CabTempleteDao {
	private String NAMESPACE="CabTempleteDao.dao.";
	@Autowired
	private SqlSession sqlSession;

	public List<CabTempleteVo> getListCabTemplete(Map<String, Object> para) {
		return sqlSession.selectList(NAMESPACE+"getListCabTemplete", para);
	}

	public long countCabTemplete() {
		return sqlSession.selectOne(NAMESPACE+"countCabTemplete");
	}

	public void inserCabTemplete(CabTempleteVo cabTempleteVo) {
		sqlSession.insert(NAMESPACE+"insertCabTemplete", cabTempleteVo);
	}

	public void deleteCab(String templeteId) {
		sqlSession.delete(NAMESPACE+"deleteCab", templeteId);
		
	}

	public CabTempleteVo getCabTempleteById(String templeteId) {
		return sqlSession.selectOne(NAMESPACE+"getCabTempleteById", templeteId);
	}

	public void updateCabTemplete(CabTempleteVo cabTempleteVo) {
		sqlSession.update(NAMESPACE+"updateCabTemplete", cabTempleteVo);
	}

}
