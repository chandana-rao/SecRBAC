package com.secrbac.dao;

import java.util.List;
import java.util.Map;

import com.secrbac.pojo.Data;

public interface PrivilegeDataDAO {

	List<Data> getPrivilegeData(String email) throws Exception;

	int checkPrivilege(String data_id, String email) throws Exception;

	public Map<String, String> getDataDetails(String data_id) throws Exception;

}
