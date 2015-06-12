<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";  
%> 
<script type="text/javascript">
	var zTree;
	var treeNodes;
	var key;
	var selectIds = "";
	var setting = {
		view: {
			dblClickExpand: false,
			selectedMulti: false
		},
		check: {
			enable: true,
			chkboxType: { "Y": "ps", "N": "ps" }
		},
		data: {
			simpleData: {
				enable: true
			}
		},
		callback: {
			onCheck: onCheck
		}
	};
	function onCheck()
	{
		count();
		document.getElementById("moduleIds").value = selectIds;
	}
	$(function(){  
	    $.ajax({  
	        async : false,  
	        cache:false,  
	        type: 'POST',  
	        dataType : "json",  
	        url: "<%=path%>/roleManageAction.do?method=initTree",//请求的action路径  
	        error: function () {//请求失败处理函数  
	            alert('请求失败');  
	        },  
	        success:function(data){ //请求成功后处理函数。    
	            treeNodes = data;   //把后台封装好的简单Json格式赋给treeNodes
	        }
	    });
	    $.fn.zTree.init($("#resAllocationTree"), setting, treeNodes);
	    zTree = $.fn.zTree.getZTreeObj("resAllocationTree");
	    count();
	    document.getElementById("moduleIds").value = selectIds;
	});
	function count()
	{
		selectIds = "";
		var nodes = zTree.getCheckedNodes(true);
		for (var i = 0; i < nodes.length; i++) {
			selectIds += nodes[i].id + ",";
		}
	}
</script>
<div class="pageContent">
	<form id="resAllocationForm" method="post" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);" action="<%=path%>/roleManageAction.do?method=moduleSave">
		<input type="hidden" id="moduleIds" name="moduleIds" value=""/>
		<div class="pageFormContent" layoutH="57">
			<div layoutH="60" style="display:block; overflow:auto; width:98%; border:solid 1px #CCC; line-height:21px; background:#fff">
				    <ul id="resAllocationTree" class="ztree"></ul>
			</div>
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">确定</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div></li>
			</ul>
		</div>
	</form>
</div>
