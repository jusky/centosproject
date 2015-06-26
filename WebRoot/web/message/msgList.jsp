<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<form id="pagerForm" method="post" action='<%=request.getContextPath()%>/msgListAction.do?method=queryMsg&operation=changePage'>
	<input type="hidden" name="pageNum" value="${pageNum}" />
	<input type="hidden" name="pageSize" value="${pageSize}" />
</form>
<div class="pageHeader">
	<html:form onsubmit="return navTabSearch(this);" action="/msgListAction.do?method=queryMsg&operation=search" method="post">
	<div class="searchBar">
		<table class="searchContent">
			<tr>
				<td>
					标题：<input type="text" name="title" property="title"/>
				</td>
				<td>
					<select class="combox" name="msgType" property="msgType">
						<option value="allType">所有类型</option>
						<option value="sysMsg">系统消息</option>
					</select>
				</td>
				<td>
					 接收时间：
					 <input type="text" class="date" readonly name="revBeginTime"/>
                                                   至：
        			<input type="text" class="date" readonly name="revEndTime"/>
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
			<li><a class="add" href="demo_page4.html" target="navTab"><span>添加</span></a></li>
			<li><a class="delete" href="demo/common/ajaxDone.html?uid={sid_user}" target="ajaxTodo" title="确定要删除吗?"><span>删除</span></a></li>
			<li><a class="edit" href="demo_page4.html?uid={sid_user}" target="navTab"><span>修改</span></a></li>
			<li class="line">line</li>
			<li><a class="icon" href="<%=request.getContextPath()%>/msgListAction.do?method=export" target="dwzExport" targetType="navTab" title="确实要导出这些记录吗?"><span>导出EXCEL</span></a></li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th width="40"></th>
				<th width="100" align="center">发信人</th>
				<th width="300" align="center">标题</th>
				<th width="120" align="center">消息类型</th>
				<th width="150" align="center">发送时间</th>
				<th width="150" align="center">收信时间</th>
				<th width="150" align="center">管理</th>
			</tr>
		</thead>
		<tbody>
<logic:notEqual value="true" name="queryMsgForm" property="recordNotFind">
   <logic:notEmpty name="queryMsgForm" property="recordList">
     <logic:iterate name="queryMsgForm" property="recordList" id="MsgBean">
      <tr>
      	<td align="center">
      		&nbsp;
      	</td>
		<td align="center">
			<bean:write name="MsgBean" property="sendName"/>
		</td>
		<td align="center" >
			<bean:write name="MsgBean" property="title"/>
		</td>
		<td  align="center">
			<bean:write name="MsgBean" property="msgType"/>
		</td>
		<td align="center" >
			<bean:write name="MsgBean" property="sendTime"/>
		</td>
		<td align="center" >
			<bean:write name="MsgBean" property="recvTime"/>
		</td>
		<td  align="center" >
		<a href = "<%=request.getContextPath()%>/msgListAction.do?method=detail&&id=" target="mainFrame">查看</a>
		<a href = "<%=request.getContextPath()%>/msgListAction.do?method=detail&&id=" target="mainFrame">删除</a>
		</td>
	</tr>
	</logic:iterate>
	</logic:notEmpty>
	</logic:notEqual>
	<logic:equal value="true" name="queryMsgForm" property="recordNotFind">
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
	<div class="pagination" targetType="navTab" totalCount=" <%=request.getAttribute("totalRows") %>" numPerPage="20" pageNumShown="10" currentPage="<%=request.getAttribute("pageNum") %>"></div>
</div>
</div>
