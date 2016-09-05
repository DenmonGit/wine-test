package com.mao.test.webdata.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mao.test.entity.Image;

@Repository("imageDao")
public class ImageDao {

	@Autowired
	private SqlSession sqlSession;
	public static String NAMESPACE="Image.dao.";
	
	
	public List<Image> getImageLists() {
		return sqlSession.selectList(NAMESPACE+"getImageLists");
	}

}
