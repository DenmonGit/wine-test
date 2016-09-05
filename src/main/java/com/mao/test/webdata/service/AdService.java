package com.mao.test.webdata.service;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mao.test.common.BusinessException;
import com.mao.test.congfig.GlobalConfig;
import com.mao.test.entity.AdVersion;
import com.mao.test.util.DateHelper;
import com.mao.test.util.PageUtil;
import com.mao.test.webdata.constants.AdVersionConstants;
import com.mao.test.webdata.constants.ErrorCodeConstants;
import com.mao.test.webdata.dao.AdDao;
import com.mao.test.webdata.vo.AdVo;
import com.mao.test.webdata.vo.EasyUiDataGrideVo;



@Service("adService")
public class AdService {
	
	@Autowired
	private AdDao adDao;
	
	@Autowired
	private ImageService imageService;

	public EasyUiDataGrideVo<AdVo> getAdList(int page, int pageSize) {
		EasyUiDataGrideVo<AdVo> data=new EasyUiDataGrideVo<>();
		Map<String,Object> para=new HashMap<>();
		para.put("offset", PageUtil.getOffSet(page, pageSize));
		para.put("size", pageSize);
		data.setRows(adDao.getAdList(para));
		data.setTotal(adDao.countAd());
		return data;
	}
	@Transactional
	public void deleteAd(String adId) {
		 AdVo adVo=adDao.getAdById(adId);
		if(adVo==null){
			throw new BusinessException(ErrorCodeConstants.RESULT_PARAM_ERROR, "广告不存在");
		}
		adDao.deleteAd(adId);
		String date=DateHelper.getDateString(DateHelper.currentDate());
		AdVersion adVersion=new AdVersion(AdVersionConstants.AD_DELETE,date,adId);
		adDao.updateAdVersion(adVersion);
	}
	@Transactional
	public void saveAd(String title, String cover, String content, String type, int operate, String winestoreaddr,
			String authorId) {
		String adId=UUID.randomUUID().toString().replace("-", "");
		String date=DateHelper.getDateString(DateHelper.currentDate());
		String cover1=imageService.subImgURLToDataBase(cover);
		
		AdVo ad=new AdVo(adId,authorId,title,cover1,content,type,date,date,operate,winestoreaddr);
		adDao.saveAd(ad);
		AdVersion adVersion=new AdVersion(AdVersionConstants.AD_ADD,date,adId);
		adDao.updateAdVersion(adVersion);
	}
	public AdVo getAdById(String adId) {
		AdVo adVo=adDao.getAdById(adId);
		if(adVo==null){
			throw new BusinessException(ErrorCodeConstants.RESULT_PARAM_ERROR,"广告不存在");
		}
		AdVo adVo1 = new AdVo();
		adVo1.setAdId(adVo.getAdId());
		adVo1.setTitle(adVo.getTitle());
		adVo1.setAuthor(adVo.getAuthor());
		adVo1.setAddTime(adVo.getAddTime());
		adVo1.setStatus(adVo.getStatus());
		adVo1.setCover(GlobalConfig.getProjectServerName()+adVo.getCover());
		adVo1.setContent(adVo.getContent());
		adVo1.setOperatorType(adVo.getOperatorType());
		adVo1.setWineStoreAddr(adVo.getWineStoreAddr());
		
		return adVo1;
	}
	@Transactional
	public void updateAd(String adId, String title, String cover, String content, String type, int operate,
			String winestoreaddr, String ctype) {
		
		String date=DateHelper.getDateString(DateHelper.currentDate());
		String cover1=imageService.subImgURLToDataBase(cover);
		AdVo ad = new AdVo(adId,"",title,cover1,content,type,date,date,operate,winestoreaddr);
		adDao.updateAd(ad);
		AdVersion adVersion = new AdVersion(ctype,date,adId);
		adDao.updateAdVersion(adVersion);
		
	}

}
