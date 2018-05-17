package com.whu.tools.crypto;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.ArrayList;
import java.util.Hashtable;

import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;

import org.apache.tomcat.jni.OS;

import com.whu.tools.SystemConstant;

public class KeyFactory {

	private static KeyFactory kfFactory = new KeyFactory();
	//KeyGenerator�ṩ�Գ���Կ������Ĺ��ܣ�֧�ָ����㷨
	private KeyGenerator keygen;
	//SecretKey���𱣴�Գ���Կ
	private SecretKey aeskey;
	
	private ArrayList keyList = new ArrayList();
	
	private Hashtable keyTable = new Hashtable();
	private KeyFactory()
	{
		
	}
	public static KeyFactory getKey()
	{
		return kfFactory;
	}
	public Hashtable getKeyTable()
	{
		return keyTable;
	}
	public boolean initKey()
	{
		try {
			//一张数据库表使用一个密钥，每一个表的密钥都不相同
			keygen = KeyGenerator.getInstance("AES");
			String[] temp = SystemConstant.TBARRAY;
			for(int i = 0; i < temp.length; i++)
			{
					aeskey = keygen.generateKey();
					keyTable.put(temp[i], aeskey);
			}
		} catch (Exception e) {
			return false;
		}
		return true;
	}
	
	/**
	 * ����Կ�ļ����л�Ϊ�������ļ������浽Ӳ����
	 */
	public void saveToFile()
	{
		
	}
	
	public boolean outputObject(String path) {
		FileOutputStream os;
        try {
        	KeyGenerator keygen1 = KeyGenerator.getInstance("AES");
        	SecretKey aeskey1;
        	Hashtable keyTable1 = new Hashtable();
			String[] temp = SystemConstant.TBARRAY;
			for(int i = 0; i < temp.length; i++)
			{
					aeskey1 = keygen1.generateKey();
					keyTable1.put(temp[i], aeskey1);
			}
            //os = new FileOutputStream("d:"+File.separator+"crypto.out");
        	os = new FileOutputStream(path);
            ObjectOutputStream o = new ObjectOutputStream(os);
            o.writeObject(keyTable1);
            o.flush();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }finally{
        }
        return true;
    }
	
	public void inputObject(String path){
        try {
            FileInputStream input = new FileInputStream(path);
            ObjectInputStream objInput = new ObjectInputStream(input);
            Object list =  (Object) objInput.readObject();
            Hashtable ht = (Hashtable)list;
            keyTable = ht;
        } catch (Exception e) {
            e.printStackTrace();
        }        
    }
}
