<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";
%> 
<form id="pagerForm" method="post" action='<%=path%>/logManageAction.do?method=queryMsg&operation=changePage'>
	<input type="hidden" name="currentPage" value="${currentPage}" />
	<input type="hidden" name="pageSize" value="${pageSize}" />
	<input type="hidden" name="orderField" value="${param.orderField}" />
	<input type="hidden" name="orderDirection" value="${param.orderDirection}" />
</form>
<div class="pageHeader">
	<html:form onsubmit="return navTabSearch(this);" action="/logManageAction.do?method=queryMsg&operation=search" method="post">
	<div class="searchBar">
		<table class="searchContent">
			<tr>
				<td>
					操作人：<input type="text" name="operator"/>
				</td>
				<td>
					<select class="combox" name="logType">
						<option value="">所有日志类型</option>
						<option value="删除记录">删除记录</option>
						<option value="批量删除">批量删除</option>
						<option value="录入事件">录入事件</option>
						<option value="编辑记录">编辑记录</option>
						<option value="接收举报">接收举报</option>
						<option value="登陆系统">登陆系统</option>
						<option value="生成密钥">生成密钥</option>
						<option value="导入密钥">导入密钥</option>
						<option value="启用密钥">启用密钥</option>
					</select>
				</td>
				<td>
					时间从：
					 <input type="text" class="date" readonly="true" name="logBeginTime"/>
                                                   至：
        			<input type="text" class="date" readonly="true" name="logEndTime"/>
				</td>
			</tr>
		</table>
		<div class="subBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">检索</button></div></div></li>
			</ul>
		</div>
	</div>
	</html:form>
</div>
<div class="pageContent">
	<div class="panelBar">
		<ul class="toolBar">
			<li><a class="delete" rel="ids" href="<%=path %>/logManageAction.do?method=delete" postType="string" target="selectedTodo" title="确定要删除吗?"><span>批量删除</span></a></li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th width="40" align="center"><input type="checkbox" class="checkboxCtrl" group="ids"/></th>
				<th width="100" align="center" orderField="OPERATOR" class="asc">操作人</th>
				<th width="120" align="center">日志类型</th>
				<th align="center">日志内容</th>
				<th width="100" align="center">时间</th>
				<th width="150" align="center" orderField="IPADDR" <%if (request.getParameter("orderField")!=null && request.getParameter("orderField").equals("IPADDR")) { %> class="${param.orderDirection}" <%} %>>IP地址</th>
				<th width="100" align="center">管理</th>
			</tr>
		</thead>
		<tbody>
<logic:notEqual value="true" name="logManageForm" property="recordNotFind">
   <logic:notEmpty name="logManageForm" property="recordList">
     <logic:iterate name="logManageForm" property="recordList" id="LogBean">
     <tr target="logid" rel="${LogBean.id}">
      	<td align="center">
      		<input type="checkbox" name="ids" value="${LogBean.id}" />
      	</td>
		<td align="center">
			<bean:write name="LogBean" property="operator"/>
		</td>
		<td  align="center">
			<bean:write name="LogBean" property="logType"/>
		</td>
		<td align="center" >
			<bean:write name="LogBean" property="detail"/>
		</td>
		<td align="center" >
			<bean:write name="LogBean" property="time"/>
		</td>
		<td align="center" >
			<bean:write name="LogBean" property="ipAddr"/>
		</td>
		<td  align="center" >
		<a href="#">&nbsp;</a>
			<a href="<%=path%>/logManageAction.do?method=delete&id=${LogBean.id}" target="ajaxTodo" title="确定要删除吗?">删除</a>
		</td>
	</tr>
	</logic:iterate>
	</logic:notEmpty>
	</logic:notEqual>
	<logic:equal value="true" name="logManageForm" property="recordNotFind">
	<tr>
		<td align="center" colspan="7">
			没有任何日志信息
		</td>
	</tr>
	</logic:equal>
		</tbody>
	</table>
	<div class="panelBar">
	<div class="pages">
		<span>每页 20  条, 共 <%=request.getAttribute("totalRows") %> 条, 共 <%=request.getAttribute("pageCount") %> 页</span>
	</div>
	<div class="pagination" targetType="navTab" totalCount=" <%=request.getAttribute("totalRows") %>" numPerPage="20" pageNumShown="10" currentPage="<%=request.getAttribute("currentPage") %>"></div>
</div>
</div>
