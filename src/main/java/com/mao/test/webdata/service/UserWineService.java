package com.mao.test.webdata.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mao.test.common.BusinessException;
import com.mao.test.congfig.GlobalConfig;
import com.mao.test.util.PageUtil;
import com.mao.test.util.StringTookKit;
import com.mao.test.webdata.constants.ErrorCodeConstants;
import com.mao.test.webdata.constants.UserWineHandleState;
import com.mao.test.webdata.dao.UserWineDao;
import com.mao.test.webdata.vo.EasyUiDataGrideVo;
import com.mao.test.webdata.vo.UserWineDetailVo;
import com.mao.test.webdata.vo.UserWineListVo;

@Service("userWineService")
public class UserWineService {
	@Autowired
	private UserWineDao userWineDao;

	public EasyUiDataGrideVo<UserWineListVo> getUserWineList(String state, String wineName, String nickName,
			String phone, int page, int pageSize) {
		EasyUiDataGrideVo<UserWineListVo> data=new EasyUiDataGrideVo<>();
		Map<String,Object> para=new HashMap<String,Object>();
		if(StringTookKit.judgeString(state)){
			if(state.equals(UserWineHandleState.DEAL_FINSHED_DESC)){
				para.put(state, UserWineHandleState.DEAL_FINSHED);
			}
			if(state.equals(UserWineHandleState.WAIT_DEAL_DESC)){
				para.put(state, UserWineHandleState.WAIT_DEAL);
			}
		}
		if(StringTookKit.judgeString(wineName)){
			para.put("wineName", "%"+wineName+"%");
		}
		if(StringTookKit.judgeString(nickName)){
			para.put("nickName","%"+nickName+"%");
		}
		if(StringTookKit.judgeString(phone)){
			para.put("phone", "%"+phone+"%");
		}
		para.put("offset", PageUtil.getOffSet(page, pageSize));
		para.put("size", pageSize);
		data.setRows(userWineDao.getUserWineList(para));
		data.setTotal(userWineDao.countUserWine(para));
		return data;
	}

	public UserWineDetailVo getUserWineDetail(int id) {
		UserWineDetailVo userWineDetailVo=userWineDao.getUserWineDetail(id);
		if(userWineDetailVo==null){
			throw new BusinessException(ErrorCodeConstants.RESULT_PARAM_ERROR, "用户酒款不存在");
		}
		List<String> img=userWineDao.getWinePicture(userWineDetailVo.getUserWineId());
		if(StringTookKit.judgeString(userWineDetailVo.getOfficalWineId())){
			/**
			 * 请补充官方酒库编码代码
			 */
		}
		List<String> imgs=new ArrayList<>();
		if(img!=null&&img.size()>0){
			for(String s:img){
				s=GlobalConfig.getProjectServerName()+s;
				imgs.add(s);
			}
		}
		userWineDetailVo.setImg(imgs);
		return userWineDetailVo;
		
	}

	public void deal(String loginName, String wineCode, int id) {
		
		
	}

}
