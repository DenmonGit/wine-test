package com.mao.test.webdatav1.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mao.test.webdatav1.service.CabTempleteService;
import com.mao.test.webdatav1.vo.CabTempleteVo;
import com.mao.test.common.BaseResponse;
import com.mao.test.webdata.vo.EasyUiDataGrideVo;

@Controller
@RequestMapping("/webdatav1/cabTemplete")
public class CabTempleteController {
	private Logger LOG=LoggerFactory.getLogger(CabTempleteController.class);
	
	@Autowired
	private CabTempleteService cabTempleteService;

	@RequestMapping("/list")
	public @ResponseBody EasyUiDataGrideVo<CabTempleteVo> getListCabTempelte(
			@RequestParam(required=false,defaultValue="1")int page,
			@RequestParam(required=false,defaultValue="15")int rows){
		LOG.info("获得酒柜模板列表");
		return cabTempleteService.getListCabTemplete(page,rows);
	}
	@RequestMapping("/save")
	public @ResponseBody BaseResponse<String> save(
			@RequestParam(required=true)String templeteName,
			@RequestParam(required=true)int row,
			@RequestParam(required=true)int column,
			@RequestParam(required=false,defaultValue="")String imageUrl,
			@RequestParam(required=false,defaultValue="")String backgroud) {
		LOG.info("保存");
		BaseResponse<String> br=new BaseResponse<>();
		cabTempleteService.save(templeteName,row,column,imageUrl,backgroud);
				return br;
		
	}
	@RequestMapping("/deleteCab")
	public @ResponseBody BaseResponse<String> deleteCab(@RequestParam(required=true)String templeteId){
		LOG.info("删除酒柜模板");
		BaseResponse<String> br=new BaseResponse<>();
		cabTempleteService.deleteCab(templeteId);
		//br.setErrcode(0);
		return br;
		
	}
	@RequestMapping("/detail")
	public @ResponseBody BaseResponse<CabTempleteVo> cabTempleteDetail(@RequestParam(required=true)String templeteId){
		LOG.info("获得模板详情");
		BaseResponse<CabTempleteVo> br=new BaseResponse<>();
		br.setObject(cabTempleteService.getCabTemplete(templeteId));
		return br;
	}
	@RequestMapping("/updateCab")
	public @ResponseBody BaseResponse<String> updateCabTemplete(@RequestParam(required=true)String templeteName,
			@RequestParam(required=true)int row,@RequestParam(required=true)int column,
			@RequestParam(required=false,defaultValue="")String imageUrl,
			@RequestParam(required=false,defaultValue="") String background,
			@RequestParam(required=true)String templeteId){
		BaseResponse<String> br = new BaseResponse<String>();
		cabTempleteService.updateCabTemplete(templeteName, row, column, imageUrl, background, templeteId);
		return br;
	}
}
