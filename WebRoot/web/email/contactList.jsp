<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>

<form id="pagerForm" method="post" action='<%=request.getContextPath()%>/lookUpGroupAction.do?method=queryMsg&operation=changePage&type=contact'>
	<input type="hidden" name="pageNum" value="${pageNum}" />
	<input type="hidden" name="pageSize" value="${pageSize}" />
</form>

<div class="pageHeader">
	<form method="post" action="<%=request.getContextPath()%>/lookUpGroupAction.do?method=queryMsg&operation=search&type=contact" onsubmit="return dwzSearch(this, 'dialog');">
	<div class="searchBar">
		<ul class="searchContent">
			<li>
				<label>姓名:</label>
				<input name="contactName" value="" type="text">
			</li>
		</ul>
		<div class="subBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">查询</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" multLookup="orgId" warn="请选择联系人">选择</button></div></div></li>
			</ul>
		</div>
	</div>
	</form>
</div>
<div class="pageContent">

	<table class="table" layoutH="118" targetType="dialog" width="100%">
		<thead>
			<tr>
				<th width="30" align="center"><input type="checkbox" class="checkboxCtrl" group="orgId" /></th>
				<th orderfield="conName" align="center">姓名</th>
				<th orderfield="conAddr" align="center">邮箱地址</th>
			</tr>
		</thead>
		<tbody>
<logic:notEqual value="true" name="lookUpGroupForm" property="recordNotFind">
   <logic:notEmpty name="lookUpGroupForm" property="recordList">
     <logic:iterate name="lookUpGroupForm" property="recordList" id="ContactBean">
      <tr>
      	<td align="center">
      		<input type="checkbox" name="orgId" value="{id:'${ContactBean.id}', conName:'${ContactBean.contactName}' + '<${ContactBean.contactAddr}>', conAddr:'${ContactBean.contactAddr}'}" />
      	</td>
		<td align="center">
			<bean:write name="ContactBean" property="contactName"/>
		</td>
		<td align="center" >
			<bean:write name="ContactBean" property="contactAddr"/>
		</td>
	</tr>
	</logic:iterate>
	</logic:notEmpty>
	</logic:notEqual>
	<logic:equal value="true" name="lookUpGroupForm" property="recordNotFind">
	<tr>
		<td align="center" colspan="5">
			没有任何联系人！
		</td>
	</tr>
	</logic:equal>
		</tbody>
	</table>
<div class="panelBar">
	<div class="pages">
		<span>每页 20  条, 共 <%=request.getAttribute("totalRows") %> 条, 共 <%=request.getAttribute("pageCount") %> 页</span>
	</div>
	<div class="pagination" targetType="dialog" totalCount=" <%=request.getAttribute("totalRows") %>" numPerPage="20" pageNumShown="10" currentPage="<%=request.getAttribute("pageNum") %>"></div>
</div>
</div>