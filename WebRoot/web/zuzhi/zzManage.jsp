<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript" src="<%=path %>/ztree/js/jquery.ztree.exedit-3.5.js"></script>
<script type="text/javascript">
	var zTree, rMenu;
	var treeNodes;
	var key;
	var setting = {
		view: {
			dblClickExpand: false
		},
		check: {
			enable: false
		},
		data: {
			simpleData: {
				enable: true
			}
		},
		callback: {
			onClick: onClick
		}
	};
	
	function beforeClick(treeId, treeNode, clickFlag) {
		return (treeNode.click != false);
	}
	function onClick(event, treeId, treeNode, clickFlag) {
		var treeObj = $.fn.zTree.getZTreeObj("zzManageTree");
		var nodes = treeObj.getSelectedNodes();
		var id = nodes[0].id;
		if(id != "" && id != null)
		{
			$('#zzBox').loadUrl('<%=path%>/zzManageAction.do?method=queryMsg&operation=search&id=' + id);
		}
	}
	
	$(function(){  
	    $.ajax({  
	        async : false,  
	        cache:false,  
	        type: 'POST',  
	        dataType : "json",  
	        url: "<%=path%>/zzManageAction.do?method=initTree&type=1",//请求的action路径  
	        error: function () {//请求失败处理函数  
	            alert('请求失败');  
	        },  
	        success:function(data){ //请求成功后处理函数。    
	            treeNodes = data;   //把后台封装好的简单Json格式赋给treeNodes
	        }
	    });
	  
	    $.fn.zTree.init($("#zzManageTree"), setting, treeNodes);
	    zTree = $.fn.zTree.getZTreeObj("zzManageTree");
	});
</script>
<div class="pageContent" style="padding:5px">
<div class="tabs">
		<div class="tabsHeader">
			<div class="tabsHeaderContent">
				<ul>
					<li><a href="javascript:;"><span>组织机构管理</span></a></li>
				</ul>
			</div>
		</div>
		<div class="tabsContent">
			<div>
				<div layoutH="50" style="float:left; display:block; overflow:auto; width:240px; border:solid 1px #CCC; line-height:21px; background:#fff">
				    <ul id="zzManageTree" class="ztree"></ul>
				</div>
				
				<div id="zzBox" class="unitBox" style="margin-left:246px;">
					<form id="pagerForm" onsubmit="return divSearch(this, 'zzBox');" method="post" action='<%=path%>/zzManageAction.do?method=queryMsg&operation=changePage'>
						<input type="hidden" name="currentPage" value="${currentPage}" />
						<input type="hidden" name="pageSize" value="${pageSize}" />
					</form>
					<div class="pageHeader" style="border:1px #B8D0D6 solid">
						<html:form onsubmit="return divSearch(this, 'zzBox');" action="/zzManageAction.do?method=queryMsg&operation=search" method="post">
						<div class="searchBar">
							<table class="searchContent">
							<tr>
								<td class="dateRange">
									组织名称:
									<input type="text" value="" name="zzName">
								</td>
								<td><div class="buttonActive"><div class="buttonContent"><button type="submit">检索</button></div></div></td>
							</tr>
							</table>
						</div>
						</html:form>
					</div>
					<div class="pageContent" style="border-left:1px #B8D0D6 solid;border-right:1px #B8D0D6 solid">
						<div class="panelBar">
							<ul class="toolBar">
								<li><a class="add" href="<%=path%>/web/zuzhi/addZZ.jsp" target="dialog" mask="true" rel="addZZ" width="600" height="300" title="添加组织"><span>添加</span></a></li>
								<li><a class="delete" rel="ids" href="<%=path %>/zzManageAction.do?method=delete" postType="string" target="selectedTodo" title="确定要删除吗?"><span>批量删除</span></a></li>
							</ul>
						</div>
						<table class="table" width="99%" layoutH="170" rel="zzBox">
							<thead>
								<tr>
									<th width="40" align="center"><input type="checkbox" class="checkboxCtrl" group="ids"/></th>
									<th width="100" align="center">组织编号</th>
									<th width="150" align="center">组织名称</th>
									<th align="center">组织简介</th>
									<th width="130" align="center">上级组织</th>
									<th width="100" align="center">管理</th>
								</tr>
							</thead>
							<tbody>
							<logic:notEqual value="true" name="zzManageForm" property="recordNotFind">
					   		<logic:notEmpty name="zzManageForm" property="recordList">
					     	<logic:iterate name="zzManageForm" property="recordList" id="ZZBean">
					      	<tr target="zzid" rel="${ZZBean.id}">
					      	<td align="center">
					      		<input type="checkbox" name="ids" value="${ZZBean.id}" />
					      	</td>
					      	<td align="center" >
								<bean:write name="ZZBean" property="zzID"/>
							</td>
							<td align="center" >
								<bean:write name="ZZBean" property="zzName"/>
							</td>
							<td align="center" >
								<bean:write name="ZZBean" property="zzDescribe"/>
							</td>
							<!-- 
							<td align="center" >
								<logic:equal value="1" name="ZZBean" property="isJC">有</logic:equal>
								<logic:equal value="0" name="ZZBean" property="isJC">无</logic:equal>
							</td>
							 -->
							<td  align="center">
								<bean:write name="ZZBean" property="pzzName"/>
							</td>
							<td align="center" >
								<a href="#">&nbsp;</a>
								<a href="<%=path%>/zzManageAction.do?method=detail&id=${ZZBean.id}" class="btnLook" target="dialog" mask="true" rel="detail" width="600" height="300" title="查看详情">查看</a>
								<a href="<%=path%>/zzConfigAction.do?method=edit&id=${ZZBean.id}" class="btnInfo" target="dialog" mask="true" rel="editZZ" width="600" height="300" title="编辑组织信息">编辑</a>
								<a href="<%=path%>/zzManageAction.do?method=delete&id=${ZZBean.id}" class="btnDel" target="ajaxTodo" title="确定要删除吗?">删除</a>
							</td>
						</tr>
						</logic:iterate>
						</logic:notEmpty>
						</logic:notEqual>
						<logic:equal value="true" name="zzManageForm" property="recordNotFind">
						<tr>
							<td align="center" colspan="7">
								没有查询到任何组织信息
							</td>
						</tr>
						</logic:equal>
							</tbody>
						</table>
						<div class="panelBar">
						<div class="pages">
							<span>每页 20  条, 共 <%=request.getAttribute("totalRows") %> 条, 共 <%=request.getAttribute("pageCount") %> 页</span>
						</div>
						<div class="pagination" rel="zzBox" totalCount=" <%=request.getAttribute("totalRows") %>" numPerPage="20" pageNumShown="10" currentPage="<%=request.getAttribute("currentPage") %>"></div>
						</div>
					</div>
				</div>
			</div>
			</div>
			<div class="tabsFooter">
			<div class="tabsFooterContent"></div>
			</div>
	</div>
</div>

