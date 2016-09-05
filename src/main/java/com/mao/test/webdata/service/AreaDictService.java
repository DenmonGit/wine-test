package com.mao.test.webdata.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mao.test.webdata.dao.AreaDictDao;
import com.mao.test.webdata.vo.AreaDictVo;
import com.mao.test.webdata.vo.TreeVo;

@Service("areaDictService")
public class AreaDictService {
	private Logger LOG=LoggerFactory.getLogger(AreaDictService.class);

	@Autowired
	private AreaDictDao areaDictDao;
	
	public List<TreeVo> getAreaDictTree(String code) {

		List<TreeVo> listTree=new ArrayList<TreeVo>();
		List<AreaDictVo> listArea=areaDictDao.getAreaDictByCode(code);
		LOG.info("listSize:"+listArea.size());
		for(AreaDictVo vo:listArea){
			TreeVo treeVo=new TreeVo();
			treeVo.setId(vo.getId());
			treeVo.setParent_id(vo.get_parentId());
			treeVo.setText(vo.getName());
			Map<String,Object> map=new HashMap<>();
			map.put("leval", vo.getLevel());
			if(areaDictDao.countAreaDictByCode(treeVo.getId())>0){
				treeVo.setState("closed");
			}else{
				treeVo.setState("open");
			}
			treeVo.setAttributes(map);
			listTree.add(treeVo);
		}
		return listTree;
	}

}
