<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
	var zTree, rMenu;
	var treeNodes;
	var key;
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
		zTree = $.fn.zTree.getZTreeObj("checkEventTree");
		var selectIds = "";
		var nodes = zTree.getCheckedNodes(true);
		for (var i = 0; i < nodes.length; i++) {
			selectIds += nodes[i].name + ",";
		}
		if(selectIds.length > 0)
		{
		 	selectIds = selectIds.substring(0, selectIds.length - 1); 
		}
		document.getElementById("facultyID").value = selectIds;
	}
	function onClick(e, treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("checkEventTree"),
		nodes = zTree.getSelectedNodes(),
		v = "";
		id = "";
		nodes.sort(function compare(a,b){return a.id-b.id;});
		for (var i=0, l=nodes.length; i<l; i++) {
			v += nodes[i].name + ",";
			id += nodes[i].id + ",";
		}
		if (v.length > 0 ) v = v.substring(0, v.length-1);
		if (id.length > 0 ) id = id.substring(0, id.length-1);
		var cityObj = $("#facultyID");
		cityObj.attr("value", v);
	}

	function showMenu() {
	//在1280*800分辨率下默认的坐标
	//如果在不同的浏览器分辨率情况下，坐标位置会有变化
	//在计算leftPX和topPX时，后面减去的数值需要根据实际的坐标有所改变
	//此处，默认减去数值分别为213和50
		var tempLeft=359;
		var tempTop = 268;
		var cityObj = $("#facultyID");
		var cityOffset = $("#facultyID").offset();
		//alert(cityOffset.left + "   " + cityOffset.top + "   " + cityObj.outerHeight());
		//计算实际坐标与默认坐标的差
		var leftPX = cityOffset.left - (cityOffset.left - tempLeft + 213);
		var topPX = cityOffset.top + cityObj.outerHeight() - (cityOffset.top - tempTop + 50);
		$("#menuContent").css({left:leftPX + "px", top:topPX + "px"}).slideDown("fast");

		$("body").bind("mousedown", onBodyDown);
	}
	function hideMenu() {
		$("#menuContent").fadeOut("fast");
		$("body").unbind("mousedown", onBodyDown);
	}
	function onBodyDown(event) {
		if (!(event.target.id == "menuBtn" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
			hideMenu();
		}
	}
	$(function(){  
	    $.ajax({  
	        async : false,  
	        cache:false,  
	        type: 'POST',  
	        dataType : "json",  
	        url: "<%=path%>/zzManageAction.do?method=initTree&type=3",//请求的action路径  
	        error: function () {//请求失败处理函数  
	            alert('请求失败');  
	        },  
	        success:function(data){ //请求成功后处理函数。    
	            treeNodes = data;   //把后台封装好的简单Json格式赋给treeNodes
	        }
	    });
	  
	    $.fn.zTree.init($("#checkEventTree"), setting, treeNodes);
	});
</script> 
<div class="pageContent">
	<form method="post" action="<%=path%>/checkEventAction.do?method=report" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
	<input type="hidden" name="reportID" value="<%=request.getAttribute("ReportID") %>"/>
		<div class="pageFormContent" layoutH="56">
			<fieldset>
					<legend>举报内容</legend>
					<dl class="nowrap">
						<dt>事件简述：</dt>
						<dd><textarea rows="7" cols="80" readonly><%=request.getAttribute("ReportInfo") %></textarea></dd>
					</dl>
			</fieldset>
			<fieldset>
					<legend>初步核实</legend>
					<dl class="nowrap">
						<dt>所属学部：</dt>
						<dd>
							<input id="facultyID" class="required" readonly name="faculty" type="text" size="30" />
							<a id="menuBtn" class="btnLook" href="#" onclick="showMenu(); return false;">选择</a>
							<span class="info">选择</span>
						</dd>
					</dl>
					<dl class="nowrap">
						<dt>初步处理意见：</dt>
						<dd>
							<textarea name="preAdvice" cols="80" rows="9" class="required"></textarea>
						</dd>
					</dl>
					<dl class="nowrap">
						<dt>报送领导：</dt>
						<dd>
							<input type="hidden" name="org3.loginName"/>
							<textarea name="org3.userName" cols="50" rows="2" class="required readonly"></textarea>
							<a class="btnLook" href="<%=path%>/lookUpGroupAction.do?method=init&type=bsld" lookupGroup="org3">选择默认</a>
							<span class="info">选择</span>
						</dd>
					</dl>
					<dl class="nowrap">
						<dt>核实人：</dt>
						<dd>
							<input name="checkName" class="required" type="text" size="20" value="<%=(String)request.getSession().getAttribute("UserName") %>"/>
						</dd>
					</dl>
			</fieldset>
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">保存</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">返回</button></div></div></li>
			</ul>
		</div>
	</form>
</div>
<div id="menuContent" class="menuContent" style="display:none; border:solid 1px #CCC; background:#fff; position: absolute;">
	<ul id="checkEventTree" class="ztree" style="margin-top:0; width:240px;"></ul>
</div>