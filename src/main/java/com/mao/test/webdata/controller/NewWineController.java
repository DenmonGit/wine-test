package com.mao.test.webdata.controller;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mao.test.webdata.service.NewWineService;
import com.mao.test.webdata.vo.EasyUiDataGrideVo;
import com.mao.test.webdata.vo.NewWineVo;


/**
 * 
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Company: </p>
 * @author mao
 * @date 2016年8月6日 下午3:29:01
 */
@Controller
@RequestMapping("/webdata/newWine")
public class NewWineController {

	private Logger LOG=LoggerFactory.getLogger(NewWineController.class);
	
	@Autowired
	private NewWineService newWineService;
	
	@RequestMapping("/getNewWineList")
	public @ResponseBody EasyUiDataGrideVo<NewWineVo> getNewWineList(
			@RequestParam(required=false)String wine_name_cn,
			@RequestParam(required=false)String wine_code,
			@RequestParam(required=false)String state,
			@RequestParam(required=false)String source,
			@RequestParam(required=false)int page,
			@RequestParam(required=false)int rows){
		LOG.info("访问官方酒库");
				return newWineService.getNewWineList(wine_name_cn,wine_code,state,source,page,rows);
				
		
		
	}
	
}
