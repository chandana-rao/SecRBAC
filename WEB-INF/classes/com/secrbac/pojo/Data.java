package com.secrbac.pojo;

import java.util.Map;

public class Data {

	String owner_id;
	String data_id;
	String desc;
	Map<String, String> keyvalue;
	String rule_id;
	public String getOwner_id() {
		return owner_id;
	}
	public void setOwner_id(String owner_id) {
		this.owner_id = owner_id;
	}
	public String getData_id() {
		return data_id;
	}
	public void setData_id(String data_id) {
		this.data_id = data_id;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public Map<String, String> getKeyvalue() {
		return keyvalue;
	}
	public void setKeyvalue(Map<String, String> keyvalue) {
		this.keyvalue = keyvalue;
	}
	public String getRule_id() {
		return rule_id;
	}
	public void setRule_id(String rule_id) {
		this.rule_id = rule_id;
	}
	
	
	
}
