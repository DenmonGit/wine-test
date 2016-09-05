package com.mao.test.webdata.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.deser.Deserializers.Base;
import com.mao.test.common.BaseResponse;
import com.mao.test.webdata.service.WineTypeService;
import com.mao.test.webdata.vo.EasyUiComboBoxVo;
import com.mao.test.webdata.vo.EasyUiDataGrideVo;
import com.mao.test.webdata.vo.ResultVo;
import com.mao.test.webdata.vo.WineTypeVo;

@Controller
@RequestMapping("/webdata/wineType")
public class WineTypeController {

	private Logger LOG=LoggerFactory.getLogger(WineTypeController.class);
	
	@Autowired
	private WineTypeService wineTypeService;
	
	@RequestMapping("/getWineType")
	public @ResponseBody List<EasyUiComboBoxVo> getWineType(){
		LOG.info("访问红酒类型");
		return wineTypeService.getWineType();
		
	}
	@RequestMapping("/getWineTypeDataGrid")
	public @ResponseBody EasyUiDataGrideVo<WineTypeVo> getWineTypeDataGrid(
			@RequestParam(required=false)String name,
			@RequestParam(required=false,defaultValue="1") int page,
			@RequestParam(required=false,defaultValue="15") int rows){
		LOG.info("访问红酒百科目录");
		return wineTypeService.getWineTypeList(name,page,rows);
		
	}
	@RequestMapping("/addWineType")
	public @ResponseBody ResultVo<String>addWineType(
			@RequestParam(required=true)String name,
			@RequestParam(required=true)Integer orderIndex,
			@RequestParam(required=false)String type_image){
		LOG.info("访问addWineType,添加红酒百科目录");
		return wineTypeService.addWineType(name,orderIndex,type_image);
		
	}
	@RequestMapping("/updateWineType")
	public @ResponseBody ResultVo<String> updateWineType(
			@RequestParam(required=true) Integer articleTypeId,
			@RequestParam(required=true)String name,
			@RequestParam(required=true)Integer orderIndex,
			@RequestParam(required=false)String type_image){
		LOG.info("访问updateWineType,修改红酒百科目录 articleTypeId-->"+articleTypeId+"type_image-->"+type_image);
		return wineTypeService.updateWineType(articleTypeId,name,orderIndex,type_image);
		
	}
	@RequestMapping("/wineTypeDetail")
	public @ResponseBody BaseResponse<WineTypeVo> wineTypeDetail(@RequestParam(required=true)Integer id){
		LOG.info("获取红酒目录详情,id:"+id);
		BaseResponse<WineTypeVo> br=new BaseResponse<>();
		br.setErrmsg("获得红酒详情成功");
		br.setObject(wineTypeService.getWineTypeById(id));
		return br;
		
	}
	@RequestMapping(value="/deleteWineType")
	public @ResponseBody ResultVo<String> deleteWineType(@RequestParam(required=false)Integer id){
		LOG.info("删除红酒百科");
		return wineTypeService.deleteWineType(id);
		
	}
	
}
