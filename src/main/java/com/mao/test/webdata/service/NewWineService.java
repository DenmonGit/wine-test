package com.mao.test.webdata.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mao.test.util.PageUtil;
import com.mao.test.webdata.dao.NewWineDao;
import com.mao.test.webdata.vo.EasyUiDataGrideVo;
import com.mao.test.webdata.vo.NewWineVo;

@Service("newWineService")
public class NewWineService {
	
	@Autowired
	private NewWineDao newWineDao;

	public EasyUiDataGrideVo<NewWineVo> getNewWineList(String wine_name_cn, String wine_code, String state,
			String source, int page, int pageSize) {
		EasyUiDataGrideVo<NewWineVo> data=new EasyUiDataGrideVo<>();
		Map<String,Object> para=new HashMap<String,Object>();
		int offset=PageUtil.getOffSet(page, pageSize);
		para.put("wine_name_cn", wine_name_cn);
		para.put("wine_code", wine_code);
		para.put("state", state);
		para.put("offset", offset);
		para.put("size", pageSize);
		data.setRows(newWineDao.geNewtWineList(para));
		data.setTotal(newWineDao.countNewWine(para));
		return data;
	}

}
