<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";  
%> 
<script>
var selectInst = function(code, name) {
	var ret;
	ret.code = code;
	ret.name = name;
	window.returnValue = ret;
}
</script>
<form id="pagerForm" method="post" action='<%=path%>/instituteManageAction.do?method=queryMsg&operation=changePage'>
	<input type="hidden" name="currentPage" value="${currentPage}" />
	<input type="hidden" name="pageSize" value="${pageSize}"/>
</form>
<div class="pageHeader">
	<html:form onsubmit="return navTabSearch(this)" action="/instituteManageAction.do?method=queryMsg&operation=search" method="post">
	<div class="searchBar">
		<table class="searchContent">
			<tr>
				<td>
					单位性质：
					<select name="category">
							<option value="">请选择</option>
							<option value="1" <logic:equal value="1" name="category">selected</logic:equal> >高等院校</option>
							<option value="2" <logic:equal value="2" name="category">selected</logic:equal> >研究机构</option>
							<option value="0" <logic:equal value="0" name="category">selected</logic:equal> >其他</option>
					</select>
				</td>
				<td>
					单位代码：<input type="text" name="code"/>
				</td>
				<td>
					单位名称：<input type="text" name="name"/>
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
				<th width="150" align="center">单位代码</th>
				<th width="200" align="center">单位名称</th>		
				<th width="100" align="center">选择</th>
			</tr>
		</thead>
		<tbody>
<logic:notEqual value="true" name="instituteManageForm" property="recordNotFind">
   <logic:notEmpty name="instituteManageForm" property="recordList">
     <logic:iterate name="instituteManageForm" property="recordList" id="InstituteInfo">
      <tr target="slt_uid" rel="${InstituteInfo.id}">
      	<td align="center">
			<bean:write name="InstituteInfo" property="code"/>
		</td>
		<td align="center" >
			<bean:write name="InstituteInfo" property="name"/>
		</td>
		<td  align="center" >
		<a href="#">&nbsp;</a>
		<a href="#" onclick="selectInst();">选择</a>
		</td>
	</tr>
	</logic:iterate>
	</logic:notEmpty>
	</logic:notEqual>
	<logic:equal value="true" name="instituteManageForm" property="recordNotFind">
	<tr>
		<td align="center" colspan="7">
			没有查询到任何科研机构信息
		</td>
	</tr>
	</logic:equal>
		</tbody>
	</table>
	<div class="panelBar">
	<div class="pages">
		<span>每页 20  条, 共 <%=request.getAttribute("totalRows") %> 条, 共 <%=request.getAttribute("pageCount") %> 页</span>
	</div>
	<div class="pagination" id=totalCount targetType="navTab" totalCount=" <%=request.getAttribute("totalRows") %>" numPerPage="20" pageNumShown="10" currentPage="<%=request.getAttribute("currentPage") %>"></div>
</div>
</div>
