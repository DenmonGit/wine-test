package com.mao.test.webdata.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.security.NoSuchAlgorithmException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.mao.test.common.BaseResponse;
import com.mao.test.util.MD5Util;
import com.mao.test.webdata.service.ImageService;
import com.mao.test.webdata.vo.ResultVo;


@Controller
@RequestMapping("webdata/imageController")
public class ImageController {
	private Logger LOG=LoggerFactory.getLogger(ImageController.class);
	
	@Autowired
	private ImageService imageService;
	
	
	/** 
	 * 新增 - 提交 – 只保存文件到服务器上 
	 * @throws JimiException 
	 * @throws IOException 
	 * @throws NoSuchAlgorithmException 
	 */  
	@RequestMapping("/fileUpload")  
	public @ResponseBody BaseResponse<String> fileUpload(ModelMap model, @RequestParam(required=true) MultipartFile uploadFile ,@RequestParam(required=true) Integer imageType) throws IOException, NoSuchAlgorithmException{  
		LOG.info("文件提交，访问/fileUpload");
			BaseResponse<String> br = new BaseResponse<String>();
			/**
			 * 获取图片的名字
			 */
			String fileName = uploadFile.getOriginalFilename();
			/**
			 * 获取图片的输入流
			 */
	        InputStream img_inputString = uploadFile.getInputStream(); 
	        byte[] bytes = uploadFile.getBytes();
	        /**
	         * 截取图片后缀最后.jpg
	         */
	        String suffixFileName =null;
	        if(fileName !=null && !"".equals(fileName)){
	        	 suffixFileName = fileName.substring(fileName.lastIndexOf(".")).toLowerCase();
	        }else{
	        	br.setErrcode(ResultVo.FAILED);
	        	br.setErrmsg("请选择上传的图片");
				return br;
	        }
			/**
			 * 将图片的内容进行加密，并拼接后缀，得到新的文件名
			 */
			String newFileName = MD5Util.stringMD5(bytes)  + suffixFileName;
			/**
			 * 判断是否上上传酒的图片，如果是酒的图片必须为.jpg的图
			 */
			if(imageType == ImageService.WINE_JTT_IMGTYPE ){
				if (".jpg".equals(suffixFileName)) {
					/**
					 * 获取图片存储的目录
					 */
					File targetDir = new File(imageService.saveImageURLToServiceDir(imageType));
					/**
					 * 如果存储的文件夹不存在，就重新创建一个新文件夹
					 */
					if (!targetDir.exists()) {
						targetDir.mkdirs();
					}
					/**
					 * 判断，如果这个文件不存在就创建，否则不创建
					 */
					System.out.println("存储的文件夹:"+imageService.saveImageURLToService(newFileName, imageType));
					FileOutputStream fos = new FileOutputStream(imageService.saveImageURLToService(newFileName, imageType));//使用一个输出流，将文件输出出去
					
					byte[] bts = new byte[1024];
					int len = -1;
					while ((len = img_inputString.read(bts)) != -1) {
						fos.write(bts, 0, len);
					}
					fos.close();//关闭输出流
					img_inputString.close();//关闭输入流
					
					System.out.println("存储的位置"+imageService.getImageURLInService(newFileName,imageType));
					
					br.setErrcode(ResultVo.SUCCESS);
					br.setErrmsg("上传图片成功");
					br.setObject(imageService.getImageURLInService(newFileName,imageType));
				} else {
					br.setErrcode(ResultVo.FAILED);
		        	br.setErrmsg("酒标的图片必须是jpg格式!");
					return br;
				}
			}else{
				/**
				 * 获取图片存储的目录
				 */
				File targetDir = new File(imageService.saveImageURLToServiceDir(imageType));
				/**
				 * 如果存储的文件夹不存在，就重新创建一个新文件夹
				 */
				if (!targetDir.exists()) {
					targetDir.mkdirs();
				}
				/**
				 * 判断，如果这个文件不存在就创建，否则不创建
				 */
				System.out.println("存储的文件夹:"+imageService.saveImageURLToService(newFileName, imageType));
				FileOutputStream fos = new FileOutputStream(imageService.saveImageURLToService(newFileName, imageType));//使用一个输出流，将文件输出出去
				
				byte[] bts = new byte[1024];
				int len = -1;
				while ((len = img_inputString.read(bts)) != -1) {
					fos.write(bts, 0, len);
				}
				fos.close();//关闭输出流
				img_inputString.close();//关闭输入流
				
				System.out.println("存储的位置"+imageService.getImageURLInService(newFileName,imageType));
				br.setErrcode(ResultVo.SUCCESS);
				br.setErrmsg("上传图片成功");
				br.setObject(imageService.getImageURLInService(newFileName,imageType));
				return br;
			}
		return br;
	}  

}
