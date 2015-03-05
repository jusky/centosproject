<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";  
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
	function onClick(e, treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("addMistypeTree"),
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
		var cityObj = $("#creditFactor");
		var pzzObj = $("#prid");
		pzzObj.attr("value",id);
		cityObj.attr("value", v);
	}

	function showMenu() {
	 	var tempLeft = 480;
	 	var tempTop = 252;
		var cityObj = $("#creditFactor");
		var cityOffset = $("#creditFactor").offset();
		//alert(cityOffset.left + "   " + cityOffset.top + "   " + cityObj.outerHeight());
		var leftPX = tempLeft - 338;
		var topPX = tempTop + cityObj.outerHeight() - 175;
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
	        url: "<%=path%>/mistypeManageAction.do?method=initTree&type=2",//请求的action路径  
	        error: function () {//请求失败处理函数  
	            alert('请求失败');  
	        },  
	        success:function(data){ //请求成功后处理函数。    
	            treeNodes = data;   //把后台封装好的简单Json格式赋给treeNodes
	        }
	    });
	  
	    $.fn.zTree.init($("#addMistypeTree"), setting, treeNodes);
	});
</script> 
<div class="pageContent">
	<form method="post" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);" action="<%=path%>/configMistypeAction.do?method=save&operation=new">
		<div class="pageFormContent" layoutH="57">	
			<p>
				<label>不端类型名称：</label>
				<input class="required" name="rname" type="text" size="40"/>
			</p>
			<p>
				<label>影响诚信值：</label>
				<input type="hidden" id="prid" name="prid" value=""/>
				<input id="creditFactor" class="required" readonly="true" name="prname" type="text" size="30" />
				<a id="menuBtn" class="btnLook" href="#" onclick="showMenu(); return false;">选择</a>				
			</p>
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">保存</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div></li>
			</ul>
		</div>
	</form>
</div>
<div id="menuContent" class="menuContent" style="display:none; border:solid 1px #CCC; background:#fff; position: absolute;">
	<ul id="addMistypeTree" class="ztree" style="margin-top:0; width:240px;"></ul>
</div>