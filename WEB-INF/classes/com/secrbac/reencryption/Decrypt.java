package com.secrbac.reencryption;

import java.math.BigInteger;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class Decrypt {

	public static String decrypt(String encMsg, BigInteger n, BigInteger private_key) throws Exception {
		return new String(decryptMessage(new BigInteger(encMsg).toByteArray(), private_key, n));
		
//		return new String (decryptMessage(encMsg.getBytes("UTF-8"), private_key, n), "US-ASCII");
	}

	private static String bytesToString(byte[] encrypted) {

		String test = "";

		for (byte b : encrypted) {
			test += Byte.toString(b);
		}

		return test;

	}

	public static byte[] decryptMessage(byte[] message, BigInteger private_key, BigInteger n) { // Actual
		// Message
		// Decryption

		return (new BigInteger(message)).modPow(private_key, n).toByteArray();

	}

}
