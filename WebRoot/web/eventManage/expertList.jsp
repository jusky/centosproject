<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";  
%> 
<form id="pagerForm" method="post" action='<%=path%>/lookUpGroupAction.do?method=queryMsg&operation=changePage&type=expert'>
	<input type="hidden" name="currentPage" value="${currentPage}" />
	<input type="hidden" name="pageSize" value="${pageSize}" />
</form>

<div class="pageHeader">
	<form method="post" action="<%=path%>/lookUpGroupAction.do?method=queryMsg&operation=search&type=expert" onsubmit="return dwzSearch(this, 'dialog');">
	<div class="searchBar">
		<ul class="searchContent">
			<li>
				<label>专家姓名:</label>
				<input type="text" name="expertName"/>
			</li>
			<li>
				<label>所属学部:</label>
				<input type="text" name="expertFaculty"/>
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
				<th align="center" width="100">专家姓名</th>
				<th align="center">单位</th>
				<th align="center" width="100">所属学部</th>
				<th align="center" width="150">邮箱地址</th>
				<th align="center" width="100">联系方式</th>
				<th align="center" width="70">选择</th>
			</tr>
		</thead>
		<tbody>
		<logic:notEqual value="true" name="lookUpGroupForm" property="recordNotFind">
   				<logic:notEmpty name="lookUpGroupForm" property="recordList">
     				<logic:iterate name="lookUpGroupForm" property="recordList" id="ExpertInfo">
      					<tr>
      						<td align="center">
      							
      						</td>
      						<td align="center">
								<bean:write name="ExpertInfo" property="name"/>
							</td>
      						<td align="center">
								<bean:write name="ExpertInfo" property="dept"/>
							</td>
							<td align="center">
								<bean:write name="ExpertInfo" property="faculty"/>
							</td>
							<td align="center">
								<bean:write name="ExpertInfo" property="email"/>
							</td>
							<td align="center">
								<bean:write name="ExpertInfo" property="phone"/>
							</td>
							<td align="center">
								<a href="#">&nbsp;</a>
								<a class="btnSelect" href="javascript:$.bringBack({expertID:'${ExpertInfo.id}',expertName:'${ExpertInfo.name}', email:'${ExpertInfo.name}' + '<${ExpertInfo.email}>'})" title="查找带回">选择</a>
							</td>
						</tr>
					</logic:iterate>
				</logic:notEmpty>
			</logic:notEqual>
	<logic:equal value="true" name="lookUpGroupForm" property="recordNotFind">
	<tr>
		<td align="center" colspan="5">
			没有查询到任何专家信息！
		</td>
	</tr>
	</logic:equal>
		</tbody>
	</table>
<div class="panelBar">
	<div class="pages">
		<span>每页10  条, 共 <%=request.getAttribute("totalRows") %> 条, 共 <%=request.getAttribute("pageCount") %> 页</span>
	</div>
	<div class="pagination" targetType="dialog" totalCount=" <%=request.getAttribute("totalRows") %>" numPerPage="10" pageNumShown="10" currentPage="<%=request.getAttribute("currentPage") %>"></div>
</div>
</div>