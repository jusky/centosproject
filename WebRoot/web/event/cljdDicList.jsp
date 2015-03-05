<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";  
%> 
<form id="pagerForm" method="post" action='<%=path%>/lookUpGroupAction.do?method=queryMsg&operation=changePage&type=cljdlook'>
	<input type="hidden" name="currentPage" value="${currentPage}" />
	<input type="hidden" name="pageSize" value="${pageSize}" />
</form>

<div class="pageHeader">
	<form method="post" action="<%=path%>/lookUpGroupAction.do?method=queryMsg&operation=search&type=cljdlook" onsubmit="return dwzSearch(this, 'dialog');">
	<div class="searchBar">
		<ul class="searchContent">
			<li>
				<label>处理决定:</label>
				<input type="text" name="cljd"/>
			</li>
		</ul>
		<div class="subBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">查询</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" multLookup="cljdId" warn="请选择处理决定">选择</button></div></div></li>
			</ul>
		</div>
	</div>
	</form>
</div>
<div class="pageContent">

	<table class="table" layoutH="118" targetType="dialog" width="100%">
		<thead>
			<tr>
				<th align="center" width="40"><input type="checkbox" class="checkboxCtrl" group="cljdId"/></th>
				<th align="center" width="100">编号</th>
				<th align="center">处理决定</th>
			</tr>
		</thead>
		<tbody>
		<logic:notEqual value="true" name="lookUpGroupForm" property="recordNotFind">
   				<logic:notEmpty name="lookUpGroupForm" property="recordList">
     				<logic:iterate name="lookUpGroupForm" property="recordList" id="DicBean">
      					<tr>
      						<td align="center">
      							<input type="checkbox" name="cljdId" value="{cljdID:'${DicBean.code}', decideContent:'${DicBean.caption}'}"/>
      						</td>
      						<td align="center">
								<bean:write name="DicBean" property="code"/>
							</td>
      						<td align="center">
								<bean:write name="DicBean" property="caption"/>
							</td>
						</tr>
					</logic:iterate>
				</logic:notEmpty>
			</logic:notEqual>
	<logic:equal value="true" name="lookUpGroupForm" property="recordNotFind">
	<tr>
		<td align="center" colspan="5">
			没有查询到任何处理决定！
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