package com.whu.tools;

import java.io.Serializable;
import java.util.ArrayList;

/**
 * 分页功能类
 * 
 * */
public class CheckPage implements Serializable{

	public int queryPageNo;       // 请求的页号 
	public int rowsPerPage ;    // 每页的行数 
	public String querySql ;   // 查询的Sql语句
	public int totalPage;      // 总页数 
	public int totalRows;      // 总行数 
	public int lastPageRows;   // 最后一页的行数 
	public String[] params;   // sql parameters
	
	public CheckPage(){
		try {
			jbInit();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private void jbInit() throws Exception
	{
		
	}
	
	public int getQueryPageNo() {
		return queryPageNo;
	}
	public void setQueryPageNo(int queryPageNo) {
		this.queryPageNo = queryPageNo;
	}
	public int getRowsPerPage() {
		return rowsPerPage;
	}
	public void setRowsPerPage(int rowsPerPage) {
		this.rowsPerPage = rowsPerPage;
	}
	public String getQuerySql() {
		return querySql;
	}
	public void setQuerySql(String querySql) {
		this.querySql = querySql;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getTotalRows() {
		return totalRows;
	}
	public void setTotalRows(int totalRows) {
		this.totalRows = totalRows;
	}
	public int getLastPageRows() {
		return lastPageRows;
	}
	public void setLastPageRows(int lastPageRows) {
		this.lastPageRows = lastPageRows;
	}
	public String[] getParams() {
		return params;
	}
	public void setParams( String[] params) {
		this.params = params;
	}
	
}
