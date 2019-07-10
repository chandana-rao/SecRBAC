package com.secrbac.util;

import java.net.URI;
import java.sql.Connection;
import java.sql.DriverManager;

public class MySQL {

	public static Connection getConnection() throws Exception {
//		Class.forName("com.mysql.jdbc.Driver");
//		return DriverManager.getConnection("jdbc:mysql://localhost:3306/SecRBACDB", "root", "chandana_rao");
	
		URI dbUri = new URI(System.getenv("CLEARDB_DATABASE_URL"));

		String username = dbUri.getUserInfo().split(":")[0];
		String password = dbUri.getUserInfo().split(":")[1];
		String dbUrl = "jdbc:mysql://" + dbUri.getHost() + dbUri.getPath();

		return DriverManager.getConnection(dbUrl, username, password);

	}
}
