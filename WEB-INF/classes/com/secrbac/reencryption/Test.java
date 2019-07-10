package com.secrbac.reencryption;

public class Test {

	public static void main(String[] args) throws Exception {

		PKG pkg = new PKG();

		// Proxy re-encryption: When user A wants to share the data with user B, he is going to encrypt the data with A's public key, but he doesn't want B to let know his private key for decryption.
		// Hence we use proxy, the proxy is going to re-encrypt the data with B's public key. So, B can decrypt it using its own private key
		// In this approach, the proxy has to be trusted. 
		
		// User A to proxy encrypts the data using A's public key
		String msg = "Welcome";
		System.out.println("Message : " + msg);
		String encMsg = Encrypt.encrypt(msg, pkg.get_N("A"), pkg.get_public_key("A"));
		System.out.println("User A Encryption : " + encMsg);
		
		
		
		// Proxy to cloud
//		System.out.println("Prxoy: msg : "+encMsg);
//		String encMsg2 = Encrypt.encrypt(encMsg, pkg.get_N("pp"), pkg.get_public_key("pp"));
//		System.out.println("Proxy : Encryption : "+encMsg2);
//		String decMsg2 = Decrypt.decrypt(encMsg2, pkg.get_N("pp"), pkg.get_private_key("pp"));
//		System.out.println("Proxy: Decryption	 : "+decMsg2);
		
		
		// Proxy decrypt 
		String decMsg = Decrypt.decrypt(encMsg, pkg.get_N("A"), pkg.get_private_key("A"));
		System.out.println("Proxy Decryption : "+decMsg);

		
		// Proxy re-encrypt with the data using B's public key
		String encMsg2 = Encrypt.encrypt(decMsg, pkg.get_N("B"), pkg.get_public_key("B"));
		System.out.println("Proxy Re-Encryption : " + encMsg2);

		// User B's decryption.
		String decMsg2 = Decrypt.decrypt(encMsg2, pkg.get_N("B"), pkg.get_private_key("B"));
		System.out.println("User B Decryption : "+decMsg2);

	}

}
