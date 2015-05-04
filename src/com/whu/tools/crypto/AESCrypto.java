package com.whu.tools.crypto;

import java.security.NoSuchAlgorithmException;
import java.util.Hashtable;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;

import com.whu.tools.DBTools;
import com.whu.tools.SystemConstant;
public class AESCrypto {

	//KeyGenerator�ṩ�Գ���Կ������Ĺ��ܣ�֧�ָ����㷨
	private KeyGenerator keygen;
	//SecretKey���𱣴�Գ���Կ
	private SecretKey deskey;
	//Cipher������ɼ��ܻ���ܹ���
	private Cipher c;
	//���ֽ����鸺�𱣴���ܺ�Ľ��
	private byte[] cipherByte;
	
	public AESCrypto()
	{
		//Security.addProvider(new com.sun.crypto.provider.SunJCE());
		try{
			//ʵ��֧��DES�㷨����Կ��������㷨��������谴�涨�������׳��쳣��
			//keygen = KeyGenerator.getInstance("AES");
			//�����Կ
			//deskey =keygen.generateKey();
			//���Cipher��ָ����֧��DES�㷨
			c = Cipher.getInstance("AES");
		}
		catch(NoSuchAlgorithmException ex)
		{
			ex.printStackTrace();
		}
		catch(NoSuchPaddingException ex){
			ex.printStackTrace();
		}
	}
	/**
	 * ���ַ�str����
	 * @param str
	 * @return
	 */
	public byte[] createEncryptor(String str, String key){
		KeyFactory kf = KeyFactory.getKey();
		Hashtable temp = kf.getKeyTable();
		if(temp.size() <= 0)
		{
			String path = GetKeyPath();
			if(!path.equals(""))
			{
				kf.inputObject(path);
			}
		}
		temp = kf.getKeyTable();
		deskey = (SecretKey)temp.get(key);
		if(deskey != null && str != null && str.trim() != "")
		{
			try {
				//�����Կ����Cipher������г�ʼ����ENCRYPT_MODE��ʾ����ģʽ
				c.init(Cipher.ENCRYPT_MODE, deskey);
				byte[] src = str.getBytes();
				//���ܣ������cipherByte
				cipherByte = c.doFinal(src);
			} catch (java.security.InvalidKeyException ex) {
				ex.printStackTrace();
			}catch(javax.crypto.BadPaddingException ex){
				ex.printStackTrace();
			}catch(javax.crypto.IllegalBlockSizeException ex){
				ex.printStackTrace();
			}
			return cipherByte;
		}
		else
		{
			return null;
		}
	}
	/**
	 * ���ֽ�����buf����
	 * @param buff
	 * @return
	 */
	public byte[] createDecryptor(byte[] buff, String key){
		if(buff == null)
		{
			return SystemConstant.NODATA;
		}
		KeyFactory kf = KeyFactory.getKey();
		Hashtable temp = kf.getKeyTable();
		if(temp.size() <= 0)
		{
			String path = GetKeyPath();
			if(!path.equals(""))
			{
				kf.inputObject(path);
			}
		}
		temp = kf.getKeyTable();
		deskey = (SecretKey)temp.get(key);
		try {
			c.init(Cipher.DECRYPT_MODE, deskey);
			if(buff != null && buff.length > 0)
			{
				cipherByte = c.doFinal(buff);
			}
		} catch (java.security.InvalidKeyException ex) {
			//ex.printStackTrace();
			return SystemConstant.UNDECRPTOR;
		}catch(javax.crypto.BadPaddingException ex){
			//ex.printStackTrace();
			return SystemConstant.UNDECRPTOR;
		}catch(javax.crypto.IllegalBlockSizeException ex){
			//ex.printStackTrace();
			return SystemConstant.UNDECRPTOR;
		}
		return cipherByte;
	}
	/**
	 * 得到系统正在使用的密钥文件
	 * @return
	 */
	public String GetKeyPath()
	{
		DBTools dbTools = new DBTools();
		return dbTools.querySingleDate("SYS_KEYINFO", "LOCALPATH", "ISUSE", "1");
	}
	public static void main(String[] args) throws Exception{
		
		AESCrypto aesCrypto = new AESCrypto();
		
		KeyFactory kf = KeyFactory.getKey();
		kf.initKey();
		
//		Hashtable temp = new Hashtable();
//		temp = kf.keyTable;
//		
//		deskey = (SecretKey)temp.get("tb1_zd1");
//		
//		String msg = "123456789123456789123456123456123";
//		System.out.println("�����ǣ�" + msg);
//		
//		byte[] enc = aesCrypto.createEncryptor(msg);
//		System.out.println("�����ǣ�" + new String(enc));
		
		String path = "/home/tmp/crypto.out";
		kf.outputObject(path);
		
//		kf.inputObject();
//		
//		temp = kf.keyTable;
//		deskey = (SecretKey)temp.get("tb1_zd1");
		
		
//		byte[] dec = aesCrypto.createDecryptor(enc);
//		System.out.println("���ܺ�Ľ���ǣ�" + new String(dec));
		
	}
}
