package com.secrbac.daoimpl;

import java.math.BigInteger;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.secrbac.dao.DataDAO;
import com.secrbac.pojo.AuthBean;
import com.secrbac.pojo.Data;
import com.secrbac.reencryption.Decrypt;
import com.secrbac.reencryption.Encrypt;
import com.secrbac.reencryption.PKG;
import com.secrbac.util.AppUtil;
import com.secrbac.util.MySQL;

public class DataDAOImpl implements DataDAO {

	public void delete_data(String data_id) throws Exception {
		Connection con = null;
		try {
			con = MySQL.getConnection();
			con.setAutoCommit(false);
			con.createStatement().execute("delete from data where data_id='" + data_id + "'  ");
			con.createStatement().execute("delete from user_role where data_id='" + data_id + "'  ");
			con.createStatement().execute("delete from keyvalue where data_id='" + data_id + "'  ");
			con.commit();
		} catch (Exception e) {
			e.printStackTrace();
			con.rollback();
			throw e;
		} finally {
			con.close();
		}

	}

	@Override
	public void write_data(String ownerid, String desc, String[] key, String[] val) throws Exception {

		Connection con = null;
		PKG pkg = new PKG();
		try {
			con = MySQL.getConnection();
			con.setAutoCommit(false);
			BigInteger n = pkg.get_N(ownerid);
			BigInteger pk = pkg.get_public_key(ownerid);

			String desc_enc = Encrypt.encrypt(desc, n, pk);
			String data_id = AppUtil.generateDataID();
			PreparedStatement ps = con
					.prepareStatement("insert into DATA (data_id, description, owner_id) values (?,?,?)");
			ps.setString(1, data_id);
			ps.setString(2, desc_enc);
			ps.setString(3, ownerid);
			ps.execute();

			for (int i = 0; i < key.length; i++) {
				PreparedStatement ps2 = con
						.prepareStatement("insert into KEYVALUE (data_id, key_data, value_data) values (?,?,?) ");
				ps2.setString(1, data_id);
				ps2.setString(2, Encrypt.encrypt(key[i], n, pk));
				ps2.setString(3, Encrypt.encrypt(val[i], n, pk));
				ps2.execute();
			}
			con.commit();
		} catch (Exception e) {
			e.printStackTrace();
			con.rollback();
			throw e;
		} finally {
			con.close();
		}

	}

	public Data getDataByID(String data_id, String owner_id) throws Exception {
		Connection con = null;
		PKG pkg = new PKG();
		Data data = new Data();
		try {
			con = MySQL.getConnection();
			BigInteger n = pkg.get_N(owner_id);
			BigInteger pk = pkg.get_private_key(owner_id);

			ResultSet rs = con.createStatement().executeQuery("select * from DATA where data_id='" + data_id + "' ");
			rs.next();
			data.setOwner_id(owner_id);
			data.setData_id(rs.getString("data_id"));
			data.setDesc(Decrypt.decrypt(rs.getString("description"), n, pk));

			ResultSet rs2 = con.createStatement()
					.executeQuery("select * from keyvalue where data_id='" + rs.getString("data_id") + "' ");
			Map<String, String> keyvalues = new HashMap<>();
			while (rs2.next()) {

				keyvalues.put(Decrypt.decrypt(rs2.getString("key_data"), n, pk),
						(Decrypt.decrypt(rs2.getString("value_data"), n, pk)));
			}
			data.setKeyvalue(keyvalues);

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			con.close();
		}

		return data;
	}

	@Override
	public List<Data> getData(String owner_id) throws Exception {
		Connection con = null;
		PKG pkg = new PKG();
		List<Data> result = new ArrayList<>();
		try {
			con = MySQL.getConnection();
			BigInteger n = pkg.get_N(owner_id);
			BigInteger pk = pkg.get_private_key(owner_id);

			ResultSet rs = con.createStatement().executeQuery("select * from DATA where owner_id='" + owner_id + "' ");
			while (rs.next()) {
				Data data = new Data();
				data.setOwner_id(owner_id);
				data.setData_id(rs.getString("data_id"));
				data.setDesc(Decrypt.decrypt(rs.getString("description"), n, pk));

				ResultSet rs2 = con.createStatement()
						.executeQuery("select * from keyvalue where data_id='" + rs.getString("data_id") + "' ");
				Map<String, String> keyvalues = new HashMap<>();
				while (rs2.next()) {

					keyvalues.put(Decrypt.decrypt(rs2.getString("key_data"), n, pk),
							(Decrypt.decrypt(rs2.getString("value_data"), n, pk)));
				}
				data.setKeyvalue(keyvalues);
				result.add(data);
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
	public void update_data(String data_id, String ownerid, String desc, String[] key, String[] val) throws Exception {
		Connection con = null;
		PKG pkg = new PKG();
		try {
			con = MySQL.getConnection();
			con.setAutoCommit(false);
			
			ResultSet rs = con.createStatement().executeQuery("select rule_id from data where data_id='"+data_id+"' ");
			rs.next();
			String rule_id = rs.getString(1);
			rs.close();
			
			con.createStatement().execute("delete from DATA where data_id='" + data_id + "' ");
			con.createStatement().execute("delete from KEYVALUE where data_id='" + data_id + "' ");

			BigInteger n = pkg.get_N(ownerid);
			BigInteger pk = pkg.get_public_key(ownerid);

			System.out.println("Desc // " + desc);
			String desc_enc = Encrypt.encrypt(desc, n, pk);
			PreparedStatement ps = con
					.prepareStatement("insert into DATA (data_id, description, owner_id, rule_id) values (?,?,?,?)");
			ps.setString(1, data_id);
			ps.setString(2, desc_enc);
			ps.setString(3, ownerid);
			ps.setString(4, rule_id);
			ps.execute();

			for (int i = 0; i < key.length; i++) {
				PreparedStatement ps2 = con
						.prepareStatement("insert into KEYVALUE (data_id, key_data, value_data) values (?,?,?) ");
				ps2.setString(1, data_id);
				ps2.setString(2, Encrypt.encrypt(key[i], n, pk));
				ps2.setString(3, Encrypt.encrypt(val[i], n, pk));
				ps2.execute();
			}
			con.commit();
		} catch (Exception e) {
			e.printStackTrace();
			con.rollback();
			throw e;
		} finally {
			con.close();
		}

	}

	@Override
	public List<AuthBean> getAuthRule(String data_id) throws Exception {
		Connection con = null;
		List<AuthBean> auth_rules = new ArrayList<>();
		try {
			con = MySQL.getConnection();
			ResultSet rs = con.createStatement().executeQuery(
					"select a.owner_id, a.rule_id, a.role_name, a.read_access, a.update_access, a.delete_access from AUTH_RULES a, DATA d where a.rule_id=d.rule_id and d.data_id='"
							+ data_id + "' ");

			while (rs.next()) {
				AuthBean auth = new AuthBean();
				auth.setOwner_id(rs.getString("owner_id"));
				auth.setRule_id(rs.getString("rule_id"));
				auth.setRole_name(rs.getString("role_name"));
				auth.setRead(rs.getString("read_access"));
				auth.setUpdate(rs.getString("update_access"));
				auth.setDelete(rs.getString("delete_access"));
				auth_rules.add(auth);
			}
			return auth_rules;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			con.close();
		}
	}

	@Override
	public void applyAuthRule(String data_id, String rule_id) throws Exception {
		Connection con = null;
		try {
			con = MySQL.getConnection();
			con.createStatement().execute("update DATA set rule_id='" + rule_id + "' where data_id='" + data_id + "' ");

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			con.close();
		}
	}

	@Override
	public Map<String, String> getMappedUsers(String data_id) throws Exception {
		Connection con = null;
		Map<String, String> users = new HashMap<>();
		try {
			con = MySQL.getConnection();
			ResultSet rs = con.createStatement()
					.executeQuery("select * from USER_ROLE where data_id='" + data_id + "' ");
			while (rs.next()) {
				users.put(rs.getString("email"), rs.getString("role_name"));
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			con.close();
		}
		return users;
	}

	@Override
	public String getRuleID(String data_id) throws Exception {
		Connection con = null;
		String rule_id = "";
		try {
			con = MySQL.getConnection();
			ResultSet rs = con.createStatement()
					.executeQuery("select rule_id from DATA where data_id='" + data_id + "' ");
			rs.next();
			rule_id = rs.getString("rule_id");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			con.close();
		}
		return rule_id;

	}

	@Override
	public void mapUser(String data_id, String email, String role_name) throws Exception {
		Connection con = null;
		try {
			con = MySQL.getConnection();
			con.createStatement()
					.execute("insert into user_role values ('" + email + "','" + data_id + "','" + role_name + "') ");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			con.close();
		}

	}

	@Override
	public void removeMappedUser(String email, String data_id) throws Exception {
		Connection con = null;
		try {
			con = MySQL.getConnection();
			con.createStatement()
					.execute("delete from USER_ROLE where data_id='" + data_id + "' and email='" + email + "' ");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			con.close();
		}

	}

	@Override
	public Map<String, String> getDetails(String data_id) throws Exception {
		Connection con = null;
		PKG pkg = new PKG();

		Map<String, String> keyvalue = new HashMap<>();
		try {
			con = MySQL.getConnection();
			ResultSet rs = con.createStatement()
					.executeQuery("select owner_id from data where data_id='" + data_id + "' ");
			rs.next();
			String owner_id = rs.getString("owner_id");

			ResultSet rs2 = con.createStatement()
					.executeQuery("select * from keyvalue where data_id='" + data_id + "' ");
			while (rs2.next()) {
				keyvalue.put(
						Decrypt.decrypt(rs2.getString("key_data"), pkg.get_N(owner_id), pkg.get_private_key(owner_id)),
						Decrypt.decrypt(rs2.getString("value_data"), pkg.get_N(owner_id),
								pkg.get_private_key(owner_id)));
			}

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			con.close();
		}
		return keyvalue;
	}

	public String getOwnerID(String data_id) throws Exception {
		Connection con = null;
		try {
			con = MySQL.getConnection();
			ResultSet rs = con.createStatement().executeQuery("select owner_id from data where data_id='"+data_id+"' ");
			rs.next();
			return rs.getString("owner_id");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			con.close();
		}
	}
}
