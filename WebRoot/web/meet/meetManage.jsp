<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";
%> 
<script src="<%=path%>/js/moreops.js" type="text/javascript"></script>
<script type="text/javascript">
function showMeetDiv(aID)
 {
 	  var opsID = "more" + aID;
 	  var opsObject = document.getElementById(opsID);
 	  var r = getAbsolutePos(opsObject);
 	  var newDiv = document.getElementById("meet_box"); 
	  //让新层的zIndex属性要足够大，才会在最上面显示  	  
	  //newDiv.style.zIndex = "9999";  
	  newDiv.style.top= r.y - 80 + "px";  
	 // newDiv.style.left= r.x - 400 + "px";
	  newDiv.style.display="block";
 }
	 document.getElementById("meet_box").onclick = function(e){
	     e = e || window.event;
	     if(window.event){    //阻止事件冒泡
	         e.cancelBubble = true;
	     } else {
	         e.stopPropagation();
	     }
	 }
</script>
<form id="pagerForm" method="post" action='<%=path%>/meetManageAction.do?method=queryMsg&operation=changePage'>
	<input type="hidden" name="currentPage" value="${currentPage}" />
	<input type="hidden" name="pageSize" value="${pageSize}" />
</form>
<div id="meet_box" class="ops_box ops_itemDiv">
	<ul style="width:212px;">
		<li class="ops_li">
			<a class="link detail ops_more" href="<%=path%>/meetManageAction.do?method=detail&id={meetid}" target="dialog" mask="true" rel="detail" width="800" height="400" title="查看详情">查看详情</a>
		</li>
		<li class="ops_li">
			<a class="link edit ops_more" href="<%=path%>/meetManageAction.do?method=edit&id={meetid}" target="dialog" mask="true" rel="detail" width="800" height="400" title="编辑会议信息">编辑</a>
		</li>
		<li class="ops_li">
			<a class="link delete ops_more" href="<%=path%>/meetManageAction.do?method=delete&id={meetid}" target="ajaxTodo" title="确定要删除吗?">删除</a>
		</li>
	</ul>
</div>
<div class="pageHeader">
	<html:form onsubmit="return navTabSearch(this);" action="/meetManageAction.do?method=queryMsg&operation=search" method="post">
	<div class="searchBar">
		<table class="searchContent">
			<tr>
				<td>
					会议名称：<input type="text" name="meetName"/>
				</td>
				<td>
					会议时间：
					 <input type="text" class="date" readonly name="jbBeginTime"/>
                                                   至：
        			<input type="text" class="date" readonly name="jbEndTime"/>
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
			<li><a class="add" href="<%=path %>/web/meet/addMeet.jsp" mask="true" target="dialog" rel="addMeet" width="800" height="400" title="添加会议"><span>添加</span></a></li>
			<li class="line">line</li>
			<li><a class="delete" rel="ids" href="<%=path %>/meetManageAction.do?method=delete" postType="string" target="selectedTodo" title="确定要删除吗?"><span>批量删除</span></a></li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th width="40" align="center"><input type="checkbox" class="checkboxCtrl" group="ids"/></th>
				<th width="150" align="center">会议名称</th>
				<th width="100" align="center">会议时间</th>
				<th width="250" align="center">会议地点</th>
				<th align="center">参会人员</th>
				<th width="100" align="center">管理</th>
			</tr>
		</thead>
		<tbody>
<logic:notEqual value="true" name="meetManageForm" property="recordNotFind">
   <logic:notEmpty name="meetManageForm" property="recordList">
     <logic:iterate name="meetManageForm" property="recordList" id="MeetInfo">
      <tr target="meetid" rel="${MeetInfo.id}">
      	<td align="center">
      		<input type="checkbox" name="ids" value="${MeetInfo.id}" />
      	</td>
		<td align="center" >
			<bean:write name="MeetInfo" property="meetName"/>
		</td>
		<td align="center" >
			<bean:write name="MeetInfo" property="time"/>
		</td>
		<td align="center" >
			<bean:write name="MeetInfo" property="location"/>
		</td>
		<td  align="center">
			<bean:write name="MeetInfo" property="members"/>
		</td>
		<td align="center" >
			<!-- 
			<a href="#">&nbsp;</a>
			
			<a href="<%=path%>/meetManageAction.do?method=edit&id={meetid}" class="btnInfo" target="dialog" mask="true" rel="detail" width="900" height="600" title="编辑会议信息">编辑</a>
			<a href="<%=path%>/meetManageAction.do?method=delete&id={meetid}" class="btnDel" target="ajaxTodo" title="确定要删除吗?">删除</a>
			 -->
			 <a href="#">&nbsp;</a>
			 <a id="more${MeetInfo.id}" style="cursor: pointer;text-decoration: underline;" href="javascript:showMeetDiv('${MeetInfo.id}');" title="更多操作">更多操作</a>
		</td>
	</tr>
	</logic:iterate>
	</logic:notEmpty>
	</logic:notEqual>
	<logic:equal value="true" name="meetManageForm" property="recordNotFind">
	<tr>
		<td align="center" colspan="7">
			没有查询到任何会议信息
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