package com.mao.test.webdata.controller;


import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mao.test.webdata.service.AreaDictService;
import com.mao.test.webdata.vo.TreeVo;

@Controller
@RequestMapping("/webdata/areaDict")
public class AreaDictController {
	private Logger LOG=LoggerFactory.getLogger(AreaDictController.class);
	@Autowired
	private AreaDictService areaDictService;
	
	@RequestMapping("/getAreaDictTree")
	public @ResponseBody List<TreeVo> getAreaDictTree(@RequestParam(required=false,defaultValue="rootcode")String id){
		LOG.info("访问产地树,/getAreaDictTree,参数id:"+id);
		return areaDictService.getAreaDictTree(id);
		
	}
	
	

}
