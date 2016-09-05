package com.mao.test.webdata.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mao.test.common.BaseResponse;
import com.mao.test.webdata.service.AdService;
import com.mao.test.webdata.vo.AdVo;
import com.mao.test.webdata.vo.AdminUserInfoVo;
import com.mao.test.webdata.vo.EasyUiDataGrideVo;

/**
 * 
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Company: </p>
 * @author mao
 * @date 2016年8月1日 上午9:53:47
 */
@Controller
@RequestMapping("/webdata/ad")
public class AdController {

	private Logger LOG=LoggerFactory.getLogger(AdController.class);
	@Autowired
	private AdService adService;
	
	
	@RequestMapping("/adList")
	public @ResponseBody EasyUiDataGrideVo<AdVo> getAdList(@RequestParam(required=false,defaultValue="1")int page,
			@RequestParam(required=false,defaultValue="15")int rows){
		LOG.info("访问广告列表");
		return adService.getAdList(page,rows);
		
	}
	
	@RequestMapping("/delete")
	public @ResponseBody BaseResponse<String> deleteAd(@RequestParam(required=true)String adId){
		LOG.info("删除广告，访问：/delete");
		BaseResponse<String> br=new BaseResponse<>();
		adService.deleteAd(adId);
		//br.setErrcode(0);
		return br;
		
	}
	@RequestMapping("/save")
	public @ResponseBody BaseResponse<String> saveAd(@RequestParam(required=true)String title,
			@RequestParam(required=false)String cover,@RequestParam(required=false)String content,
			@RequestParam(required=true)String type,@RequestParam(required=true)int operate,
			@RequestParam(required=true)String winestoreaddr,HttpSession session){
		LOG.info("保存");
		BaseResponse<String> br=new BaseResponse<>();
		AdminUserInfoVo userInfo=(AdminUserInfoVo)session.getAttribute("userInfo");
		adService.saveAd(title,cover,content,type,operate,winestoreaddr,userInfo.getLoginName());
		return br;
		
	}
	
	@RequestMapping("/adDeatail")
	public @ResponseBody BaseResponse<AdVo> adDeatail(@RequestParam(required=true)String adId){
		LOG.info("访问广告详情/adDetail");
		BaseResponse<AdVo> br=new BaseResponse<>();
		br.setObject(adService.getAdById(adId));
		return br;
		
	}
	@RequestMapping("/update")
	public @ResponseBody BaseResponse<String> updateAd(@RequestParam(required=true) String title,
			@RequestParam(required=false) String cover,@RequestParam(required=false) String content,
			@RequestParam(required=true) String type,@RequestParam(required=true) int operate,
			@RequestParam(required=true) String winestoreaddr,@RequestParam(required=true) String id,
			@RequestParam(required=true) String ctype){
		LOG.info("广告修改，访问/update");
		BaseResponse<String> br=new BaseResponse<>();
		adService.updateAd(id, title, cover, content, type, operate, winestoreaddr, ctype);
				return br;
		
	}
	
}
