package com.whu.tools;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.RandomAccessFile;
import java.io.StringWriter;

import com.whu.web.common.SystemShare;

/**
 * 异常日志操作类
 * @author Administrator
 *
 */
public class DebugLog {

	public static BufferedReader bufread;
//	private static String path = "C:\\test.txt";
	private static String path = "/home/tmp/test.txt";
	//private static File filename = new File(path);
	private static File filename;
	private static String readStr   = "";
	/**
	 * 写日志文件
	 * @param msg
	 * @return
	 */
	public static boolean WriteDebug(Exception ex)
	{
		File logFile = new File(SystemConstant.debugLogPath);
		try
		{
			if(!logFile.exists())
			{
				logFile.createNewFile();
			}
		}
		catch (IOException e) {
			e.printStackTrace();
		}
	   StackTraceElement [] messages=ex.getStackTrace();
	   int length=messages.length;
	   String temp = ex.toString() + "\r\n";
	   for(int i=0;i<length;i++){
			   temp += "ClassName:"+messages[i].getClassName() + "\r\n";
				temp += "getFileName:"+messages[i].getFileName() + "\r\n";
				temp += "getLineNumber:"+messages[i].getLineNumber() + "\r\n";
				temp += "getMethodName:"+messages[i].getMethodName() + "\r\n";
				temp += "toString:"+messages[i].toString() + "\r\n";
		}
		String time = SystemShare.GetNowTime("yyyy-MM-dd");
		String filein = "*******************        " + time + "          *********************\r\n" + temp + "\r\n\r\n";
		RandomAccessFile mm = null;
		try
		{
			mm = new RandomAccessFile(logFile, "rw");
			// 文件长度，字节数
			long fileLength = mm.length();
			//将写文件指针移到文件尾。
			mm.seek(fileLength);
			mm.write(filein.getBytes());
		}
		catch(IOException e)
		{
			e.printStackTrace();
			return false;
		}
		finally
		{
			if(mm != null)
			{
				try
				{
					mm.close();
				}
				catch (IOException e2) {
					e2.printStackTrace();
					return false;
				}
			}
		}
		return true;
	}
	/**
	 * 创建文本文件
	 * @throws IOException
	 */
	public static void CreateLogFile()
	{
		try
		{
			if(!filename.exists())
			{
				filename.createNewFile();
			}
		}
		catch (IOException e) {
			e.printStackTrace();
		}
	}
	/**
	 * 读取文件
	 * @return
	 */
	public static String ReadTxtFile()
	{
		String read;
		FileReader fileread;
		try
		{
			fileread = new FileReader(filename);
			bufread = new BufferedReader(fileread);
			try{
				while((read = bufread.readLine()) != null)
				{
					readStr = readStr + read + "\r\n";
				}
			}catch(IOException e){
				e.printStackTrace();
			}
		}
		catch(FileNotFoundException e)
		{
			e.printStackTrace();
		}
		return readStr;
	}
	public static void main(String[] args) {
//		DebugLog.CreateLogFile();
//		DebugLog.ReadTxtFile();
		//DebugLog.WriteDebug("bbbbbbbbbbb");
		try
		{
			int i = 5/0;
		}
		catch (Exception e) {
			DebugLog.WriteDebug(e);
		}
	}
}
