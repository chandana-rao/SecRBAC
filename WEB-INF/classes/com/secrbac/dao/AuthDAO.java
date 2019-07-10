package com.secrbac.dao;

import java.util.List;
import java.util.Map;

import com.secrbac.pojo.AuthBean;

public interface AuthDAO {

	public Map<String, List<AuthBean>> getAll(String owner) throws Exception;

	public void addRule(AuthBean auth) throws Exception;

	public void deleteRule(String rule_id) throws Exception;

	public Map<String, Integer> getRoleNames(String rule_id) throws Exception;

}
