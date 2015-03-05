<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>

<form id="pagerForm" method="post" action='<%=request.getContextPath()%>/msgListAction.do?method=queryMsg&operation=changePage'>
	<input type="hidden" name="currentPage" value="${currentPage}" />
	<input type="hidden" name="pageSize" value="${pageSize}" />
</form>
<div class="pageHeader">
	<html:form onsubmit="return navTabSearch(this);" action="/sendMsgListAction.do?method=queryMsg&operation=search" method="post">
	<div class="searchBar">
		<table class="searchContent">
			<tr>
				<td>
					标题：<input type="text" name="title" property="title"/>
				</td>
				<td>
					发送时间：
					 <input type="text" class="date" readonly="true" name="sendBeginTime"/>
                                                   至：
        			<input type="text" class="date" readonly="true" name="sendEndTime"/>
				</td>
			</tr>
		</table>
		<div class="subBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">检索</button></div></div></li>
				<li><a class="button" href="demo_page6.html" target="dialog" mask="true" title="查询框"><span>高级检索</span></a></li>
			</ul>
		</div>
	</div>
	</html:form>
</div>
<div class="pageContent">
	<div class="panelBar">
		<ul class="toolBar">
			<li><a class="add" href="demo_page4.html" target="navTab"><span>发送消息</span></a></li>
			<li><a class="delete" href="demo/common/ajaxDone.html?uid={sid_user}" target="ajaxTodo" title="确定要删除吗?"><span>删除</span></a></li>
			<li><a class="edit" href="demo_page4.html?uid={sid_user}" target="navTab"><span>修改</span></a></li>
			<li class="line">line</li>
			<li><a class="icon" href="demo/common/dwz-team.xls" target="dwzExport" targetType="navTab" title="实要导出这些记录吗?"><span>导出EXCEL</span></a></li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th width="40"></th>
				<th width="300" align="center">标题</th>
				<th width="120" align="center">消息类型</th>
				<th width="150" align="center">发送时间</th>
				<th width="150" align="center">需要回复</th>
				<th width="150" align="center">收信人</th>
				<th width="150" align="center">管理</th>
			</tr>
		</thead>
		<tbody>
<logic:notEqual value="true" name="sendMsgListForm" property="recordNotFind">
   <logic:notEmpty name="sendMsgListForm" property="recordList">
     <logic:iterate name="sendMsgListForm" property="recordList" id="SendMsgBean">
      <tr>
      	<td align="center">
      		&nbsp;
      	</td>
		<td align="center" >
			<bean:write name="SendMsgBean" property="title"/>
		</td>
		<td  align="center">
			<bean:write name="SendMsgBean" property="msgType"/>
		</td>
		<td align="center" >
			<bean:write name="SendMsgBean" property="sendTime"/>
		</td>
				<td align="center">
			<bean:write name="SendMsgBean" property="needBack"/>
		</td>
		<td align="center" >
			<bean:write name="SendMsgBean" property="recvName"/>
		</td>
		<td  align="center" >
		<a href = "<%=request.getContextPath()%>/msgListAction.do?method=detail&&id=" target="mainFrame">删除</a>
		<a href = "<%=request.getContextPath()%>/msgListAction.do?method=detail&&id=" target="mainFrame">明细</a>
		</td>
	</tr>
	</logic:iterate>
	</logic:notEmpty>
	</logic:notEqual>
	<logic:equal value="true" name="sendMsgListForm" property="recordNotFind">
	<tr>
		<td align="center" colspan="7">
			没有任何信息
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
