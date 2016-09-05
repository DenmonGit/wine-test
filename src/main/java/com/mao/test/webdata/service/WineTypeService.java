package com.mao.test.webdata.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.spi.DirStateFactory.Result;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mao.test.congfig.GlobalConfig;
import com.mao.test.util.DateHelper;
import com.mao.test.util.PageUtil;
import com.mao.test.webdata.dao.WineCyclopediaDao;
import com.mao.test.webdata.dao.WineTypeDao;
import com.mao.test.webdata.vo.EasyUiComboBoxVo;
import com.mao.test.webdata.vo.EasyUiDataGrideVo;
import com.mao.test.webdata.vo.ResultVo;
import com.mao.test.webdata.vo.WineTypeVo;


@Service("wineTypeService")
public class WineTypeService {
	
	@Autowired
	private WineTypeDao wineTypeDao;
	@Autowired
	private ImageService imageService;
	@Autowired
	private WineCyclopediaDao wineCyclopediaDao;

	public List<EasyUiComboBoxVo> getWineType() {
		
		return wineTypeDao.getWineType() ;
	}

	public EasyUiDataGrideVo<WineTypeVo> getWineTypeList(String name, int page, int pageSize) {
		EasyUiDataGrideVo<WineTypeVo> data=new EasyUiDataGrideVo<>();
		Map<String,Object> para=new HashMap<>();
		
		int offset=PageUtil.getOffSet(page, pageSize);
		para.put("name", name);
		para.put("offset", offset);
		para.put("size", pageSize);
		List<WineTypeVo> wineTypeVoList=new ArrayList<>();
		List<WineTypeVo> wineTypeList=wineTypeDao.getWineTypeList(para);
		for(WineTypeVo vo:wineTypeList){
			WineTypeVo wineTypeVo=new WineTypeVo(); 
			wineTypeVo.setId(vo.getId());
			wineTypeVo.setImage(GlobalConfig.getProjectServerName()+vo.getImage());
			wineTypeVo.setName(vo.getName());
			wineTypeVo.setOrderIndex(vo.getOrderIndex());
			wineTypeVoList.add(wineTypeVo);
		}
		data.setRows(wineTypeVoList);
		data.setTotal(wineTypeDao.countWinetype(para));
 		return data;
	}

	@Transactional
	public ResultVo<String> addWineType(String name, Integer orderIndex, String type_image) {
		ResultVo<String> resultVo=new ResultVo<>();
		String date=DateHelper.getDateString(DateHelper.currentDate());
		String image=imageService.subImgURLToDataBase(type_image);
		WineTypeVo wineTypeVo=new WineTypeVo();
		wineTypeVo.setName(name);
		wineTypeVo.setImage(image);
		wineTypeVo.setOrderIndex(orderIndex);
		wineTypeVo.setAddTime(date);
		wineTypeVo.setUpdateTime(date);
		
		wineTypeDao.addWineType(wineTypeVo);
		resultVo.setMessage("添加红酒百科目录成功");
		resultVo.setResult(ResultVo.SUCCESS);
		return resultVo;
	}

	public ResultVo<String> updateWineType(Integer articleTypeId, String name, Integer orderIndex, String type_image) {
		ResultVo<String> resultVo=new ResultVo<>();
		String date=DateHelper.getDateString(DateHelper.currentDate());
		String iamge=imageService.subImgURLToDataBase(type_image);
		WineTypeVo wineTypeVo=new WineTypeVo();
		
		wineTypeVo.setId(articleTypeId);
		wineTypeVo.setImage(iamge);
		wineTypeVo.setName(name);
		wineTypeVo.setOrderIndex(orderIndex);
		wineTypeVo.setUpdateTime(date);
		
		wineTypeDao.updateWineType(wineTypeVo);
		resultVo.setMessage("修改红酒目录成功");
		resultVo.setResult(ResultVo.SUCCESS);
		return resultVo;
	}

	public WineTypeVo getWineTypeById(Integer id) {
		WineTypeVo wineTypeVo=wineTypeDao.getWineTypeById(id);
		
		WineTypeVo wineTypeVo1=new WineTypeVo();
		wineTypeVo1.setId(wineTypeVo.getId());
		wineTypeVo1.setName(wineTypeVo.getName());
		wineTypeVo1.setOrderIndex(wineTypeVo.getOrderIndex());
		wineTypeVo1.setImage(wineTypeVo.getImage());
		
		return wineTypeVo1;
	}

	@Transactional
	public ResultVo<String> deleteWineType(Integer id) {
		ResultVo<String> resultVo=new ResultVo<>();
		
		wineCyclopediaDao.deleteWineByType(id);
		wineTypeDao.deletewineType(id);
		
		resultVo.setMessage("删除红酒百科类型成功");
		resultVo.setResult(ResultVo.SUCCESS);
		return resultVo;
	}

}
