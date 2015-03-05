<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
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
		var zTree = $.fn.zTree.getZTreeObj("treeDemo3"),
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
		var cityObj = $("#zzName");
		var pzzObj = $("#zzID");
		pzzObj.attr("value",id);
		cityObj.attr("value", v);
	}

	function showMenu() {
		var cityObj = $("#zzName");
		var cityOffset = $("#zzName").offset();
		var leftPX = cityOffset.left - 338;
		var topPX = cityOffset.top + cityObj.outerHeight() - 170;
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
	        url: "<%=path%>/zzManageAction.do?method=initTree&type=2",//请求的action路径  
	        error: function () {//请求失败处理函数  
	            alert('请求失败');  
	        },  
	        success:function(data){ //请求成功后处理函数。    
	            treeNodes = data;   //把后台封装好的简单Json格式赋给treeNodes
	        }
	    });
	  
	    $.fn.zTree.init($("#treeDemo3"), setting, treeNodes);
	});
</script>  
<div class="pageContent">
	<form method="post" action="<%=path %>/userManageAction.do?method=gjSearch" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="58">
			<div class="unit">
				<label>用户账号：</label>
				<input type="text" size="15" name="loginName"/>
				<span class="inputInfo">关键字或全称</span>
			</div>
			<div class="divider">divider</div>
			<div class="unit">
				<label>用户姓名：</label>
				<input type="text" size="25" name="userName"/>
				<span class="inputInfo">关键字或全称</span>
			</div>
			<div class="unit">
				<label>所属组织：</label>
				<input type="hidden" id="zzID" name="zzID" value=""/>
				<input id="zzName" readonly="true" name="zzName" type="text" size="30" />
				<a id="menuBtn" class="btnLook" href="#" onclick="showMenu(); return false;">选择</a>
				<span class="info">选择</span>
			</div>
			<div class="unit">
				<label>担任职务：</label>
					<input name="org8.posID" value="" type="hidden">
					<input id="pos" name="org8.posName" type="text" size="40" readonly="true" value=""/>
					<a class="btnLook" href="<%=path%>/lookUpGroupAction.do?method=init&type=pos" lookupGroup="org8">选择角色</a>
					<span class="info">选择</span>
			</div>
			<div class="unit">
				<label>系统角色：</label>
				<input id="roleID" name="org7.roleID" type="hidden"/>
				<input id="role" name="org7.roleName" type="text" size="40" readonly="true" value=""/>
				<a class="btnLook" href="<%=path%>/lookUpGroupAction.do?method=init&type=role" lookupGroup="org7">选择角色</a>
				<span class="info">选择</span>
			</div>
			<div class="divider">divider</div>
			<div class="unit">
				<label>排序条件：</label>
				<select name="orderWay">
					<option value="">默认排序</option>
					<option value="a.ID">按编号排序</option>
					<option value="a.LOGINNAME">按账号排序</option>
					<option value="a.USERNAME">按姓名排序</option>
					<option value="a.ZZID">按组织排序</option>
				</select>
			</div>
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">开始检索</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="reset">清空重输</button></div></div></li>
			</ul>
		</div>
	</form>
</div>
<div id="menuContent" class="menuContent" style="display:none; border:solid 1px #CCC; background:#fff; position: absolute;">
	<ul id="treeDemo3" class="ztree" style="margin-top:0; width:240px;"></ul>
</div>
