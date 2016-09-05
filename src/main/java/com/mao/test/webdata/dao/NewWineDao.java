package com.mao.test.webdata.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mao.test.webdata.vo.NewWineVo;

@Repository("newWineDao")
public class NewWineDao {
	private String NAMESPACE="NewWineDao.dao.";
	
	@Autowired
	private SqlSession sqlSession;

	public List<NewWineVo> geNewtWineList(Map<String, Object> para) {
		return sqlSession.selectList(NAMESPACE+"getNewWineList", para);
	}

	public long countNewWine(Map<String, Object> para) {
		return sqlSession.selectOne(NAMESPACE+"countNewWine", para);
	}

}
