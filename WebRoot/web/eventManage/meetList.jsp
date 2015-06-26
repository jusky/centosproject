<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<form id="pagerForm" method="post" action='<%=request.getContextPath()%>/lookUpGroupAction.do?method=queryMsg&operation=changePage&type=hymc'>
	<input type="hidden" name="pageNum" value="${pageNum}" />
	<input type="hidden" name="pageSize" value="${pageSize}" />
</form>

<div class="pageHeader">
	<form method="post" action="<%=request.getContextPath()%>/lookUpGroupAction.do?method=queryMsg&operation=search&type=hymc" onsubmit="return dwzSearch(this, 'dialog');">
	<div class="searchBar">
		<ul class="searchContent">
			<li>
				<label>会议名称:</label>
				<input type="text" name="meetName" value=""/>
			</li>
		</ul>
		<div class="subBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">查询</button></div></div></li>
			</ul>
		</div>
	</div>
	</form>
</div>
<div class="pageContent">

	<table class="table" layoutH="118" targetType="dialog" width="100%">
		<thead>
			<tr>
				<th align="center" width="30"></th>
				<th align="center" width="50">编号</th>
				<th align="center">会议名称</th>
				<th align="center" width="150">时间</th>
				<th align="center" width="200">地点</th>
				<th align="center" width="100">选择</th>
			</tr>
		</thead>
		<tbody>
		<logic:notEqual value="true" name="lookUpGroupForm" property="recordNotFind">
   				<logic:notEmpty name="lookUpGroupForm" property="recordList">
     				<logic:iterate name="lookUpGroupForm" property="recordList" id="MeetInfo">
      					<tr>
      						<td>
      						
      						</td>
      						<td align="center">
								<bean:write name="MeetInfo" property="serialNum"/>
							</td>
							<td align="center">
								<bean:write name="MeetInfo" property="meetName"/>
							</td>
							<td align="center">
								<bean:write name="MeetInfo" property="time"/>
							</td>
      						<td align="center">
								<bean:write name="MeetInfo" property="location"/>
							</td>
							<td align="center">
								<a href="#">&nbsp;</a>
								<a class="btnSelect" href="javascript:$.bringBack({conference:'${MeetInfo.meetName }'})" title="查找带回">选择</a>
							</td>
						</tr>
					</logic:iterate>
				</logic:notEmpty>
			</logic:notEqual>
			<logic:equal value="true" name="lookUpGroupForm" property="recordNotFind">
			<tr>
				<td align="center" colspan="5">
					没有查询到任何会议
				</td>
			</tr>
			</logic:equal>
		</tbody>
	</table>
<div class="panelBar">
	<div class="pages">
		<span>每页10  条, 共 <%=request.getAttribute("totalRows") %> 条, 共 <%=request.getAttribute("pageCount") %> 页</span>
	</div>
	<div class="pagination" targetType="dialog" totalCount=" <%=request.getAttribute("totalRows") %>" numPerPage="10" pageNumShown="10" currentPage="<%=request.getAttribute("pageNum") %>"></div>
</div>
</div>