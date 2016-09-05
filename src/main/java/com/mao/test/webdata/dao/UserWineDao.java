package com.mao.test.webdata.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mao.test.webdata.vo.UserWineDetailVo;
import com.mao.test.webdata.vo.UserWineListVo;

@Repository("userWineDao")
public class UserWineDao {
	private static String NAMESPACE="UserWineDao.dao.";
	@Autowired
	private SqlSession sqlSession;

	public List<UserWineListVo> getUserWineList(Map<String, Object> para) {
		return sqlSession.selectList(NAMESPACE+"getUserWineList",para);
	}

	public long countUserWine(Map<String, Object> para) {
		return sqlSession.selectOne(NAMESPACE+"countUserWine", para);
	}

	public UserWineDetailVo getUserWineDetail(int id) {
		return sqlSession.selectOne(NAMESPACE+"getUserWineDetail", id);
	}

	public List<String> getWinePicture(String userWineId) {
		return sqlSession.selectList(NAMESPACE+"getWinePicture",userWineId);
	}

}
