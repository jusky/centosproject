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
function showMailDiv(aID)
 {
 	  var opsID = "more" + aID;
 	  var opsObject = document.getElementById(opsID);
 	  var r = getAbsolutePos(opsObject);
 	  var newDiv = document.getElementById("mail_box"); 
	  //让新层的zIndex属性要足够大，才会在最上面显示  	  
	  //newDiv.style.zIndex = "9999";  
	  newDiv.style.top= r.y - 80 + "px";  
	 // newDiv.style.left= r.x - 400 + "px";
	  newDiv.style.display="block";
 }
	 document.getElementById("mail_box").onclick = function(e){
	     e = e || window.event;
	     if(window.event){    //阻止事件冒泡
	         e.cancelBubble = true;
	     } else {
	         e.stopPropagation();
	     }
	 }
</script>
<form id="pagerForm" method="post" action='<%=path%>/mailManageAction.do?method=queryMsg&operation=changePage'>
	<input type="hidden" name="pageNum" value="${pageNum}" />
	<input type="hidden" name="pageSize" value="${pageSize}" />
</form>
<div id="mail_box" class="ops_box ops_itemDiv">
	<ul style="width:300px;">
		<li class="ops_li">
			<a href="<%=path%>/mailManageAction.do?method=detail&id={mail_uid}" class="link detail ops_more" target="dialog" mask="true" rel="detail" width="900" height="600" title="查看详情">查看详情</a>
		</li>
		<li class="ops_li">
			<a class="link edit ops_more" href = "<%=path%>/mailConfigAction.do?method=edit&id={mail_uid}" mask="true" target="dialog" rel="editMail" width="645" height="370">编辑</a>
		</li>
		<li class="ops_li">
			<a class="link edit ops_more" href = "<%=path%>/mailManageAction.do?method=test&id={mail_uid}" target="ajaxTodo" onclick="alertMsg.info('正在测试连接，请耐心等待...')" width="513" height="150">测试邮箱</a>
		</li>
		<li class="ops_li">
			<a class="link delete ops_more" href="<%=path%>/mailManageAction.do?method=delete&id={mail_uid}" target="ajaxTodo" title="确定要删除吗?">删除</a>
		</li>
	</ul>
</div>
<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="<%=path%>/mailManageAction.do?method=queryMsg&operation=search" method="post">
	<div class="searchBar">
		<table class="searchContent">
			<tr>
				<td>
					账号名称：<input type="text" name="accountName"/>
				</td>
				<td>
					邮箱地址：<input type="text" name="mailAddress"/>
				</td>
			</tr>
		</table>
		<div class="subBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">检索</button></div></div></li>
			</ul>
		</div>
	</div>
	</form>
</div>
<div class="pageContent">
	<div class="panelBar">
		<ul class="toolBar">
			<li><a class="add" href="<%=path%>/web/email/addMail.jsp" mask="true" target="dialog" rel="addMail" width="645" height="370"><span>添加</span></a></li>
			<li><a class="delete" rel="ids" href="<%=path%>/mailManageAction.do?method=delete" postType="string" target="selectedTodo" title="确定要删除这些邮箱配置吗?"><span>批量删除</span></a></li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th width="40" align="center"><input type="checkbox" class="checkboxCtrl" group="ids"/></th>
				<th width="300" align="center">账号名称</th>
				<th width="300" align="center">邮箱地址</th>
				<th width="120" align="center">是否默认</th>
				<th width="150" align="center">管理</th>
			</tr>
		</thead>
		<tbody>
<logic:notEqual value="true" name="mailManageForm" property="recordNotFind">
   <logic:notEmpty name="mailManageForm" property="recordList">
     <logic:iterate name="mailManageForm" property="recordList" id="EmailBean">
      <tr target="mail_uid" rel="${EmailBean.ID}">
      	<td align="center">
      		<input type="checkbox" name="ids" value="${EmailBean.ID}" />
      	</td>
		<td align="center">
			<bean:write name="EmailBean" property="accountName"/>
		</td>
		<td align="center" >
			<bean:write name="EmailBean" property="mailBoxAddress"/>
		</td>
		<td  align="center">
			<logic:equal value="1" name="EmailBean" property="isDefault">是</logic:equal>
			<logic:equal value="0" name="EmailBean" property="isDefault">否</logic:equal>
		</td>
		<td  align="center" >
			<logic:equal value="0" name="EmailBean" property="isDefault">
				<a href = "<%=path%>/mailManageAction.do?method=setDefault&id=${EmailBean.ID}" target="ajaxTodo" title="确定要将该邮箱设置为默认吗?">设置默认</a>
			</logic:equal>
			<a id="more${EmailBean.ID}" style="cursor: pointer;text-decoration: underline;" href="javascript:showMailDiv('${EmailBean.ID}');" title="更多操作">更多操作</a>
			
		</td>
	</tr>
	</logic:iterate>
	</logic:notEmpty>
	</logic:notEqual>
	<logic:equal value="true" name="mailManageForm" property="recordNotFind">
	<tr>
		<td align="center" colspan="5">
			没有查询到任何邮箱配置信息
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
