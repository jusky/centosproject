package com.whu.tools;

import java.net.Inet6Address;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.util.Enumeration;
import java.util.regex.Pattern;
public class Test {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		try
		{
			/*
			Enumeration<NetworkInterface> e=NetworkInterface.getNetworkInterfaces();
	        while(e.hasMoreElements())
	        {
	        	NetworkInterface ni = e.nextElement();
	        	 if (ni.isLoopback() || ni.isVirtual() || !ni.isUp())
	                    continue;
	        	 for (Enumeration<InetAddress> ias = ni.getInetAddresses(); ias.hasMoreElements();) {
	                    InetAddress ia = ias.nextElement();
	                    if (ia instanceof Inet6Address) continue;
	                    System.out.println(ia.getHostAddress());
	                }
	        }
	        */
			/*
			String sql = "select * from TB_ESDE order by ID desc";
			String temp = sql.substring(0, sql.indexOf("order"));
			System.out.println(temp);
			*/
			System.out.println(Pattern.compile("^[a-zA-Z0-9.,\\u2000-\\u206f\\u3000-\\u303f\\ufe50-\\ufe6f\\uff00-\\uffef\\u4e00-\\u9fa5\\[\\]\\-\\/+=@_ ]*$").matcher("）").matches());
			String num = "002 where 003 where 004";
			String temp = num.substring(num.indexOf("where"), num.length());
			System.out.println(temp);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}

}
