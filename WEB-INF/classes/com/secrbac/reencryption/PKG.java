package com.secrbac.reencryption;


import java.math.BigInteger;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.secrbac.util.MySQL;

public class PKG {

	public void set_key(String id) {

		RSA rsa = new RSA(id);
		try {
			Connection con = MySQL.getConnection();
			ResultSet rs = con.createStatement()
					.executeQuery("select count(*) from ENCKEYS where id='" + id + "' ");
			rs.next();
			if (rs.getInt(1) == 0) {
				PreparedStatement ps = con.prepareStatement("insert into ENCKEYS values (?,?,?,?) ");
				ps.setString(1, id);
				ps.setString(2, rsa.get_public_key().toString());
				ps.setString(3, rsa.get_private_key().toString());
				ps.setString(4, rsa.getn().toString());
				ps.execute();
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public BigInteger get_public_key(String id) throws Exception {

		BigInteger pk = BigInteger.valueOf(-1);
		set_key(id);

		try {
			Connection con = MySQL.getConnection();
			ResultSet rs = con.createStatement()
					.executeQuery("select publickey from ENCKEYS where id='" + id + "' ");
			if (rs != null && rs.next()) {
				pk = new BigInteger(rs.getString(1));
			}
			con.close();
			return pk;

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

	}

	public BigInteger get_private_key(String id) throws Exception { // Private
		// Key
		// generator

		BigInteger pk = BigInteger.valueOf(-1);
		set_key(id);

		try {
			Connection con = MySQL.getConnection();
			ResultSet rs = con.createStatement()
					.executeQuery("select privatekey from ENCKEYS where id='" + id + "' ");
			if (rs != null && rs.next()) {
				pk = new BigInteger(rs.getString(1));
			}
			con.close();
			return pk;

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	public BigInteger get_N(String id) throws Exception {

		BigInteger n = null;
		set_key(id);

		try {
			Connection con = MySQL.getConnection();
			ResultSet rs = con.createStatement().executeQuery("select n from ENCKEYS where id='" + id + "' ");
			if (rs != null && rs.next()) {
				n = new BigInteger(rs.getString(1));
			}
			con.close();
			return n;

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
