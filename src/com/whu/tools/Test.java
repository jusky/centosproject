package com.whu.tools;

import java.net.Inet6Address;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.util.Enumeration;

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
