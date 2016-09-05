package com.mao.test.webdata.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mao.test.webdata.vo.AreaDictVo;

@Repository("areaDictDao")
public class AreaDictDao {
	public static String NAMESPACE="AreaDict.dao.";
	@Autowired
	private SqlSession sqlSession;

	public List<AreaDictVo> getAreaDictByCode(String code) {
		return sqlSession.selectList(NAMESPACE+"getAreaDictByCode", code);
	}

	public long countAreaDictByCode(String code) {
	
		return sqlSession.selectOne(NAMESPACE+"countAreaDictByCode", code);
	}

	public AreaDictVo getAreaDict(String areaCode) {
		System.out.print("the areaCode"+sqlSession.selectOne(NAMESPACE+"getAreaDict", areaCode));
		return sqlSession.selectOne(NAMESPACE+"getAreaDict", areaCode);
	}

}
