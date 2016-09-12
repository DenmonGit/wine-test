package com.mao.test.webdatav1.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mao.test.common.BusinessException;
import com.mao.test.util.DateHelper;
import com.mao.test.util.PageUtil;
import com.mao.test.util.StringTookKit;
import com.mao.test.webdata.constants.ErrorCodeConstants;
import com.mao.test.webdata.dao.AreaDictDao;
import com.mao.test.webdata.vo.AreaDictVo;
import com.mao.test.webdata.vo.EasyUiComboBoxVo;
import com.mao.test.webdata.vo.EasyUiDataGrideVo;
import com.mao.test.webdata.vo.ResultVo;
import com.mao.test.webdatav1.dao.BrandDao;
import com.mao.test.webdatav1.dao.ChateauDao;
import com.mao.test.webdatav1.vo.ChateauVo;
@Service("chateauService")
public class ChateauService {
	@Autowired
	private ChateauDao chateauDao;
	@Autowired
	private AreaDictDao areaDictDao;
	//@Autowired
	//private BrandDao brandDao; 
	
	public EasyUiDataGrideVo<ChateauVo> getChateauList(String name_cn, String code, int page, int rows) {
		EasyUiDataGrideVo<ChateauVo> data=new EasyUiDataGrideVo<>();
		Map<String,Object> para=new HashMap<String,Object>();
		int offset=PageUtil.getOffSet(page, rows);
		para.put("offset", offset);
		para.put("size", rows);
		if(StringTookKit.judgeString(name_cn)){
			para.put("name_cn", "%"+name_cn+"%");
		}
		if(StringTookKit.judgeString(code)){
			para.put("code","%"+ code+"%");
		}
		data.setRows(chateauDao.getChateauList(para));
		data.setTotal(chateauDao.countChateauList(para));
		return data;
	}

	public ResultVo<Map<String, String>> getMaxChateauCode(String areaCode) {
		ResultVo<Map<String, String>> resultVo=new ResultVo<>();
		Map<String,String> map=new HashMap<String,String>();
		String maxCode=chateauDao.getMaxChateauCode(areaCode);
		map.put("MaxCode", maxCode);
		resultVo.setMessage("获得最大酒庄/酒商的code成功");
		resultVo.setObject(map);
		resultVo.setResult(ResultVo.SUCCESS);
		return resultVo;
	}

	@Transactional
	public ResultVo<String> addChateauDict(String nameCn,String nameEn,String aliases,String areaCode,
			String chateaucode, int number, String outSideUrl) {
		ResultVo<String> resultVo=new ResultVo<>();
		if(chateauDao.checkChateauIsExist(chateaucode)>0){
			throw new BusinessException(ErrorCodeConstants.RESULT_PARAM_ERROR,"酒庄编码已经存在！");
			
		}
		Map<String,Object> para=new HashMap<String,Object>();
		para.put("nameCn", nameCn);
		para.put("nameEn", nameEn);
		para.put("aliases", aliases);
		para.put("areaCode", areaCode);
		para.put("code", chateaucode);
		para.put("number", number);
		para.put("outSideUrl", outSideUrl);
		para.put("namePinYin", "");
		String dateStr=DateHelper.getDateString(new Date());
		para.put("addTime", dateStr);
		para.put("updateTime", dateStr);
		chateauDao.addChateauDict(para);
		//更新
		updateParentsStr(areaCode,chateaucode,nameCn,nameEn);
		resultVo.setMessage("修改酒庄/酒商成功");
		resultVo.setResult(ResultVo.SUCCESS);
		return resultVo;
	}

	private void updateParentsStr(String areaCode, String chateaucode, String nameCn, String nameEn) {
		AreaDictVo areaVo=areaDictDao.getAreaDict(areaCode);
		Map<String,Object> paraForArea=new HashMap<String,Object>();
		paraForArea.put("area1", areaVo.getArea_1());
		paraForArea.put("area2", areaVo.getArea_2());
		paraForArea.put("area3", areaVo.getArea_3());
		paraForArea.put("area4", areaVo.getArea_4());
		paraForArea.put("area5", areaVo.getArea_5());
		paraForArea.put("code", chateaucode);
		String parentsStrCn=areaVo.getParents_str_cn()+"->"+nameCn;
		String parentsStrEn=areaVo.getParents_str_en()+"->"+nameEn;
		paraForArea.put("parentsStrCn", parentsStrCn);
		paraForArea.put("parentsStrEn", parentsStrEn);
		chateauDao.updateAddChateauDictArea(paraForArea);
	}
	@Transactional
	public ResultVo<String> updateChateauDict(String nameCn,String nameEn,String aliases,String areaCode,
			String chateaucode, int number, String outSideUrl) {
		ResultVo<String> resultVo = new ResultVo<String>();
		Map<String, Object> para = new HashMap<String, Object>();
		para.put("nameCn", nameCn);
		para.put("nameEn", nameEn);
		para.put("aliases", aliases);
		para.put("areaCode", areaCode);
		para.put("code", chateaucode);
		para.put("number", number);
		para.put("outSideUrl", outSideUrl);
		para.put("namePinyin", "");
		String dateStr = DateHelper.getDateString(new Date());
		para.put("updateTime", dateStr);
		chateauDao.updateChateauDict(para);
		//更新
		updateParentsStr(areaCode,chateaucode,nameCn,nameEn);
		resultVo.setMessage("修改酒庄/酒商成功");
		resultVo.setResult(ResultVo.SUCCESS);
		return resultVo;
	}
	@Transactional
	public ResultVo<String> deleteChateauDict(String code) {
		ChateauVo vo=chateauDao.getChateauByid(code);
		if(vo==null){
			throw new BusinessException(ErrorCodeConstants.RESULT_PARAM_ERROR, "酒庄不存在");
		}
		//brandDao.deleteBrandByChateauCode(code);
		chateauDao.deleteChateau(code);
		ResultVo<String> resultVo=new ResultVo<>();
		resultVo.setMessage("删除酒庄/酒商成功");
		resultVo.setResult(ResultVo.SUCCESS);
		return resultVo;
		
		
	}

	public List<EasyUiComboBoxVo<String>> getChateauByAreaCode(String areaCode) {
		return chateauDao.getChateauByAreaCode(areaCode);
	}
	
	

}
