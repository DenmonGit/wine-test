package com.mao.test.webdata.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mao.test.entity.AdVersion;
import com.mao.test.webdata.vo.AdVo;

@Repository("adDao")
public class AdDao {
	private static String NAMESPACE="AdDao.dao.";
	
	@Autowired
	private SqlSession sqlSession;

	public List<AdVo> getAdList(Map<String, Object> para) {
		return sqlSession.selectList(NAMESPACE+"getAdList",para);
	}

	public long countAd() {
		return sqlSession.selectOne(NAMESPACE+"countAd");
	}

	public void saveAd(AdVo ad) {
		sqlSession.insert(NAMESPACE+"saveAd",ad);
		
	}

	public void updateAdVersion(AdVersion adVersion) {
		
		sqlSession.insert(NAMESPACE+"updateAdVersion", adVersion);
	}

	public AdVo getAdById(String adId) {
		return sqlSession.selectOne(NAMESPACE+"getAdById",adId);
	}

	public void deleteAd(String adId) {
		sqlSession.delete(NAMESPACE+"deleteAd",adId);
		
	}

	public void updateAd(AdVo ad) {
		sqlSession.update(NAMESPACE+"updateAd",ad);
		
	}

}
