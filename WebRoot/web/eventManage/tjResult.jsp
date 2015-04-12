<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";
%> 

<form id="pagerForm" method="post" action='<%=path%>/tjManageAction.do?method=queryMsg&operation=changePage'>
	<input type="hidden" name="currentPage" value="${currentPage}" />
	<input type="hidden" name="pageSize" value="${pageSize}" />
</form>
<div class="pageHeader">
	<html:form onsubmit="return navTabSearch(this);" action="/tjManageAction.do?method=queryMsg&operation=search" method="post">
	<div class="searchBar">
		<table class="searchContent">
			<tr>
				<td>
					编号：<input type="text" name="serialNum"/>
				</td>
				<td>
					举报人：<input type="text" name="reportName"/>
				</td>
				<td>
					被举报人：<input type="text" name="beReportName"/>
				</td>
				<td>
					 举报时间：
					 <input type="text" class="date" readonly name="jbBeginTime"/>
                                                   至：
        			<input type="text" class="date" readonly name="jbEndTime"/>
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
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th width="40" align="center"><input type="checkbox" class="checkboxCtrl" group="ids"/></th>
				<th width="70" align="center">编号</th>
				<th width="100" align="center">状态</th>
				<th width="100" align="center">举报人姓名</th>
				<th width="100" align="center">被举报人姓名</th>
				<th align="center">举报事由</th>
				<th width="130" align="center">举报时间</th>
				<th width="120" align="center">管理</th>
			</tr>
		</thead>
		<tbody>
<logic:notEqual value="true" name="tjManageForm" property="recordNotFind">
   <logic:notEmpty name="tjManageForm" property="recordList">
     <logic:iterate name="tjManageForm" property="recordList" id="EventBean">
      <tr target="eventid" rel="${EventBean.reportID}">
      	<td align="center">
      		<input type="checkbox" name="ids" value="${EventBean.reportID}" />
      	</td>
      	<td align="center" >
			<bean:write name="EventBean" property="serialNum"/>
		</td>
      	<td align="center" >
			<bean:write name="EventBean" property="status"/>
		</td>
		<td align="center" >
			<bean:write name="EventBean" property="reportName"/>
		</td>
		<td align="center" >
			<bean:write name="EventBean" property="beReportName"/>
		</td>
		<td align="center" >
			<bean:write name="EventBean" property="reportReason"/>
		</td>
		<td  align="center">
			<bean:write name="EventBean" property="reportTime"/>
		</td>
		<td align="center" >
			<a href="#">&nbsp;</a>
			<a href="<%=path%>/eventManageAction.do?method=detail&id={eventid}" target="dialog" mask="true" rel="detail" width="900" height="600" title="查看详情">查看</a>
		</td>
	</tr>
	</logic:iterate>
	</logic:notEmpty>
	</logic:notEqual>
	<logic:equal value="true" name="tjManageForm" property="recordNotFind">
	<tr>
		<td align="center" colspan="7">
			没有查询到任何事件
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
