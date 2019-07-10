package com.secrbac.dao;

import java.util.List;
import java.util.Map;

import com.secrbac.pojo.AuthBean;
import com.secrbac.pojo.Data;

public interface DataDAO {

	void delete_data(String data_id) throws Exception;

	void write_data(String ownerid, String desc, String[] key, String[] val) throws Exception;

	List<Data> getData(String owner_id) throws Exception;

	Data getDataByID(String data_id, String owner_id) throws Exception;

	void update_data(String data_id, String email, String desc, String[] key_arr, String[] value_arr) throws Exception;

	List<AuthBean> getAuthRule(String data_id) throws Exception;

	void applyAuthRule(String data_id, String rule_id) throws Exception;

	Map<String, String> getMappedUsers(String data_id) throws Exception;

	String getRuleID(String data_id) throws Exception;

	void mapUser(String data_id, String email, String role_name) throws Exception;

	void removeMappedUser(String email, String data_id) throws Exception;

	Map<String, String> getDetails(String data_id) throws Exception;
	
	public String getOwnerID(String data_id) throws Exception;

}
