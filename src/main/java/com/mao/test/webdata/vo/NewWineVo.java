package com.mao.test.webdata.vo;

import com.mao.test.util.DateHelper;

public class NewWineVo {

	private String wine_id;  //红酒id
	private String wine_name_cn;
	private String wine_name_en;
	private String area_1; //产区编码1
	private String area_2; //产区编码2
	private String area_3; //产区编码3
	private String area_4; //产区编码4
	private String area_5; //产区编码5
	private String area_code;//产区编码
	private String area_6; 		//酒庄/酒商
	private String chateau_code;//酒庄/酒商
	private String brand;		//品牌
	private String brand_code; //品牌编码
	private String wine_type;	//酒类型
	private String wine_type_code;//酒类型编码
	private String level;	  //等级
	private String level_code;//等级编码
	private String vintages; //酒年份
	private String wine_code; //酒款编码
	private String alcohol;  // 酒精度
	private String grape_varieties; //葡萄品种
	private String capacity;		//容量
	private String bottle_type;  //瓶子图名
	private String foods;       //搭配美食
	private String occasion;  //适用场合
	private String awake_time;//建议醒酒时间
	private String temperature;  //最佳品尝温度
	private String short_for_cn;//中文简称
	private String short_for_en;//英文简称
	private String comment_cn;//中文点评
	private String comment_en;//英文点评
	private String source;  //来源
	private String bar_code;//条形码
	private String brew;//酿造
	private String color;//颜色
	private String cork;//瓶塞
	private String honor;//获得荣耀
	private String smell;//气味
	private String taste;//口味
	private String wine_body;//酒体
	private Integer num;
	private String add_time;//
	private String update_time;//
	private String state;
	private int wine_jtt_id;
	
	public NewWineVo(){
		
	}
	/**
	 * 基本信息构造器
	 */
	public NewWineVo(
			String wine_id,
			String wine_name_cn,
			String wine_name_en,
			String area_1,
			String area_2,
			String area_3,
			String area_4,
			String area_5,
			String area_code,
			String area_6,
			String chateau_code,
			String brand,
			String brand_code,
			String wine_type,
			String wine_type_code,
			String level,
			String level_code,
			String vintages,
			String wine_code,
			String alcohol,
			String grape_varieties,
			String capacity){
		this(
				wine_id,
				wine_name_cn, 
				wine_name_en, 
				area_1, 
				area_2, 
				area_3, 
				area_4, 
				area_5, 
				area_code, 
				area_6, 
				chateau_code, 
				brand, 
				brand_code, 
				wine_type, 
				wine_type_code, 
				level, 
				level_code, 
				vintages, 
				wine_code, 
				alcohol, 
				grape_varieties,
				capacity,"","","","","","","",
				"","","999","","","","","","","","",0,DateHelper.getDateString(DateHelper.currentDate()),DateHelper.getDateString(DateHelper.currentDate()),
				"N");
	}
	/**
	 * 品牌信息构造器
	 * @param comment_cn
	 * @param comment_en
	 * @param foods
	 * @param occasion
	 * @param awake_time
	 * @param temperature
	 * @param wine_id
	 */
	public NewWineVo(String comment_cn,String comment_en,String foods,
			String occasion, String awake_time,String temperature,String wine_id){
		this(wine_id, "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "",
				"", "", "", foods, occasion, awake_time, temperature, "", "", comment_cn, comment_en, 
				"", "", "", "", "", "", "", "", "", 0, "", "", "");
	}
	/**
	 * 运营信息构造器
	 * @param state
	 * @param short_for_cn
	 * @param short_for_en
	 * @param bottle_type
	 * @param bar_code
	 * @param wine_id
	 */
	public NewWineVo(String state,String short_for_cn,String short_for_en,
			String bottle_type,String bar_code,String wine_id){
		this(wine_id, "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", 
				"", bottle_type, "", "", "", "", short_for_cn, short_for_en, "", "", "", bar_code, "", "", "", "", "", "", "", 0, "", "", state);
	}
	
	/**
	 * 全属性构造器
	 */
	public NewWineVo( String wine_id,  //红酒id
	 String wine_name_cn,
	 String wine_name_en,
	 String area_1, //产区编码1
	 String area_2, //产区编码2
	 String area_3, //产区编码3
	 String area_4, //产区编码4
	 String area_5, //产区编码5
	 String area_code,//产区编码
	 String area_6, 		//酒庄/酒商
	 String chateau_code,//酒庄/酒商
	 String brand,		//品牌
	 String brand_code, //品牌编码
	 String wine_type,	//酒类型
	 String wine_type_code,//酒类型编码
	 String level,	  //等级
	 String level_code,//等级编码
	 String vintages, //酒年份
	 String wine_code, //酒款编码
	 String alcohol,  // 酒精度
	 String grape_varieties, //葡萄品种
	 String capacity,		//容量
	 String bottle_type,  //瓶子图名
     String foods,      //搭配美食
	 String occasion,  //适用场合
	 String awake_time,//建议醒酒时间
	 String temperature,  //最佳品尝温度
	 String short_for_cn,//中文简称
	 String short_for_en,//英文简称
	 String comment_cn,//中文点评
	 String comment_en,//英文点评
	 String source,  //来源
	 String bar_code,//条形码
	 String brew,//酿造
	 String color,//颜色
	 String cork,//瓶塞
	 String honor,//获得荣耀
	 String smell,//气味
	 String taste,//口味
	 String wine_body,//酒体
	 Integer num,
	 String add_time,//
	 String update_time,//
	 String state){
		this.wine_id=wine_id;  //红酒id
		this.wine_name_cn=wine_name_cn;
		this.wine_name_en=wine_name_en;
		this.area_1=area_1; //产区编码1
		this.area_2=area_2; //产区编码2
		this.area_3=area_3;//产区编码3
		this.area_4=area_4;//产区编码4
		this.area_5=area_5; //产区编码5
		this.area_code=area_code;//产区编码
		this.area_6=area_6;	//酒庄/酒商
		this.chateau_code=chateau_code;//酒庄/酒商
		this.brand=brand;	//品牌
		this.brand_code=brand_code; //品牌编码
		this.wine_type=wine_type;	//酒类型
		this.wine_type_code=wine_type_code;//酒类型编码
		this.level=level;  //等级
		this.level_code=level_code;//等级编码
		this.vintages=vintages; //酒年份
		this.wine_code=wine_code;//酒款编码
		this.alcohol=alcohol;  // 酒精度
		this.grape_varieties=grape_varieties; //葡萄品种
		this.capacity=capacity;		//容量
		this.bottle_type=bottle_type; //瓶子图名
		this.foods=foods;      //搭配美食
		this.occasion=occasion; //适用场合
		this.awake_time=awake_time;//建议醒酒时间
		this.temperature=temperature; //最佳品尝温度
		this.short_for_cn=short_for_cn;//中文简称
		this.short_for_en=short_for_en;//英文简称
		this.comment_cn=comment_cn;//中文点评
		this.comment_en=comment_en;//英文点评
		this.source=source;  //来源
		this.bar_code=bar_code;//条形码
		this.brew=brew;//酿造
		this.color=color;//颜色
		this.cork=cork;//瓶塞
		this.honor=honor;//获得荣耀
		this.smell=smell;//气味
		this.taste=taste;//口味
		this.wine_body=wine_body;//酒体
		this.num=num;
		this.add_time=add_time;//
		this.update_time=update_time;//
		this.state=state;
	}
	
	
	public String getWine_id() {
		return wine_id;
	}
	public void setWine_id(String wine_id) {
		this.wine_id = wine_id;
	}
	public String getWine_name_cn() {
		return wine_name_cn;
	}
	public void setWine_name_cn(String wine_name_cn) {
		this.wine_name_cn = wine_name_cn;
	}
	public String getWine_name_en() {
		return wine_name_en;
	}
	public void setWine_name_en(String wine_name_en) {
		this.wine_name_en = wine_name_en;
	}
	public String getArea_1() {
		return area_1;
	}
	public void setArea_1(String area_1) {
		this.area_1 = area_1;
	}
	public String getArea_2() {
		return area_2;
	}
	public void setArea_2(String area_2) {
		this.area_2 = area_2;
	}
	public String getArea_3() {
		return area_3;
	}
	public void setArea_3(String area_3) {
		this.area_3 = area_3;
	}
	public String getArea_4() {
		return area_4;
	}
	public void setArea_4(String area_4) {
		this.area_4 = area_4;
	}
	public String getArea_5() {
		return area_5;
	}
	public void setArea_5(String area_5) {
		this.area_5 = area_5;
	}
	public String getArea_code() {
		return area_code;
	}
	public void setArea_code(String area_code) {
		this.area_code = area_code;
	}
	public String getArea_6() {
		return area_6;
	}
	public void setArea_6(String area_6) {
		this.area_6 = area_6;
	}
	public String getChateau_code() {
		return chateau_code;
	}
	public void setChateau_code(String chateau_code) {
		this.chateau_code = chateau_code;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getBrand_code() {
		return brand_code;
	}
	public void setBrand_code(String brand_code) {
		this.brand_code = brand_code;
	}
	public String getWine_type() {
		return wine_type;
	}
	public void setWine_type(String wine_type) {
		this.wine_type = wine_type;
	}
	public String getWine_type_code() {
		return wine_type_code;
	}
	public void setWine_type_code(String wine_type_code) {
		this.wine_type_code = wine_type_code;
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public String getLevel_code() {
		return level_code;
	}
	public void setLevel_code(String level_code) {
		this.level_code = level_code;
	}
	public String getVintages() {
		return vintages;
	}
	public void setVintages(String vintages) {
		this.vintages = vintages;
	}
	public String getWine_code() {
		return wine_code;
	}
	public void setWine_code(String wine_code) {
		this.wine_code = wine_code;
	}
	public String getAlcohol() {
		return alcohol;
	}
	public void setAlcohol(String alcohol) {
		this.alcohol = alcohol;
	}
	public String getGrape_varieties() {
		return grape_varieties;
	}
	public void setGrape_varieties(String grape_varieties) {
		this.grape_varieties = grape_varieties;
	}
	public String getCapacity() {
		return capacity;
	}
	public void setCapacity(String capacity) {
		this.capacity = capacity;
	}
	public String getBottle_type() {
		return bottle_type;
	}
	public void setBottle_type(String bottle_type) {
		this.bottle_type = bottle_type;
	}
	public String getFoods() {
		return foods;
	}
	public void setFoods(String foods) {
		this.foods = foods;
	}
	public String getOccasion() {
		return occasion;
	}
	public void setOccasion(String occasion) {
		this.occasion = occasion;
	}
	public String getAwake_time() {
		return awake_time;
	}
	public void setAwake_time(String awake_time) {
		this.awake_time = awake_time;
	}
	public String getTemperature() {
		return temperature;
	}
	public void setTemperature(String temperature) {
		this.temperature = temperature;
	}
	public String getShort_for_cn() {
		return short_for_cn;
	}
	public void setShort_for_cn(String short_for_cn) {
		this.short_for_cn = short_for_cn;
	}
	public String getShort_for_en() {
		return short_for_en;
	}
	public void setShort_for_en(String short_for_en) {
		this.short_for_en = short_for_en;
	}
	public String getComment_cn() {
		return comment_cn;
	}
	public void setComment_cn(String comment_cn) {
		this.comment_cn = comment_cn;
	}
	public String getComment_en() {
		return comment_en;
	}
	public void setComment_en(String comment_en) {
		this.comment_en = comment_en;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public String getBar_code() {
		return bar_code;
	}
	public void setBar_code(String bar_code) {
		this.bar_code = bar_code;
	}
	public String getBrew() {
		return brew;
	}
	public void setBrew(String brew) {
		this.brew = brew;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getCork() {
		return cork;
	}
	public void setCork(String cork) {
		this.cork = cork;
	}
	public String getHonor() {
		return honor;
	}
	public void setHonor(String honor) {
		this.honor = honor;
	}
	public String getSmell() {
		return smell;
	}
	public void setSmell(String smell) {
		this.smell = smell;
	}
	public String getTaste() {
		return taste;
	}
	public void setTaste(String taste) {
		this.taste = taste;
	}
	public String getWine_body() {
		return wine_body;
	}
	public void setWine_body(String wine_body) {
		this.wine_body = wine_body;
	}
	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
	}
	public String getAdd_time() {
		return add_time;
	}
	public void setAdd_time(String add_time) {
		this.add_time = add_time;
	}
	public String getUpdate_time() {
		return update_time;
	}
	public void setUpdate_time(String update_time) {
		this.update_time = update_time;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	
	@Override
	public String toString() {
		return "NewWineVo [wine_id=" + wine_id + ", wine_name_cn=" + wine_name_cn + ", wine_name_en=" + wine_name_en
				+ ", area_1=" + area_1 + ", area_2=" + area_2 + ", area_3=" + area_3 + ", area_4=" + area_4
				+ ", area_5=" + area_5 + ", area_code=" + area_code + ", area_6=" + area_6 + ", chateau_code="
				+ chateau_code + ", brand=" + brand + ", brand_code=" + brand_code + ", wine_type=" + wine_type
				+ ", wine_type_code=" + wine_type_code + ", level=" + level + ", level_code=" + level_code
				+ ", vintages=" + vintages + ", wine_code=" + wine_code + ", alcohol=" + alcohol + ", grape_varieties="
				+ grape_varieties + ", capacity=" + capacity + ", bottle_type=" + bottle_type + ", foods=" + foods
				+ ", occasion=" + occasion + ", awake_time=" + awake_time + ", temperature=" + temperature
				+ ", short_for_cn=" + short_for_cn + ", short_for_en=" + short_for_en + ", comment_cn=" + comment_cn
				+ ", comment_en=" + comment_en + ", source=" + source + ", bar_code=" + bar_code + ", brew=" + brew
				+ ", color=" + color + ", cork=" + cork + ", honor=" + honor + ", smell=" + smell + ", taste=" + taste
				+ ", wine_body=" + wine_body + ", num=" + num + ", add_time=" + add_time + ", update_time="
				+ update_time + ", state=" + state +  "]";
	}
	public int getWine_jtt_id() {
		return wine_jtt_id;
	}
	public void setWine_jtt_id(int wine_jtt_id) {
		this.wine_jtt_id = wine_jtt_id;
	}
	
	
	
}
