package com.whu.tools;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DBPools {

	private static DBPools dbp = new DBPools();
	
	DataSource pool = null;
    
	private DBPools() {
		try {
		    Context env = null;
			env = (Context) new InitialContext().lookup("java:comp/env");
	        pool = (DataSource) env.lookup("jdbc/Mysql");
	        if(pool==null)
	        	  ;
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public DataSource getDataSource() {
		return pool;
	}

	public static DBPools getSimpleModel() {
		return dbp;
	}
}
