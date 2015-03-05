<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript" src="<%=path %>/ztree/js/jquery.ztree.excheck-3.5.js"></script>
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
		//alert("beforeClick");
		return (treeNode.click != false);
	}
	function onClick(event, treeId, treeNode, clickFlag) {
		var treeObj = $.fn.zTree.getZTreeObj("mistypeTree");
		var nodes = treeObj.getSelectedNodes();
		var id = nodes[0].id;
		if(id != "" && id != null)
		{
			$('#misBox').loadUrl('<%=path%>/mistypeManageAction.do?method=queryMsg&operation=search&id=' + id);
		}
	}
	
	$(function(){  
	    $.ajax({  
	        async : false,  
	        cache:false,  
	        type: 'POST',  
	        dataType : "json",  
	        url: "<%=path%>/mistypeManageAction.do?method=initTree&type=1",//请求的action路径  
	        error: function () {//请求失败处理函数  
	            alert('请求失败');  
	        },  
	        success:function(data){ //请求成功后处理函数。    
	            treeNodes = data;   //把后台封装好的简单Json格式赋给treeNodes
	        }
	    });
	  
	    $.fn.zTree.init($("#mistypeTree"), setting, treeNodes);
	    zTree = $.fn.zTree.getZTreeObj("mistypeTree");
	});
	
	var reloadCredit = function () {
		$.post("<%=path%>/mistypeManageAction.do?method=init");
	}
</script>
<div class="pageContent" style="padding:2px">
<div class="tabs">
		<div class="tabsHeader">
			<div class="tabsHeaderContent">
				<ul>
					<li><a href="javascript:reloadCredit();"><span>诚信影响因素管理</span></a></li>
				</ul>
			</div>
		</div>
		<div class="tabsContent">
			<div>
				<div layoutH="50" style="float:left; display:block; overflow:scroll; width:220px; border:solid 1px #CCC; line-height:21px; background:#fff">
				    <ul id="mistypeTree" class="ztree"></ul>
				</div>
				
				<div id="misBox" class="unitBox" style="margin-left:226px;">
					<form id="pagerForm" onsubmit="return divSearch(this, 'misBox');" method="post" action='<%=path%>/mistypeManageAction.do?method=queryMsg&operation=changePage'>
						<input type="hidden" name="currentPage" value="${currentPage}" />
						<input type="hidden" name="pageSize" value="${pageSize}" />
					</form>
					<div class="pageHeader" style="border:1px #B8D0D6 solid">
						<html:form onsubmit="return divSearch(this, 'misBox');" action="/mistypeManageAction.do?method=queryMsg&operation=search" method="post">
						<div class="searchBar">
							<table class="searchContent">
							<tr>
								<td class="dateRange">
									名称:
									<input type="text" value="" name="name">
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
								<logic:notEmpty name="RID"><li><a class="edit" href="<%=path%>/configMistypeAction.do?method=weight&type=<%=request.getAttribute("RID")%>"  mask="true" target="dialog" rel="weightManage" width="600" height="360" title="权值分配"><span>权值分配</span></a></li></logic:notEmpty>
								<li><a class="add" href="<%=path%>/web/credit/addMistype.jsp" target="dialog" mask="true" rel="addMistype" width="600" height="200" title="添加不端类型"><span>添加</span></a></li>
								<li><a class="delete" rel="ids" href="<%=path %>/mistypeManageAction.do?method=delete" postType="string" target="selectedTodo" title="确定要删除吗?"><span>批量删除</span></a></li>
							</ul>
						</div>
						<table class="table" width="99%" layoutH="170" rel="misBox">
							<thead>
								<tr>
									<th width="40" align="center"><input type="checkbox" class="checkboxCtrl" group="ids"/></th>
									<th width="100" align="center">编号</th>
									<th align="200" align="center">名称</th>
									<th width="50" align="center">权重</th>
									<th width="150" align="center">影响诚信值</th>
									<th width="80" align="center">管理</th>
								</tr>
							</thead>
							<tbody>
							<logic:notEqual value="true" name="mistypeManageForm" property="recordNotFind">
					   		<logic:notEmpty name="mistypeManageForm" property="recordList">
					     	<logic:iterate name="mistypeManageForm" property="recordList" id="MistypeBean">
					      	<tr target="zzid" rel="${MistypeBean.id}">
					      	<td align="center">
					      		<input type="checkbox" name="ids" value="${MistypeBean.id}" />
					      	</td>
					      	<td align="center" >
								<bean:write name="MistypeBean" property="rid"/>
							</td>
							<td align="center" >
								<bean:write name="MistypeBean" property="rname"/>
							</td>
							<td align="center" >
								<bean:write name="MistypeBean" property="weight"/>
							</td>
							<td  align="center">
								<bean:write name="MistypeBean" property="pname"/>
							</td>
							<td align="center" >
								<a href="#">&nbsp;</a>
								<a href="<%=path%>/configMistypeAction.do?method=edit&id=${MistypeBean.id}" class="btnInfo" target="dialog" mask="true" rel="editZZ" width="600" height="200" title="编辑不端类型信息">编辑</a>
								<a href="<%=path%>/mistypeManageAction.do?method=delete&id=${MistypeBean.id}" class="btnDel" target="ajaxTodo" title="确定要删除吗?">删除</a>
							</td>
						</tr>
						</logic:iterate>
						</logic:notEmpty>
						</logic:notEqual>
						<logic:equal value="true" name="mistypeManageForm" property="recordNotFind">
						<tr>
							<td align="center" colspan="7">
								没有查询到任何不端类型信息
							</td>
						</tr>
						</logic:equal>
							</tbody>
						</table>
						<div class="panelBar">
						<div class="pages">
							<span>每页 20  条, 共 <%=request.getAttribute("totalRows") %> 条, 共 <%=request.getAttribute("pageCount") %> 页</span>
						</div>
						<div class="pagination" rel="misBox" totalCount=" <%=request.getAttribute("totalRows") %>" numPerPage="20" pageNumShown="10" currentPage="<%=request.getAttribute("currentPage") %>"></div>
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

