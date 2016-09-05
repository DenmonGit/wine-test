package com.mao.test.webdata.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mao.test.common.BaseResponse;
import com.mao.test.webdata.service.UserWineService;
import com.mao.test.webdata.vo.AdminUserInfoVo;
import com.mao.test.webdata.vo.EasyUiDataGrideVo;
import com.mao.test.webdata.vo.UserWineDetailVo;
import com.mao.test.webdata.vo.UserWineListVo;

@Controller
@RequestMapping("/webdata/userWine")
public class UserWineController {
	private Logger LOG=LoggerFactory.getLogger(UserWineController.class);
	
	@Autowired
	private UserWineService userWineService;
	
	@RequestMapping("/list")
	public @ResponseBody EasyUiDataGrideVo<UserWineListVo> getUserWineList(
			@RequestParam(required=false)String state,
			@RequestParam(required=false)String wineName,
			@RequestParam(required=false)String nickName,
			@RequestParam(required=false)String phone,
			@RequestParam(required=false,defaultValue="1")int page,
			@RequestParam(required=false,defaultValue="15")int rows){
		LOG.info("访问个人酒库列表：/list");
		return userWineService.getUserWineList(state,wineName,nickName,phone,page,rows);
	}
	@RequestMapping("/detail")
	public @ResponseBody BaseResponse<UserWineDetailVo> getUserWineDetail(@RequestParam(required=true)int id){
		LOG.info("访问用户酒库细节");
		BaseResponse<UserWineDetailVo> br=new BaseResponse<>();
		br.setObject(userWineService.getUserWineDetail(id));
		return br;
		
	}
	@RequestMapping("/deal")
	public @ResponseBody BaseResponse<String> deal(@RequestParam(required=true)int id,
			@RequestParam(required=true)String wineCode,HttpSession session){
		LOG.info("处理个人上传酒库");
		BaseResponse<String> br=new BaseResponse<>();
		AdminUserInfoVo userInfo=(AdminUserInfoVo)session.getAttribute("userInfo");
		userWineService.deal(userInfo.getLoginName(),wineCode,id);
				return br;
		
	}

}
