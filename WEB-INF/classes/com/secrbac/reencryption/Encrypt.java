package com.secrbac.reencryption;

import java.math.BigInteger;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class Encrypt {

	// Encrypt message
	public static String encrypt(String message, BigInteger n, BigInteger public_key) throws Exception {

		BigInteger bi = new BigInteger(messageEncrypt(message.getBytes(), public_key, n));
		return bi.toString();

//		return new String (messageEncrypt(message.getBytes("UTF-8"), public_key, n), "US-ASCII");
	}

	private static byte[] messageEncrypt(byte[] message, BigInteger public_key, BigInteger n) {
		return (new BigInteger(message)).modPow(public_key, n).toByteArray();

	}

	private static String bytesToString(byte[] encrypted) {

		String test = "";

		for (byte b : encrypted) {
			test += Byte.toString(b);
			// test +=" ";
		}

		return test;

	}

}
