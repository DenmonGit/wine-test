package com.mao.test.webdatav1.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import com.mao.test.webdatav1.dao.CabTempleteDao;
import com.mao.test.webdatav1.vo.CabTempleteVo;

import com.mao.test.common.BusinessException;
import com.mao.test.congfig.GlobalConfig;
import com.mao.test.util.PageUtil;
import com.mao.test.util.StringTookKit;
import com.mao.test.webdata.constants.ErrorCodeConstants;
import com.mao.test.webdata.service.ImageService;
import com.mao.test.webdata.vo.EasyUiDataGrideVo;

@Service("cabTempleteService")
public class CabTempleteService {
	@Autowired
	private CabTempleteDao cabTempleteDao;
	@Autowired
	private ImageService imageService;
	
	public EasyUiDataGrideVo<CabTempleteVo> getListCabTemplete(int page,int pageSize) {
		EasyUiDataGrideVo<CabTempleteVo> data=new EasyUiDataGrideVo<>();
		Map<String, Object> para=new HashMap<>();
		int offset=PageUtil.getOffSet(page, pageSize);
		para.put("offset", offset);
		para.put("size", pageSize);
		data.setRows(cabTempleteDao.getListCabTemplete(para));
		data.setTotal(cabTempleteDao.countCabTemplete());
	
		return data;
	}

	@Transactional
	public void save(String templeteName, int row, int column, String imageUrl, 
			String backgroud) {
		String templeteId=StringTookKit.get32BitUUID();
		String imageUrl1=imageService.subImgURLToDataBase(imageUrl);
		String background1=imageService.subImgURLToDataBase(backgroud);
		CabTempleteVo cabTempleteVo=new CabTempleteVo(templeteId, templeteName, row, column, imageUrl1, background1);
		cabTempleteDao.inserCabTemplete(cabTempleteVo);
	}

	@Transactional
	public void deleteCab(String templeteId) {
	cabTempleteDao.deleteCab(templeteId);
		
	}

	public CabTempleteVo getCabTemplete(String templeteId) {
		CabTempleteVo cabTempleteVo=cabTempleteDao.getCabTempleteById(templeteId);
		if(cabTempleteVo==null){
			throw new BusinessException(ErrorCodeConstants.RESULT_PARAM_ERROR, "酒柜模板不存在");
		}
		CabTempleteVo cabTemplete=new CabTempleteVo();
		cabTemplete.setAddTime(cabTempleteVo.getAddTime());
		cabTemplete.setBackground(GlobalConfig.getProjectServerName()+cabTempleteVo.getBackground());
		cabTemplete.setCabColumn(cabTempleteVo.getCabColumn());
		cabTemplete.setCabName(cabTempleteVo.getCabName());
		cabTemplete.setCabRow(cabTempleteVo.getCabRow());
		cabTemplete.setImage(GlobalConfig.getProjectServerName()+cabTempleteVo.getImage());
		cabTemplete.setTempleteId(cabTempleteVo.getTempleteId());
		cabTemplete.setTotalUse(cabTempleteVo.getTotalUse());
		cabTemplete.setUpdateTime(cabTempleteVo.getUpdateTime());
		return cabTemplete;
	}

	public void updateCabTemplete(String templeteName, int row, int column, 
			String imageUrl, String background,
			String templeteId) {
		CabTempleteVo cabTempleteVo=cabTempleteDao.getCabTempleteById(templeteId);
		if(cabTempleteVo==null){
			throw new BusinessException(ErrorCodeConstants.RESULT_PARAM_ERROR, "酒柜模版不存在");
		}
		String imageUrl1 = imageService.subImgURLToDataBase(imageUrl);
		String background1 = imageService.subImgURLToDataBase(background);
		cabTempleteVo = new CabTempleteVo(templeteId, templeteName, row, column, imageUrl1, background1);
		cabTempleteDao.updateCabTemplete(cabTempleteVo);
	}
	
	

}
