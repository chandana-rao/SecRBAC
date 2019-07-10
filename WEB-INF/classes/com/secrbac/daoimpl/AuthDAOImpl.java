package com.secrbac.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.secrbac.dao.AuthDAO;
import com.secrbac.pojo.AuthBean;
import com.secrbac.util.MySQL;

public class AuthDAOImpl implements AuthDAO {

	@Override
	public Map<String, List<AuthBean>> getAll(String owner) throws Exception {
		Map<String, List<AuthBean>> result = new HashMap<>();

		Connection con = null;
		try {
			con = MySQL.getConnection();
			ResultSet rs = con.createStatement()
					.executeQuery("select distinct(rule_id) from AUTH_RULES where owner_id='" + owner + "' ");

			while (rs.next()) {
				String rule_id = rs.getString("rule_id");
				ResultSet rs2 = con.createStatement().executeQuery(
						"select * from AUTH_RULES where owner_id='" + owner + "' and rule_id='" + rule_id + "'   ");
				List<AuthBean> rules = new ArrayList<>();

				while (rs2.next()) {
					AuthBean auth = new AuthBean();
					auth.setOwner_id(owner);
					auth.setRole_name(rs2.getString("role_name"));
					auth.setRule_id(rs2.getString("rule_id"));
					auth.setRead(rs2.getString("read_access"));
					auth.setUpdate(rs2.getString("update_access"));
					auth.setDelete(rs2.getString("delete_access"));
					rules.add(auth);
				}
				result.put(rule_id, rules);
			}

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			con.close();
		}

		return result;
	}

	@Override
	public void addRule(AuthBean auth) throws Exception {
		Connection con = null;
		try {
			con = MySQL.getConnection();
			PreparedStatement ps = con.prepareStatement("insert into AUTH_RULES values (?,?,?,?,?,?) ");
			ps.setString(1, auth.getRule_id());
			ps.setString(2, auth.getOwner_id());
			ps.setString(3, auth.getRole_name());
			ps.setString(4, auth.getRead());
			ps.setString(5, auth.getUpdate());
			ps.setString(6, auth.getDelete());
			ps.execute();
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			con.close();
		}

	}

	@Override
	public void deleteRule(String rule_id) throws Exception {
		Connection con = null;
		try {
			con = MySQL.getConnection();
			con.createStatement().execute("delete from AUTH_RULES where rule_id='" + rule_id + "'");
			con.createStatement().execute("update DATA set rule_id=NULL where rule_id='"+rule_id+"'" );
							
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			con.close();
		}

	}

	@Override
	public Map<String, Integer> getRoleNames(String rule_id) throws Exception {
		Connection con = null;
		Map<String, Integer> result = new HashMap<>();
		try {
			con = MySQL.getConnection();
			ResultSet rs = con.createStatement()
					.executeQuery("select * from AUTH_RULES where rule_id='" + rule_id + "' ");
			while (rs.next()) {
				String role_name = rs.getString("role_name");
				String read = rs.getString("read_access");
				String update = rs.getString("update_access");
				String delete = rs.getString("delete_access");
				int access = 0;
				if (read.equals("Yes")) {
					access = 1;
				}
				if (update.equals("Yes")) {
					access = 2;
				}
				if (delete.equals("Yes")) {
					access = 4;
				}
				result.put(role_name, access);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			con.close();
		}
		return result;

	}

}
