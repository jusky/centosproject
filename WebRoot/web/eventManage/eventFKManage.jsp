<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";  
%> 

<form id="pagerForm" method="post" action='<%=path%>/eventFKAction.do?method=queryMsg&operation=changePage'>
	<input type="hidden" name="currentPage" value="${currentPage}" />
	<input type="hidden" name="pageSize" value="${pageSize}" />
</form>
<div class="pageHeader">
	<html:form onsubmit="return navTabSearch(this);" action="/eventFKAction.do?method=queryMsg&operation=search" method="post">
	<div class="searchBar">
		<table class="searchContent">
			<tr>
				<td>
					反馈人：<input type="text" name="fkName"/>
				</td>
				<td>
					 反馈时间：
					 <input type="text" class="date" readonly name="fkBeginTime"/>
                                                   至：
        			<input type="text" class="date" readonly name="fkEndTime"/>
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
			<li><a class="delete" rel="ids" href="<%=path %>/eventFKAction.do?method=delete" postType="string" target="selectedTodo" title="确定要删除吗?"><span>批量删除</span></a></li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th width="40" align="center"><input type="checkbox" class="checkboxCtrl" group="ids"/></th>
				<th width="50" align="center">编号</th>
				<th width="150" align="center">反馈人</th>
				<th  align="center">反馈信息</th>
				<th width="100" align="center">反馈时间</th>
				<th width="100" align="center">管理</th>
			</tr>
		</thead>
		<tbody>
<logic:notEqual value="true" name="eventFKForm" property="recordNotFind">
   <logic:notEmpty name="eventFKForm" property="recordList">
     <logic:iterate name="eventFKForm" property="recordList" id="ReplyInfo">
      <tr target="rid" rel="${ReplyInfo.id}">
      	<td align="center">
      		<input type="checkbox" name="ids" value="${ReplyInfo.id}" />
      	</td>
		<td align="center">
			<bean:write name="ReplyInfo" property="serialNum"/>
		</td>
		<td align="center" >
			<bean:write name="ReplyInfo" property="fkName"/>
		</td>
		<td align="center" >
			<bean:write name="ReplyInfo" property="type"/>
		</td>
		<td align="center">
			<bean:write name="ReplyInfo" property="time"/>
		</td>
		<td  align="center" >
			<a href="<%=path%>/eventManageAction.do?method=detail&id=${ReplyInfo.reportID }" target="dialog" mask="true" rel="detail" width="900" height="600" title="查看案件详情">查看案件</a>
			<a href = "<%=path%>/eventFKAction.do?method=delete&uid={rid}"  target="ajaxTodo" title="确定要删除吗?">删除</a>
		</td>
	</tr>
	</logic:iterate>
	</logic:notEmpty>
	</logic:notEqual>
	<logic:equal value="true" name="eventFKForm" property="recordNotFind">
	<tr>
		<td align="center" colspan="7">
			没有查询到反馈消息
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
