package com.mao.test.util;

import java.io.UnsupportedEncodingException;
import java.security.*;   

import javax.crypto.*;
import javax.crypto.spec.SecretKeySpec;   

public class Eryptogram {
	


	/**
	 * 构造子注解.
	 */
	public Eryptogram() {

	}

	/**  
	 * 加密  
	 *   
	 * @param content 需要加密的内容  
	 * @param password  加密密码  
	 * @return  
	 */
	public static byte[] encrypt(String content, String password) {
		try {
			KeyGenerator kgen = KeyGenerator.getInstance("AES");
			kgen.init(128, new SecureRandom(password.getBytes()));
			SecretKey secretKey = kgen.generateKey();
			byte[] enCodeFormat = secretKey.getEncoded();
			SecretKeySpec key = new SecretKeySpec(enCodeFormat, "AES");
			Cipher cipher = Cipher.getInstance("AES");// 创建密码器
			byte[] byteContent = content.getBytes("utf-8");
			cipher.init(Cipher.ENCRYPT_MODE, key);// 初始化
			byte[] result = cipher.doFinal(byteContent);
			return result; // 加密
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (NoSuchPaddingException e) {
			e.printStackTrace();
		} catch (InvalidKeyException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IllegalBlockSizeException e) {
			e.printStackTrace();
		} catch (BadPaddingException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**解密  
	 * @param content  待解密内容  
	 * @param password 解密密钥  
	 * @return  
	 */
	public static byte[] decrypt(byte[] content, String password) {
		try {
			KeyGenerator kgen = KeyGenerator.getInstance("AES");
			kgen.init(128, new SecureRandom(password.getBytes()));
			SecretKey secretKey = kgen.generateKey();
			byte[] enCodeFormat = secretKey.getEncoded();
			SecretKeySpec key = new SecretKeySpec(enCodeFormat, "AES");
			Cipher cipher = Cipher.getInstance("AES");// 创建密码器
			cipher.init(Cipher.DECRYPT_MODE, key);// 初始化
			byte[] result = cipher.doFinal(content);
			return result; // 加密
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (NoSuchPaddingException e) {
			e.printStackTrace();
		} catch (InvalidKeyException e) {
			e.printStackTrace();
		} catch (IllegalBlockSizeException e) {
			e.printStackTrace();
		} catch (BadPaddingException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 将二进制数据转成16进制
	 * @param buf
	 * @return
	 */
	public static String parseByte2HexStr(byte buf[]) {

		StringBuffer sb = new StringBuffer();

		for (int i = 0; i < buf.length; i++) {

			String hex = Integer.toHexString(buf[i] & 0xFF);

			if (hex.length() == 1) {

				hex = '0' + hex;

			}

			sb.append(hex.toUpperCase());

		}

		return sb.toString();

	}

	/**
	 * 16进制再转换成二进制
	 * @param hexStr
	 * @return
	 */
	public static byte[] parseHexStr2Byte(String hexStr) {

		if (hexStr.length() < 1)

			return null;

		byte[] result = new byte[hexStr.length() / 2];

		for (int i = 0; i < hexStr.length() / 2; i++) {

			int high = Integer.parseInt(hexStr.substring(i * 2, i * 2 + 1), 16);

			int low = Integer.parseInt(hexStr.substring(i * 2 + 1, i * 2 + 2),
					16);

			result[i] = (byte) (high * 16 + low);

		}

		return result;

	}



	public static String MD5(String inStr) {
		MessageDigest md5 = null;
		try {
			md5 = MessageDigest.getInstance("MD5");
		} catch (Exception e) {
			System.out.println(e.toString());
			e.printStackTrace();
			return "";
		}
		char[] charArray = inStr.toCharArray();
		byte[] byteArray = new byte[charArray.length];

		for (int i = 0; i < charArray.length; i++)
			byteArray[i] = (byte) charArray[i];

		byte[] md5Bytes = md5.digest(byteArray);

		StringBuffer hexValue = new StringBuffer();

		for (int i = 0; i < md5Bytes.length; i++) {
			int val = ((int) md5Bytes[i]) & 0xff;
			if (val < 16)
				hexValue.append("0");
			hexValue.append(Integer.toHexString(val));
		}

		return hexValue.toString();
	}
/**
 * 获取加密码
 * @param instr
 * @return
 */
	public static String getUserPasswd(String instr) {
		String userpw = MD5(instr);
		return userpw;
	}

	public static void main(String args[]) {
		String s = new String("admin");
		System.out.println("原始：" + s);
		System.out.println("MD5后：" + MD5(s));
		System.out.println("99999999999999---" + MD5(MD5(/* MD5 */(s)) + "javahih"));
		// System.out.println("MD5后再加密：" + KL(MD5(s)));
		// System.out.println("解密为MD5后的：" + JM(KL(MD5(s))));
	}

	public static String jttPasswordEry(String instr){
		return instr;
	}
	// public static void main(String[] args) {
	// String content = "root";
	//
	// String password = Consts.ADMIN_USER_PASSWD;
	// // 加密
	// System.out.println("加密前：" + content);
	// String encryptResultStr = parseByte2HexStr(encrypt(content, password));
	// System.out.println("加密后：" + encryptResultStr);
	// // 解密
	// // byte[] decryptFrom = parseHexStr2Byte(encryptResultStr);
	// byte[] decryptResult = decrypt(parseHexStr2Byte(encryptResultStr),
	// password);
	// System.out.println("解密后：" + new String(decryptResult));
	// }
}   

