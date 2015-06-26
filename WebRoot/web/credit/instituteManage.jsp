<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";  
%> 
<script type="text/javascript">
function changeExportNum() {
	var total=document.getElementById("totalCount").totalCount;
	var num=document.getElementById("exportnum").value;
	var exportattr=document.getElementById("dwzExport").href;
   if(/^\d*$/.test(num) && num > 0){
		var index = exportattr.indexOf("&exportnum=");
		exportattr = exportattr.slice(0, index).concat("&exportnum=", num);
   	document.getElementById("dwzExport").href = exportattr ;
   } else {
   	alert("请输入正整数");
   	document.getElementById("exportnum").value = total;
   }
}
</script>
<form id="pagerForm" method="post" action='<%=path%>/instituteManageAction.do?method=queryMsg&operation=changePage'>
	<input type="hidden" name="pageNum" value="${pageNum}" />
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
	<div class="panelBar">
		<ul class="toolBar">
			<li><a class="add" href="<%=path%>/web/credit/addInstitute.jsp" mask="true" target="dialog" rel="addInstitute" width="750" height="400" title="添加科研机构信息"><span>添加</span></a></li>
			<li><a class="delete" rel="ids" href="<%=path %>/instituteManageAction.do?method=delete" postType="string" target="selectedTodo" title="确定要删除吗?"><span>批量删除</span></a></li>
			<li class="line">line</li>
			<li><a class="icon" href="<%=path%>/instituteManageAction.do?method=export&exportnum=<%=request.getAttribute("totalRows")%>" id="dwzExport" target="dwzExport" targetType="navTab" title="确实要导出这些记录吗?"><span>导出EXCEL</span></a></li>
			<li><input id="exportnum" type="text" class="number" size="4" onchange="changeExportNum();" value="<%=request.getAttribute("totalRows")%>"/></li><span >条</span>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th width="40" align="center"><input type="checkbox" class="checkboxCtrl" group="ids"/></th>		
				<th width="150" align="center">单位代码</th>
				<th width="100" align="center">单位性质</th>
				<th width="200" align="center">单位名称</th>
				<th width="100" align="center">诚信值</th>
				<th width="100" align="center">历史不端人次</th>
				<th width="150" align="center">联系方式</th>	
				<th width="150" align="center">通讯地址</th>			
				<th width="100" align="center">管理</th>
			</tr>
		</thead>
		<tbody>
<logic:notEqual value="true" name="instituteManageForm" property="recordNotFind">
   <logic:notEmpty name="instituteManageForm" property="recordList">
     <logic:iterate name="instituteManageForm" property="recordList" id="InstituteInfo">
      <tr target="slt_uid" rel="${InstituteInfo.id}">
      	<td align="center">
      		<input type="checkbox" name="ids" value="${InstituteInfo.id}" />
      	</td>      
      		
      	<td align="center">
			<bean:write name="InstituteInfo" property="code"/>
		</td>
		<td align="center">
			<logic:equal value="0" name="InstituteInfo" property="category">其他</logic:equal>
			<logic:equal value="1" name="InstituteInfo" property="category">高等院校</logic:equal>
			<logic:equal value="2" name="InstituteInfo" property="category">研究机构</logic:equal>
		</td>
		<td align="center" >
			<bean:write name="InstituteInfo" property="name"/>
		</td>
		<td align="center">
			<bean:write name="InstituteInfo" property="credit"/>
		</td>
		<td align="center">
			<bean:write name="InstituteInfo" property="count" />
		</td>
		<td align="center">
			<bean:write name="InstituteInfo" property="address"/>
		</td>
		<td  align="center">
			<bean:write name="InstituteInfo" property="phone"/>
		</td>
		<td  align="center" >
		<a href="#">&nbsp;</a>
		<a href="<%=path%>/configInstituteAction.do?method=detail&code=${InstituteInfo.code}" target="dialog" rel="instituteDetail" width="700" height="600" title="查看诚信信息">查看</a>
		<a href="<%=path%>/configInstituteAction.do?method=edit&uid=${InstituteInfo.id}" target="dialog" mask="true" rel="editInstitute" width="750" height="450" title="编辑科研机构信息">编辑</a>
		<a href="<%=path%>/instituteManageAction.do?method=delete&uid=${InstituteInfo.id}" target="ajaxTodo" title="确定要删除吗?">删除</a>
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
	<div class="pagination" id=totalCount targetType="navTab" totalCount=" <%=request.getAttribute("totalRows") %>" numPerPage="20" pageNumShown="10" currentPage="<%=request.getAttribute("pageNum") %>"></div>
</div>
</div>
