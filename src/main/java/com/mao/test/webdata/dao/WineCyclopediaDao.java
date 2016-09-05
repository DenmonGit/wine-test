package com.mao.test.webdata.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mao.test.webdata.vo.WineCyclopediaVo;
import com.mao.test.webdata.vo.WineTypeVo;

@Repository("wineCyclopediaDao")
public class WineCyclopediaDao {

	private static String NAMESPACE="WineCyclopediaDao.dao.";
	@Autowired
	private SqlSession sqlSession;
	

	public List<WineCyclopediaVo> getWineDataGrid(Map<String, Object> para) {
		return sqlSession.selectList(NAMESPACE+"getWineDataGrid",para);
	}
	
	public long countWineCyclopedia(Map<String, Object> para) {
		return sqlSession.selectOne(NAMESPACE+"countWineCyclopedia", para);
	}
	public List<WineTypeVo> getWineTypeByIdAndName() {
		return sqlSession.selectList(NAMESPACE+"getWineTypeByIdAndName");
	}

	public void addWine(WineCyclopediaVo vo) {
		sqlSession.insert(NAMESPACE+"addWine", vo);
		
	}

	public void deleteWine(String id) {
		sqlSession.delete(NAMESPACE+"deleteWine", id);
		
	}

	public WineCyclopediaVo getWineById(String id) {
		return sqlSession.selectOne(NAMESPACE+"getWineById",id);
	}

	public void updateWine(WineCyclopediaVo vo) {
		sqlSession.update(NAMESPACE+"updateWine", vo);
		
	}

	public void deleteWineByType(Integer id) {
		sqlSession.delete(NAMESPACE+"deleteWineByType", id);
		
	}
}
