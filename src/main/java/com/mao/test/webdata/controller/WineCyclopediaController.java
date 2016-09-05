package com.mao.test.webdata.controller;

import java.util.List;

import org.apache.catalina.connector.Request;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mao.test.common.BaseResponse;
import com.mao.test.webdata.service.WineCyclopediaService;
import com.mao.test.webdata.vo.EasyUiComboBoxVo;
import com.mao.test.webdata.vo.EasyUiDataGrideVo;
import com.mao.test.webdata.vo.ResultVo;
import com.mao.test.webdata.vo.WineCyclopediaVo;
import com.mao.test.webdata.vo.WineTypeVo;

/**
 * 
 * <p>Title: </p>
 * <p>Description: 红酒百科控制器</p>
 * <p>Company: </p>
 * @author mao
 * @date 2016年8月3日 下午2:08:39
 */
@Controller
@RequestMapping("/webdata/wineCyclopedia")
public class WineCyclopediaController {

	private Logger LOG=LoggerFactory.getLogger(WineCyclopediaController.class);
	@Autowired
	private WineCyclopediaService wineCyclopediaService;
	
	@RequestMapping("/getWineDataGrid")
	public @ResponseBody EasyUiDataGrideVo<WineCyclopediaVo> getArticleDataGrid(
			@RequestParam(required=false) String title,
			@RequestParam(required=false) Integer type_id,
			@RequestParam(required=false) int page,
			@RequestParam(required=false) int rows){
		LOG.info("访问红酒百科列表，/getWineDataGrid");
		return wineCyclopediaService.getArticleDataGrid(title,type_id,page,rows);
		
	}
	@RequestMapping("/getWineTypeComboBox")
	public @ResponseBody List<EasyUiComboBoxVo<WineTypeVo>>  getWineTypeComboBox(){
		LOG.info("访问/getWineTypeComboBox");
		List<EasyUiComboBoxVo<WineTypeVo>> combobox=wineCyclopediaService.getComboBox();
		return combobox;
		
	}
	@RequestMapping("/save")
	public @ResponseBody ResultVo<String> save(
			@RequestParam(required=true)String title,
			@RequestParam(required=true)String cover,
			@RequestParam(required=false)Integer type_id,
			@RequestParam(required=false)Integer operatetype,
			@RequestParam(required = false) String status,
			@RequestParam(required=false)Integer orderNumber,
			@RequestParam(required=false)String outside_url,
			@RequestParam(required=false)String content){
		LOG.info("保存红酒记录");
		return wineCyclopediaService.saveWine(title,cover,type_id,operatetype,status,orderNumber,outside_url,content);
		
	}
	@RequestMapping("/deleteWine")
	public @ResponseBody ResultVo<String> deleteWine(@RequestParam(required=true)String id){
		LOG.info("删除红酒百科");
		return wineCyclopediaService.deleteWine(id);
		
	}
	@RequestMapping("/wineDetail")
	public @ResponseBody BaseResponse<WineCyclopediaVo> wineDetail(@RequestParam(required=true)String articleId){
		LOG.info("访问需要修改的红酒百科细节，参数id："+articleId);
		BaseResponse<WineCyclopediaVo> br=new BaseResponse<>();
		br.setObject(wineCyclopediaService.getWineById(articleId));
		br.setErrmsg("获取详成功！");
		return br;
	}
	
	@RequestMapping("/update")
	public @ResponseBody ResultVo<String> update(
			@RequestParam(required=true)String articleId,
			@RequestParam(required=true)String title,
			@RequestParam(required=true)String cover,
			@RequestParam(required=false)Integer type_id,
			@RequestParam(required=false)Integer operatetype,
			@RequestParam(required = false) String status,
			@RequestParam(required=false)Integer orderNumber,
			@RequestParam(required=false)String outside_url,
			@RequestParam(required=false)String content){
		LOG.info("保存更新红酒白科后的页面，参数id:"+articleId);
				return wineCyclopediaService.updateWine(articleId , title, cover, type_id, operatetype, status, orderNumber, outside_url, content);
		
	}
}
