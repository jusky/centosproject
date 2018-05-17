package com.whu.tools;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

public class VerifyFileType {

public final static Map<String, String> FILE_TYPE_MAP = new HashMap<String, String>();     
    
    public VerifyFileType(){}
    static{     
        getAllFileType(); //初始化文件类型信息     
    }     
         
    /**   
     * Discription:[getAllFileType,常见文件头信息] 
     */     
    private static void getAllFileType()     
    {     
        FILE_TYPE_MAP.put("ffd8ffe000104a464946", "jpg"); //JPEG (jpg)     
        FILE_TYPE_MAP.put("89504e470d0a1a0a0000", "png"); //PNG (png)     
        FILE_TYPE_MAP.put("47494638396126026f01", "gif"); //GIF (gif)     
        FILE_TYPE_MAP.put("49492a00227105008037", "tif"); //TIFF (tif)     
        FILE_TYPE_MAP.put("424d228c010000000000", "bmp"); //16色位图(bmp)     
        FILE_TYPE_MAP.put("424d8240090000000000", "bmp"); //24位位图(bmp)     
        FILE_TYPE_MAP.put("424d8e1b030000000000", "bmp"); //256色位图(bmp)     
        FILE_TYPE_MAP.put("7b5c727466315c616e73", "rtf"); //Rich Text Format (rtf)            
        FILE_TYPE_MAP.put("d0cf11e0a1b11ae10000", "doc"); //MS Excel 注意：word、msi 和 excel的文件头一样       
        FILE_TYPE_MAP.put("255044462d312e350d0a", "pdf"); //Adobe Acrobat (pdf)   
        FILE_TYPE_MAP.put("504b0304140000000800", "zip");    
        FILE_TYPE_MAP.put("526172211a0700cf9073", "rar");   
        FILE_TYPE_MAP.put("1f8b0800000000000000", "gz");//gz文件
        FILE_TYPE_MAP.put("504b0304140006000800", "docx");//docx文件
        FILE_TYPE_MAP.put("504b0304140004000800", "xlsx");
        FILE_TYPE_MAP.put("d0cf11e0a1b11ae10000", "wps");//WPS文字wps、表格et、演示dps都是一样的
    }                       
    
    /**
     * 得到上传文件的文件头
     * @param src
     * @return
     */
    public static String bytesToHexString(byte[] src) {
        StringBuilder stringBuilder = new StringBuilder();
        if (src == null || src.length <= 0) {
            return null;
        }
        for (int i = 0; i < src.length; i++) {
            int v = src[i] & 0xFF;
            String hv = Integer.toHexString(v);
            if (hv.length() < 2) {
                stringBuilder.append(0);
            }
            stringBuilder.append(hv);
        }
        return stringBuilder.toString();
    }
    
    /**
     * 根据制定文件的文件头判断其文件类型
     * @param filePaht
     * @return
     */
    public static String getFileType(String filePaht){
        String res = null;
        try {
            FileInputStream is = new FileInputStream(filePaht);
            byte[] b = new byte[10];
            is.read(b, 0, b.length);
            String fileCode = bytesToHexString(b);
            
            
            //这种方法在字典的头代码不够位数的时候可以用但是速度相对慢一点
            Iterator<String> keyIter = FILE_TYPE_MAP.keySet().iterator();
            while(keyIter.hasNext()){
                String key = keyIter.next();
                if(key.toLowerCase().startsWith(fileCode.toLowerCase()) || fileCode.toLowerCase().startsWith(key.toLowerCase())){
                    res = FILE_TYPE_MAP.get(key);
                    break;
                }
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return res;
    }
    
    public static String getFileTypeInStream(FileInputStream file){
        String res = null;
        try {
            FileInputStream is = file;
            byte[] b = new byte[10];
            is.read(b, 0, b.length);
            String fileCode = bytesToHexString(b);
            
            
            //这种方法在字典的头代码不够位数的时候可以用但是速度相对慢一点
            Iterator<String> keyIter = FILE_TYPE_MAP.keySet().iterator();
            while(keyIter.hasNext()){
                String key = keyIter.next();
                if(key.toLowerCase().startsWith(fileCode.toLowerCase()) || fileCode.toLowerCase().startsWith(key.toLowerCase())){
                    res = FILE_TYPE_MAP.get(key);
                    break;
                }
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return res;
    }

    public String check(String file){
    	String flag = "0";
      String type = getFileType(file);
      if(type != null){
    	  flag = "1";
      }
      return flag;
    }
    
    public String checkInStream(FileInputStream file){
    	String flag = "0";
      String type = getFileTypeInStream(file);
      if(type != null){
    	  flag = "1";
      }
      return flag;
    }
}
