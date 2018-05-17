 <%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";
%> 

<form id="pagerForm" method="post" action='<%=path%>/unLoginedExpertAction.do?method=queryMsg&operation=changePage'>
	<input type="hidden" name="pageNum" value="${pageNum}" />
	<input type="hidden" name="pageSize" value="${pageSize}" />
</form>
<div class="pageHeader">
	<html:form onsubmit="return navTabSearch(this);" action="/unLoginedExpertAction.do?method=queryMsg&operation=search" method="post">
	<div class="searchBar">
		<table class="searchContent">
			<tr>
				<td>
					专家姓名：<input type="text" name="expertName" />
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
	
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th width="60" align="center"><input type="checkbox" class="checkboxCtrl" group="ids"/></th>
				<th width="80" align="center">编号</th>
				<th width="80" align="center">专家姓名</th>
				<th width="80" align="center">专家账号</th>
				<th width="200" align="center">账号生成时间</th>
				<th width="200" align="center">专家邮箱</th>
				<th width="80" align="center">举报人姓名</th>
				<th align="center">被举报人姓名</th>
				<th width="80" align="center">管理</th>
			</tr>
		</thead>
		<tbody>
<logic:notEqual value="true" name="unLoginedExpertForm" property="recordNotFind">
   <logic:notEmpty name="unLoginedExpertForm" property="recordList">
     <logic:iterate name="unLoginedExpertForm" property="recordList" id="UnLoginedExpertBean">
      <tr target="reportid" rel="${UnLoginedExpertBean.id}">
      	<td align="center">
      		<input type="checkbox" name="ids" value="${UnLoginedExpertBean.id}"/>
      	</td>
      	<td align="center" >
			<bean:write name="UnLoginedExpertBean" property="serialNum"/>
		</td>
		<td align="center" >
			<bean:write name="UnLoginedExpertBean" property="expertName"/>
		</td>
		<td align="center" >
			<bean:write name="UnLoginedExpertBean" property="loginName"/>
		</td>
		<td align="center" >
			<bean:write name="UnLoginedExpertBean" property="sendEmailTime"/>
		</td>
		<td align="center" >
			<bean:write name="UnLoginedExpertBean" property="emailAddress"/>
		</td>
		<td align="center" >
			<bean:write name="UnLoginedExpertBean" property="repoerName"/>
		</td>
		<td align="center" >
			<bean:write name="UnLoginedExpertBean" property="beReportName"/>
		</td>
		<td align="center" >
			<a href="<%=path%>/eventManageAction.do?method=detail&id={reportid}" target="dialog" mask="true" rel="detail" width="900" height="600" title="查看详情">查看</a>
			<a href="<%=path%>/unLoginedExpertAction.do?method=delete&loginname=${UnLoginedExpertBean.loginName}" target="ajaxTodo" title="确定要删除吗?">删除</a>
		</td>
	</tr>
	</logic:iterate>
	</logic:notEmpty>
	</logic:notEqual>
	<logic:equal value="true" name="unLoginedExpertForm" property="recordNotFind">
	<tr>
		<td align="center" colspan="7">
			没有查询到任何联系人
		</td>
	</tr>
	</logic:equal>
		</tbody>
	</table>
	<div class="panelBar">
	<div class="pages">
		<span>每页 20  条, 共 <%=request.getAttribute("totalRows") %> 条, 共 <%=request.getAttribute("pageCount") %> 页</span>
	</div>
	<div class="pagination" targetType="navTab" totalCount=" <%=request.getAttribute("totalRows") %>" numPerPage="20" pageNumShown="10" currentPage="<%=request.getAttribute("pageNum") %>"></div>
</div>
</div>
