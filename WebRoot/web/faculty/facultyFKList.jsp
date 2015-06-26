<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";
%> 
<script type="text/javascript" src="<%=path %>/web/dsoframer/dsoframer.js"></script>

<form id="pagerForm" method="post" action='<%=path%>/facultyFKAction.do?method=queryMsg&operation=changePage'>
	<input type="hidden" name="pageNum" value="${pageNum}" />
	<input type="hidden" name="pageSize" value="${pageSize}" />
	<input type="hidden" name="orderField" value="${param.orderField}" />
	<input type="hidden" name="orderDirection" value="${param.orderDirection}" />
</form>
<div class="pageHeader">
	<html:form onsubmit="return navTabSearch(this);" action="/facultyFKAction.do?method=queryMsg&operation=search" method="post">
	<div class="searchBar">
		<table class="searchContent">
			<tr>
				<td>
					编号：<input type="text" name="serialNum"/>
				</td>
				<td>
					被举报人：<input type="text" name="beReportName"/>
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
			<li><a class="edit selectedTodoDw"  rel="ids" href="<%=path %>/facultyFKAction.do?method=multiDownload" postType="string" target="" title="下载选中的调查报告？"><span>批量下载</span></a></li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th width="40" align="center"><input type="checkbox" class="checkboxCtrl" group="ids"/></th>
				<th width="70" align="center"  <%if (request.getParameter("orderField")!=null && request.getParameter("orderField").equals("serialNum")) { %> class="${param.orderDirection}" <%} %>>事件编号</th>
				<!-- <th width="100" align="center">举报人</th>  -->
				<th width="200" align="center">被举报人</th>
				<th align="center">学部意见</th>
				<th width="130" align="center"  <%if (request.getParameter("orderField")!=null && request.getParameter("orderField").equals("fktime")) { %> class="${param.orderDirection}" <%} %>>更新时间</th>
				<th width="200" align="center">管理</th>
			</tr>
		</thead>
		<tbody>
<logic:notEqual value="true" name="facultyFKForm" property="recordNotFind">
   <logic:notEmpty name="facultyFKForm" property="recordList">
     <logic:iterate name="facultyFKForm" property="recordList" id="FacultyAdviceBean">
      <tr target="id" rel="${FacultyAdviceBean.id}">
      	<td align="center">
      		<input type="checkbox" name="ids" value="${FacultyAdviceBean.reportId}" />
      	</td>
      	<td align="center" >
			<bean:write name="FacultyAdviceBean" property="serialNum"/>
		</td>
      	<!--  <td align="center" >
			<bean:write name="FacultyAdviceBean" property="reportName"/>
		</td>  -->
		<td align="center" >
			<bean:write name="FacultyAdviceBean" property="beReportName"/>
		</td>
		<td align="center">
			<bean:write name="FacultyAdviceBean" property="advice"/>
		</td>
		<td align="center" >
			<bean:write name="FacultyAdviceBean" property="fktime"/>
		</td>
		<td align="center" >
			<a href="#">&nbsp;</a>
			<a target="_blank" href="${FacultyAdviceBean.filePath}">下载调查报告</a>&nbsp;&nbsp;
			<logic:equal name="FacultyAdviceBean" property="isfk" value="0">
				<a class="edit" href="<%=path%>/facultyFKAction.do?method=editFacultyAdvice&id=${FacultyAdviceBean.id}" mask="true" target="dialog" rel="editFacultyAdvice" width="800" height="480" title="录入学部意见">录入学部意见</a>
			</logic:equal>
			<logic:equal name="FacultyAdviceBean" property="isfk" value="1">
				<a class="edit" href="<%=path%>/facultyFKAction.do?method=editFacultyAdvice&id=${FacultyAdviceBean.id}" mask="true" target="dialog" rel="editFacultyAdvice" width="800" height="480" title="查看学部意见">查看学部意见</a>
			</logic:equal>
		</td>
	</tr>
	</logic:iterate>
	</logic:notEmpty>
	</logic:notEqual>
	<logic:equal value="true" name="facultyFKForm" property="recordNotFind">
	<tr>
		<td align="center" colspan="7">
			没有查询到任何待添加意见案例
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
