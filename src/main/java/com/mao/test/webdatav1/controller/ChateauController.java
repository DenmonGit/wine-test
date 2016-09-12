package com.mao.test.webdatav1.controller;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mao.test.webdata.vo.EasyUiComboBoxVo;
import com.mao.test.webdata.vo.EasyUiDataGrideVo;
import com.mao.test.webdata.vo.ResultVo;
import com.mao.test.webdatav1.service.ChateauService;
import com.mao.test.webdatav1.vo.ChateauVo;

@Controller
@RequestMapping("/webdatav1/chateau")
public class ChateauController {
	private Logger LOG=LoggerFactory.getLogger(ChateauController.class);
	
	@Autowired
	private ChateauService chateauService;
	
	@RequestMapping("/getChateauList")
	public @ResponseBody EasyUiDataGrideVo<ChateauVo> getChateauList(
			@RequestParam(required=false) String name_cn,
			@RequestParam(required=false) String code,
			@RequestParam(required=false,defaultValue="1") int page,
			@RequestParam(required=false,defaultValue="15") int rows){
		LOG.info("访问getChateauList");
		return chateauService.getChateauList(name_cn,code,page,rows);
		
	}
	@RequestMapping("/getMaxChateauCode")
	public @ResponseBody ResultVo<Map<String,String>> getMaxChateauCode(
			@RequestParam(required=true)String area_code){
		LOG.info("访问getMaxChateauCode,参数：area_code:"+area_code);
		return chateauService.getMaxChateauCode(area_code);
	}
	@RequestMapping("/addChateauDict")
	public @ResponseBody ResultVo<String> addChateauDict(
			@RequestParam(required=false)String area_code,
			@RequestParam(required=true)String chateaucode,
			@RequestParam(required=false)String name_cn,
			@RequestParam(required=false)String  name_en,
			@RequestParam(required=false)String aliases,
			@RequestParam(required=false)String outSideUrl,
			@RequestParam(required=false)int number){
		LOG.info("访问/addChateauDict,酒庄编码："+chateaucode+"产区编码"+area_code);
		return chateauService.addChateauDict(name_cn, name_en, aliases, area_code, chateaucode, number, outSideUrl);
		
	}
	@RequestMapping("/updateChateauDict")
	public @ResponseBody ResultVo<String> updateChateauDict(
			@RequestParam(required=false)String area_code,
			@RequestParam(required=true)String chateaucode,
			@RequestParam(required=false)String name_cn,
			@RequestParam(required=false)String  name_en,
			@RequestParam(required=false)String aliases,
			@RequestParam(required=false)String outSideUrl,
			@RequestParam(required=false)int number){
		LOG.info("访问/updateChateauDict");
		return chateauService.updateChateauDict(name_cn, name_en, aliases, area_code, chateaucode, number, outSideUrl);
		
	}
	@RequestMapping("/deleteChateauDict")
	public @ResponseBody ResultVo<String> deleteChateauDict(
			@RequestParam(required=true)String id){
		LOG.info("删除酒庄");
		return chateauService.deleteChateauDict(id);
		
		}
	@RequestMapping("/getChateauByAreaCode")
	public @ResponseBody List<EasyUiComboBoxVo<String>> getChateauByAreaCode(
			@RequestParam(required=true)String area_code){
		LOG.info("访问getChateauByAreaCode，area_code:"+area_code);
				return chateauService.getChateauByAreaCode(area_code);
		
	}

	
}
