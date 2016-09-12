package com.mao.test.webdatav1.controller;


import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mao.test.webdata.vo.EasyUiDataGrideVo;
import com.mao.test.webdata.vo.ResultVo;
import com.mao.test.webdatav1.service.BrandService;
import com.mao.test.webdatav1.vo.BrandListVo;

@Controller
@RequestMapping("/webdatav1/brand")
public class BrandController {
	private Logger LOG=LoggerFactory.getLogger(BrandController.class);
	
	@Autowired
	private BrandService brandService;
	
	@RequestMapping("/getBrandList")
	public @ResponseBody EasyUiDataGrideVo<BrandListVo> getBrandList(
			@RequestParam(required=false)String name_cn,
			@RequestParam(required=false)String code,
			@RequestParam(required=false,defaultValue="1")int page,
			@RequestParam(required=false,defaultValue="15")int rows){
		LOG.info("访问getBrandList");
		return brandService.getBrandList(name_cn,code,page,rows);
		
	}
 
	@RequestMapping("/getMaxBrandCode")
	public @ResponseBody ResultVo<Map<String,String>> getMaxBrandCode(
			@RequestParam(required=true)String chateau_code){
		LOG.info("访问getMaxBrandCode，chateau_code:"+chateau_code);
				return brandService.getMaxBrandCode(chateau_code);
		
	}

	@RequestMapping( value = "/addBrandDict"  )
	public @ResponseBody  ResultVo<String> addBrandDict(
			@RequestParam(required = false) String chateau_code,
			@RequestParam(required = true) String brandcode,
			@RequestParam(required = false) String name_cn,
			@RequestParam(required = false) String name_en,
			@RequestParam(required = false) String aliases,
			@RequestParam(required = false) String outSideUrl,
			@RequestParam(required = false) int number){
		LOG.info("访问addBrandDict");
		return brandService.addBrandDict(name_cn, name_en, aliases, chateau_code, brandcode, number, outSideUrl);
	}
	@RequestMapping("/updateBrandDict")
	public @ResponseBody ResultVo<String> updateBrandDict(
			@RequestParam(required=false)String chateau_code,
			@RequestParam(required=true)String brandcode,
			@RequestParam(required=false)String name_cn,
			@RequestParam(required=false)String name_en,
			@RequestParam(required=false)String aliases,
			@RequestParam(required=false)String outSideUrl,
			@RequestParam(required=false)int number){
		LOG.info("访问/updateBrandDict");
		return brandService.updateBrandDict(chateau_code,brandcode,name_cn,name_en,aliases,outSideUrl,number);
		
	}
	@RequestMapping("/deleteBrandDict")
	public @ResponseBody ResultVo<String> deleteBrandDict(@RequestParam(required=true)String id){
		LOG.info("删除品牌/deleteBrandDict");
		ResultVo<String> resultVo=new ResultVo<>();
		brandService.deleteBrandDict(id);
		resultVo.setResult(ResultVo.SUCCESS);
		resultVo.setMessage("删除品牌成功");
		return resultVo;
	}
}
