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
	var total=document.getElementById("mistotalCount").totalCount;
	var num=document.getElementById("misexportnum").value;
	var exportattr=document.getElementById("misdwzExport").href;
   if(/^\d*$/.test(num) && num > 0){
		var index = exportattr.indexOf("&exportnum=");
		exportattr = exportattr.slice(0, index).concat("&exportnum=", num);
   	document.getElementById("misdwzExport").href = exportattr ;
   } else {
   	alert("请输入正整数");
   	document.getElementById("misexportnum").value = total;
   }
}
</script>
<form id="pagerForm" method="post" action='<%=path%>/miscountManageAction.do?method=queryMsg&operation=changePage'>
	<input type="hidden" name="currentPage" value="${currentPage}" />
	<input type="hidden" name="pageSize" value="${pageSize}" />
</form>
<logic:empty name="instDetail">
<div class="pageHeader">
	<html:form onsubmit="return navTabSearch(this);" action="/miscountManageAction.do?method=queryMsg&operation=search" method="post">
	<div class="searchBar">
		<table class="searchContent">
			<tr>
				<td>
					科研人员：<input type="text" name="individual"/>
				</td>
				<td>
					依托单位：<input type="text" name="institute"/>
				</td>
				<td>
					不端类型：<input type="text" name="mistype"/>
				</td>
				<td>
					处罚措施：<input type="text" name="punish"/>
				</td>
			</tr>
		</table>
		<div class="subBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">检索</button></div></div></li></ul>
		</div>
	</div>
	</html:form>
</div>
</logic:empty>
<div class="pageContent">
	<div class="panelBar">
		<ul class="toolBar">
			<logic:empty name="instDetail">
			<li><a class="add" href="<%=path%>/web/credit/addMiscount.jsp" mask="true" target="dialog" rel="addMiscount" width="750" height="400" title="添加不端行为记录"><span>添加</span></a></li>
			<li class="line">line</li>
			<li><a class="icon" href="<%=path%>/miscountManageAction.do?method=export&exportnum=<%=request.getAttribute("totalRows")%>" id="misdwzExport" target="dwzExport" targetType="navTab" title="确实要导出这些记录吗?"><span>导出EXCEL</span></a></li>
			<li><input id="misexportnum" type="text" class="number" size="4" onchange="changeExportNum();" value="<%=request.getAttribute("totalRows")%>"/></li><span >条</span>
			</logic:empty>	
			<logic:notEmpty name="instDetail"><li><a class="icon" href="<%=path%>/miscountManageAction.do?method=export&indi=true" id="dwzExport" target="dwzExport" targetType="navTab" title="确实要导出这些记录吗?"><span>导出EXCEL</span></a></li></logic:notEmpty>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<logic:empty name="instDetail">
				<th width="40" align="center"><input type="checkbox" class="checkboxCtrl" group="ids"/></th>	</logic:empty>	
				<th width="100" align="center">记录编号</th>
				<th width="100" align="center">标题</th>
				<th width="100" align="center">当事人</th>
				<th width="100" align="center">当事单位</th>
				<th width="150" align="center">不端类型</th>	
				<th align="center">处罚措施</th>		
				<th width="80" align="center">生效时间</th>	
				<logic:empty name="instDetail"><th width="100" align="center">管理</th></logic:empty>
			</tr>
		</thead>
		<tbody>
<logic:notEqual value="true" name="miscountManageForm" property="recordNotFind">
   <logic:notEmpty name="miscountManageForm" property="recordList">
     <logic:iterate name="miscountManageForm" property="recordList" id="MiscountInfo">
      <tr target="slt_uid" rel="${MiscountInfo.id}">
      	<logic:empty name="instDetail"><td align="center">
      		<input type="checkbox" name="ids" value="${MiscountInfo.id}" />
      	</td></logic:empty>      
      		
      	<td align="center">
			<bean:write name="MiscountInfo" property="miscountId"/>
		</td>
		<td align="center">
			<bean:write name="MiscountInfo" property="title"/>
		</td>
		<td align="center" >
			<bean:write name="MiscountInfo" property="individual"/>
		</td>
		<td>
			<bean:write name="MiscountInfo" property="institute"/>
		</td>
		<td align="center">
			<bean:write name="MiscountInfo" property="mistype"/>
		</td>
		<td  align="center">
			<bean:write name="MiscountInfo" property="punish"/>
		</td>
		<td align="center">
			<bean:write name="MiscountInfo" property="time" />
		</td>
		<logic:empty name="instDetail">
		<td  align="center" >
		<a href="#">&nbsp;</a>				
		<a href = "<%=path%>/configMiscountAction.do?method=detail&uid=${MiscountInfo.id}" target="dialog" mask="true" rel="miscountDetail" width="750" height="500" title="不端行为详细信息">查看</a>
		</logic:empty>
		</td>
	</tr>
	</logic:iterate>
	</logic:notEmpty>
	</logic:notEqual>
	<logic:equal value="true" name="miscountManageForm" property="recordNotFind">
	<tr>
		<td align="center" colspan="7">
			没有查询到任何不端行为信息
		</td>
	</tr>
	</logic:equal>
		</tbody>
	</table>
	<div class="panelBar">
	<div class="pages">
		<span>每页 20  条, 共 <%=request.getAttribute("totalRows") %> 条, 共 <%=request.getAttribute("pageCount") %> 页</span>
	</div>
	<div class="pagination" targetType="navTab" id="mistotalCount" totalCount=" <%=request.getAttribute("totalRows") %>" numPerPage="20" pageNumShown="10" currentPage="<%=request.getAttribute("currentPage") %>"></div>
</div>
</div>
