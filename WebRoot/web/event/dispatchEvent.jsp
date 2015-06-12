<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";  
%> 
<html>
<head>
<title>举报事由</title>
<link href="<%=path%>/ztree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=path %>/js/jquery.min.js"></script>
<script src="<%=path%>/ztree/js/jquery.ztree.core-3.5.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=path %>/ztree/js/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript">
	var zTree;
	var treeNodes;
	var key;
	var selectIds = "";
	var selectNames = "";
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
		
	}
	$(function(){  
	    $.ajax({  
	        async : false,  
	        cache:false,  
	        type: 'POST',  
	        dataType : "json",  
	        url: '<%=path%>/servlet/JBReasonServlet?type=<%=request.getParameter("type")%>',//请求的action路径  
	        error: function () {//请求失败处理函数  
	            alert('请求失败');  
	        },  
	        success:function(data){ //请求成功后处理函数。    
	            treeNodes = data;   //把后台封装好的简单Json格式赋给treeNodes
	        }
	    });
	    $.fn.zTree.init($("#dispatchEventTree"), setting, treeNodes);
	    zTree = $.fn.zTree.getZTreeObj("dispatchEventTree");
	});
	function selectOK()
	{
		var nodes = zTree.getCheckedNodes(true);
		for (var i = 0; i < nodes.length; i++) {
			if(nodes[i].parentTId != null)
			{
				selectIds += nodes[i].id + ",";
				selectNames += nodes[i].name + ",";
			}
		}
		if(selectNames != "")
		{
			selectNames = selectNames.substring(0, selectNames.length-1);
			selectIds = selectIds.substring(0, selectIds.length-1);
		}
		var ret = {};
		ret.ids = selectIds;
		ret.names = selectNames;
		window.returnValue = ret; //父窗口就是上一个页面
       	window.close();
	}
	function cancelOK()
	{
		window.returnValue=""; //父窗口就是上一个页面
       	window.close();
	}
</script>
</head>
<body>
<div>
	<form id="form1" method="post" action="">
		<div>
			<div style="display:block; overflow:auto; width:98%; border:solid 1px #CCC; line-height:21px; background:#fff">
				<ul id="dispatchEventTree" class="ztree"></ul>
				<br/>
				<input type="button" onclick="selectOK();" value="确定"/>
				<input type="button" onclick="cancelOK();" value="取消"/>
			</div>
		</div>
	</form>
</div>
</body>
</html>
