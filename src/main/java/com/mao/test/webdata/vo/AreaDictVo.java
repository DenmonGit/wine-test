package com.mao.test.webdata.vo;

public class AreaDictVo {
	private String id;		//产地的id，对应数据库中的code
	private String name;	//名字，对应数据库中的name_cn
	
	private String name_en;	//名字，对应数据库中的name_en
	
	private String state="closed";//状态
	private String _parentId;//父id，对应数据库中的  parent_code
	
	private Integer level;	//等级
	private String name_pinyin;
	private String area_1;
	private String area_2;
	private String area_3;
	private String area_4;
	private String area_5;
	private String aliases;
	private String parents_str_cn;
	private String parents_str_en;
	private String parents_pinyin;
	private String add_time;
	private String update_time;
	private Integer number;
	
	private String outSideUrl;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getName_en() {
		return name_en;
	}

	public void setName_en(String name_en) {
		this.name_en = name_en;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String get_parentId() {
		return _parentId;
	}

	public void set_parentId(String _parentId) {
		this._parentId = _parentId;
	}

	public Integer getLevel() {
		return level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

	public String getName_pinyin() {
		return name_pinyin;
	}

	public void setName_pinyin(String name_pinyin) {
		this.name_pinyin = name_pinyin;
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

	public String getAliases() {
		return aliases;
	}

	public void setAliases(String aliases) {
		this.aliases = aliases;
	}

	public String getParents_str_cn() {
		return parents_str_cn;
	}

	public void setParents_str_cn(String parents_str_cn) {
		this.parents_str_cn = parents_str_cn;
	}

	public String getParents_str_en() {
		return parents_str_en;
	}

	public void setParents_str_en(String parents_str_en) {
		this.parents_str_en = parents_str_en;
	}

	public String getParents_pinyin() {
		return parents_pinyin;
	}

	public void setParents_pinyin(String parents_pinyin) {
		this.parents_pinyin = parents_pinyin;
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

	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}

	public String getOutSideUrl() {
		return outSideUrl;
	}

	public void setOutSideUrl(String outSideUrl) {
		this.outSideUrl = outSideUrl;
	}
	
	
}
