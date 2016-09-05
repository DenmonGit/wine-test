package com.mao.test.webdata.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mao.test.webdata.dao.ImageDao;


import com.mao.test.congfig.GlobalConfig;
import com.mao.test.entity.Image;
import com.mao.test.util.StringTookKit;

@Service("imageService")
public class ImageService {
	
	/**
	 * 官方酒款的图片
	 */
	public final static int WINE_JTT_IMGTYPE =1;
	/**
	 * 用户酒款相关的图片
	 */
	public final static int USER_WINE_IMGTYPE =2;
	/**
	 * 系统相关的图片
	 */
	public final static int SYS_IMGTYPE =3;
	/**
	 * 酒评相关的图片
	 */
	public final static int COMMENT_IMGTYPE =4;
	/**
	 * 用户图像的图片
	 */
	public final static int USER_IMGTYPE =5;
	/**
	 * 酒柜相关的图片的图片
	 */
	public final static int CAB_IMGTYPE =6;
	/**
	 * 答题相关的图片
	 */
	public final static int EXAM_IMGTYPE =7;
	/**
	 * 广告的图片
	 */
	public final static int ADVERT_IMGTYPE =8;
	
	/**
	 * 文章的图片
	 */
	public final static int Article_IMGTYPE =8;
	
	@Autowired
	private ImageDao imageDao;
	
	public Map<Integer,String> imagePathMap=new HashMap<>(); 
	
	public ImageService(){
		
	}
	
	//返回存储图片的文件夹
	public String saveImageURLToServiceDir(Integer imageType){
		if(imagePathMap.size()==0){
			List<Image> imageLists=imageDao.getImageLists();
			for(Image image:imageLists){
				imagePathMap.put(image.getType(), image.getServer_path());
			}
		}
		return GlobalConfig.getImgSetUrl()+imagePathMap.get(imageType);
	}
	//返回存储图片的具体地址

	public String saveImageURLToService(String ImageURI, Integer imageType) {
		
		if(imagePathMap.size()==0){
			List<Image> imageLists = imageDao.getImageLists();
			for (Image image : imageLists) {
				imagePathMap.put(image.getType(), image.getServer_path());
			}
		}
		return GlobalConfig.getImgSetUrl()+imagePathMap.get(imageType)+"/"+ImageURI;
	}
	
	/**传入一个图片的名称，获取此图片在服务器上的位置
	 * 
	 * @param getImageURLInService  传入数据库存储的图片路径 如(/jtt/dff53239-79b2-40a6-b57b-458712926e2e.jpg)
	 * @param imgType  图片类型
	 * @return 返回一个绝对的url路径，如(//http://192.168.26.90:80/ajbwine/static/img/wine/jtt/dff53239-79b2-40a6-b57b-458712926e2e.jpg)
	 */
	public String getImageURLInService(String ImageURI, Integer imageType) {
		
		if(imagePathMap.size()==0){
			List<Image> imageLists = imageDao.getImageLists();
			for (Image image : imageLists) {
				imagePathMap.put(image.getType(), image.getServer_path());
			}
		}
		return GlobalConfig.getProjectServerName()+imagePathMap.get(imageType)+"/"+ImageURI;
	}
	
	public String subImgURLToDataBase(String imgURL){
		if(!StringTookKit.judgeString(imgURL)){
			return "";
		}
		if(imgURL.indexOf("/static")==-1){
			return "";
		}
		return imgURL.substring(imgURL.indexOf("/static"));
	}

}
