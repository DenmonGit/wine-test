package com.mao.test.webdata.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.naming.spi.DirStateFactory.Result;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mao.test.util.DateHelper;
import com.mao.test.util.PageUtil;
import com.mao.test.webdata.dao.WineCyclopediaDao;
import com.mao.test.webdata.vo.EasyUiComboBoxVo;
import com.mao.test.webdata.vo.EasyUiDataGrideVo;
import com.mao.test.webdata.vo.ResultVo;
import com.mao.test.webdata.vo.WineCyclopediaVo;
import com.mao.test.webdata.vo.WineTypeVo;

@Service("wineCyclopediaService")
public class WineCyclopediaService {
	
	@Autowired
	private WineCyclopediaDao wineCyclopediaDao;
	@Autowired
	private ImageService imageService;
	
	public EasyUiDataGrideVo<WineCyclopediaVo> getArticleDataGrid(String title, Integer type_id, int page, int pageSize) {
		EasyUiDataGrideVo<WineCyclopediaVo> data=new EasyUiDataGrideVo<>();
		Map<String,Object> para=new HashMap<>();
		para.put("offset", PageUtil.getOffSet(page, pageSize));
		para.put("size", pageSize);
		para.put("title", title);
		para.put("type_id", type_id);
		data.setRows(wineCyclopediaDao.getWineDataGrid(para));
		data.setTotal(wineCyclopediaDao.countWineCyclopedia(para));
		return data;
	}

	public List<EasyUiComboBoxVo<WineTypeVo>> getComboBox() {
		List<EasyUiComboBoxVo<WineTypeVo>> comboboxList=new ArrayList<>();
		List<WineTypeVo> WineTypeVos=wineCyclopediaDao.getWineTypeByIdAndName();
		for(WineTypeVo WineTypeVo:WineTypeVos){
			EasyUiComboBoxVo<WineTypeVo> combobox=new EasyUiComboBoxVo<>();
			Integer id=WineTypeVo.getId();
			String name=WineTypeVo.getName();
			combobox.setId(id.toString());
			combobox.setText(name);
			comboboxList.add(combobox);
		}
		EasyUiComboBoxVo<WineTypeVo> combobox1=new EasyUiComboBoxVo<>();
			combobox1.setId("");
			combobox1.setText("全部");
			comboboxList.add(combobox1);
		
		return comboboxList;
	}
	@Transactional
	public ResultVo<String> saveWine(String title, String cover, Integer type_id, Integer operatetype, String status,
			Integer orderNumber, String outside_url, String content) {
		ResultVo<String> resultVo=new ResultVo<>();
		/**
		 * 两种处理方式处理转换状态和条跳转方式
		 * 1、静态变量转换状态和跳转方式 
		 * 2、另外一种方式，直接往数据库存，这里采用第2种方法
		 */
		
		/*
		 *存储封面图片的相对路径 
		 */
		String coverValue=imageService.subImgURLToDataBase(cover);
		/**
		 * 获得当前的时间
		 */
		String newDate=DateHelper.getDateString(DateHelper.currentDate());
		
		WineCyclopediaVo vo=new WineCyclopediaVo();
		vo.setId(UUID.randomUUID().toString().replace("-", ""));
		vo.setAddTime(newDate);
		vo.setContent(content);
		vo.setCover(coverValue);
		vo.setOperateType(operatetype);
		vo.setOrderNumber(orderNumber);
		vo.setOutsideUrl(outside_url);
		vo.setStatus(status);
		vo.setTitle(title);
		vo.setTypeId(type_id);
		vo.setUpdateTime(newDate);
		wineCyclopediaDao.addWine(vo);
		resultVo.setMessage("添加红酒百科成功");
		resultVo.setResult(ResultVo.SUCCESS);
		return resultVo;
	}

	public ResultVo<String> deleteWine(String id) {
		ResultVo<String> resultVo=new ResultVo<>();
		wineCyclopediaDao.deleteWine(id);
		resultVo.setMessage("删除红酒白科成功");
		resultVo.setResult(ResultVo.SUCCESS);
		return resultVo;
	}

	public WineCyclopediaVo getWineById(String id) {
		WineCyclopediaVo vo=wineCyclopediaDao.getWineById(id);
		WineCyclopediaVo wineCyclopediaVo=new WineCyclopediaVo(vo);
		return wineCyclopediaVo;
	}

	public ResultVo<String> updateWine(String articleId, String title, String cover,
			Integer type_id,Integer operatetype, String status, Integer orderNumber, 
			String outside_url, String content) {
		ResultVo<String> resultVo=new ResultVo<>();
		/**
		 * 两种处理方式处理转换状态和条跳转方式
		 * 1、静态变量转换状态和跳转方式 
		 * 2、另外一种方式，直接往数据库存，这里采用第2种方法
		 */
		
		/*
		 *存储封面图片的相对路径 
		 */
		String coverValue=imageService.subImgURLToDataBase(cover);
		/**
		 * 获得当前的时间
		 */
		String newDate=DateHelper.getDateString(DateHelper.currentDate());
		
		WineCyclopediaVo vo=new WineCyclopediaVo();
		vo.setId(articleId);
		vo.setAddTime(newDate);
		vo.setContent(content);
		vo.setCover(coverValue);
		vo.setOperateType(operatetype);
		vo.setOrderNumber(orderNumber);
		vo.setOutsideUrl(outside_url);
		vo.setStatus(status);
		vo.setTitle(title);
		vo.setTypeId(type_id);
		vo.setUpdateTime(newDate);
		
		wineCyclopediaDao.updateWine(vo);
		resultVo.setMessage("更新红酒百科成功");
		resultVo.setResult(ResultVo.SUCCESS);
		return resultVo;
	}
	
}
