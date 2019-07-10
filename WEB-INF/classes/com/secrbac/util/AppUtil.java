package com.secrbac.util;

public class AppUtil {

	public static String generateRuleID() {
		return "RULE" + String.valueOf(System.currentTimeMillis());
	}
	public static String generateDataID() {
		return "DATA" + String.valueOf(System.currentTimeMillis());
	}
}
