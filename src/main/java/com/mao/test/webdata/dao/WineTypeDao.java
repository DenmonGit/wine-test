package com.mao.test.webdata.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mao.test.webdata.vo.EasyUiComboBoxVo;
import com.mao.test.webdata.vo.WineTypeVo;

@Repository("wineTypeDao")
public class WineTypeDao {
	private static String NAMESPACE="WineTypeDao.dao.";
	@Autowired
	private SqlSession sqlSession;

	public List<EasyUiComboBoxVo> getWineType() {
		return sqlSession.selectList(NAMESPACE+"getWineType");
	}

	public List<WineTypeVo> getWineTypeList(Map<String, Object> para) {
		return sqlSession.selectList(NAMESPACE+"getWineTypeList", para);
	}

	public long countWinetype(Map<String, Object> para) {
		return sqlSession.selectOne(NAMESPACE+"countWinetype", para);
	}

	public void addWineType(WineTypeVo wineTypeVo) {
		sqlSession.insert(NAMESPACE+"addWineType", wineTypeVo);
	}

	public void updateWineType(WineTypeVo wineTypeVo) {
		sqlSession.update(NAMESPACE+"updateWineType", wineTypeVo);
		
	}

	public WineTypeVo getWineTypeById(Integer id) {
		return sqlSession.selectOne(NAMESPACE+"getWineTypeById", id);
	}

	public void deletewineType(Integer id) {
		sqlSession.delete(NAMESPACE+"deletewineType", id);
		
	}

}
