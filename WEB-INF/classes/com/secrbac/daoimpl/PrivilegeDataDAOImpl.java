package com.secrbac.daoimpl;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.secrbac.dao.PrivilegeDataDAO;
import com.secrbac.pojo.Data;
import com.secrbac.reencryption.Decrypt;
import com.secrbac.reencryption.PKG;
import com.secrbac.util.MySQL;

public class PrivilegeDataDAOImpl implements PrivilegeDataDAO {

	public Map<String, String> getDataDetails(String data_id) throws Exception {
		Connection con = null;
		Map<String, String> details = new HashMap<>();
		try {
			con = MySQL.getConnection();
			ResultSet rs = con.createStatement()
					.executeQuery("select * from keyvalue where data_id='" + data_id + "' ");
			while (rs.next()) {
				details.put(rs.getString("key_data"), rs.getString("value_data"));
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			con.close();
		}
		return details;
	}

	@Override
	public List<Data> getPrivilegeData(String email) throws Exception {
		Connection con = null;
		PKG pkg = new PKG();
		List<Data> data = new ArrayList<>();
		try {
			con = MySQL.getConnection();
			ResultSet rs = con.createStatement().executeQuery(
					"select * from user_role u, data d where u.data_id = d.data_id and u.email='" + email + "' ");

			while (rs.next()) {
				Data d = new Data();
				d.setData_id(rs.getString("u.data_id"));
				d.setOwner_id(rs.getString("d.owner_id"));
				d.setDesc(Decrypt.decrypt(rs.getString("d.description"), pkg.get_N(rs.getString("d.owner_id")),
						pkg.get_private_key(rs.getString("d.owner_id"))));
				d.setRule_id(rs.getString("u.role_name"));
				data.add(d);
			}

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			con.close();
		}

		return data;
	}

	@Override
	public int checkPrivilege(String data_id, String email) throws Exception {
		Connection con = null;
		int access = 0;
		try {
			con = MySQL.getConnection();
			ResultSet rs = con.createStatement().executeQuery(
					"select a.read_access, a.update_access, a.delete_access from user_role u, auth_rules a, data d where u.role_name = a.role_name and a.rule_id=d.rule_id and u.email='"
							+ email + "' and u.data_id='" + data_id + "'  ");
			System.out.println("select a.read_access, a.update_access, a.delete_access from user_role u, auth_rules a, data d where u.role_name = a.role_name and a.rule_id=d.rule_id and u.email='"
					+ email + "' and u.data_id='" + data_id + "'");
			rs.next();
			if (rs.getString("read_access").equals("Yes")) {
				access = 1;
			}
			if (rs.getString("update_access").equals("Yes")) {
				access = 2;
			}
			if (rs.getString("delete_access").equals("Yes")) {
				access = 4;
			}

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			con.close();
		}
		return access;
	}

}
