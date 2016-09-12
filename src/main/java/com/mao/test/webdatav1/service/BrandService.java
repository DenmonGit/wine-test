package com.mao.test.webdatav1.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mao.test.common.BusinessException;
import com.mao.test.util.DateHelper;
import com.mao.test.util.PageUtil;
import com.mao.test.util.StringTookKit;
import com.mao.test.webdata.constants.ErrorCodeConstants;
import com.mao.test.webdata.vo.EasyUiDataGrideVo;
import com.mao.test.webdata.vo.ResultVo;
import com.mao.test.webdatav1.dao.BrandDao;
import com.mao.test.webdatav1.dao.ChateauDao;
import com.mao.test.webdatav1.vo.BrandListVo;
import com.mao.test.webdatav1.vo.ChateauParentNameVo;

@Service("brandService")
public class BrandService {
	@Autowired
	private BrandDao brandDao;
	@Autowired
	private ChateauDao chateauDao;

	public EasyUiDataGrideVo<BrandListVo> getBrandList(String nameCn, String code, int page, int pageSize) {
		EasyUiDataGrideVo<BrandListVo> data=new EasyUiDataGrideVo<>();
		Map<String,Object> para=new HashMap<String,Object>();
		int offset=PageUtil.getOffSet(page, pageSize);
		para.put("offset", offset);
		para.put("size", pageSize);
		if(StringTookKit.judgeString(nameCn)){
			para.put("nameCn", "%"+nameCn+"%");
		}
		if(StringTookKit.judgeString(code)){
			para.put("code", "%"+code+"%");
		}
		data.setRows(brandDao.getBrandList(para));
		data.setTotal(brandDao.countBrandList(para));
		return data;
	}

	public ResultVo<Map<String, String>> getMaxBrandCode(String chateauCode) {
		ResultVo<Map<String,String>> resultVo=new ResultVo<>();
		Map<String,String> map=new HashMap<String,String>();
		String maxCode=brandDao.getMaxBrandCode(chateauCode);
		map.put("maxCode", maxCode);
		resultVo.setResult(ResultVo.SUCCESS);
		resultVo.setMessage("获得品牌最大的code成功");
		resultVo.setObject(map);
		return resultVo;
	}

	@Transactional
	public ResultVo<String> addBrandDict(String nameCn, String nameEn, String aliases,
			String chateauCode,String brandCode, int number, String outSideUrl) {
		ResultVo<String> resultVo=new ResultVo<>();
		if(brandDao.checkBrandIsExist(brandCode)>0){
			throw new BusinessException(ErrorCodeConstants.RESULT_PARAM_ERROR, "品牌已经存在");
		}
		Map<String, Object> para = new HashMap<String, Object>();
		String date = DateHelper.getDateString(DateHelper.currentDate());
		String namePinyin=nameEn;
		para.put("nameCn", nameCn);
		para.put("addTime", date);
		para.put("updateTime", date);
		para.put("nameEn", nameEn);
		para.put("code", brandCode);
		para.put("chateauCode", chateauCode);
		para.put("aliases", aliases);
		para.put("number", number);
		para.put("outSideUrl", outSideUrl);
		para.put("namePinyin", namePinyin);
		brandDao.addBrandDict(para);
		ChateauParentNameVo vo=chateauDao.getParentStrByCode(chateauCode);
		String parentsStrCn = vo.getParentsStrCn()+"->"+nameCn;
		String parentsStrEn = vo.getParentsStrEn()+"->"+nameEn;
		Map<String, Object> paraForName = new HashMap<String, Object>();
		paraForName.put("parentsStrCn", parentsStrCn);
		paraForName.put("code", brandCode);
		paraForName.put("parentsStrEn", parentsStrEn);
		brandDao.updateBrandDictParentName(paraForName);
		resultVo.setResult(ResultVo.SUCCESS);
		resultVo.setMessage("添加品牌成功");
		return resultVo;
	}

	public ResultVo<String> updateBrandDict(String chateau_code, String brandcode, String name_cn,String name_en,
			String aliases,String outSideUrl, int number) {
		ResultVo<String> resultVo=new ResultVo<>();
		Map<String,Object> para=new HashMap<>();
		String date=DateHelper.getDateString(DateHelper.currentDate());
		para.put("chateauCode", chateau_code);
		para.put("brandcode", brandcode);
		para.put("nameCn",name_cn);
		para.put("nameEn", name_en);
		para.put("aliases", aliases);
		para.put("outSideUrl",outSideUrl);
		para.put("number", number);
		para.put("updateTime", date);
		para.put("namePinyin", "");
		brandDao.updateBrandDict(para);
		ChateauParentNameVo vo=chateauDao.getParentStrByCode(chateau_code);
		String parentsStrCn=vo.getParentsStrCn()+"-->"+name_cn;
		String parentsStrEn=vo.getParentsStrEn()+"-->"+name_en;
		Map<String, Object> paraForName=new HashMap<>();
		paraForName.put("parentsStrCn", parentsStrCn);
		paraForName.put("parentsStrEn", parentsStrEn);
		paraForName.put("brandcode", brandcode);
		brandDao.updateBrandDictParentName(paraForName);
		resultVo.setResult(ResultVo.SUCCESS);
		resultVo.setMessage("修改品牌成功");
		return resultVo;
	}

	@Transactional
	public void deleteBrandDict(String id) {
		brandDao.deleteBrandDict(id);
	}

}
