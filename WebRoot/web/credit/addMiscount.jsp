<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";  
%> 
<script type="text/javascript">
var showreason = function(){
	paramers="dialogWidth:520px; dialogHeight:500px; resizable:yes; overflow:auto; status:no";
	url = "<%=path%>/web/event/reportReason.jsp?type=indi"; // type = indi, not show reason about institute
	var value1 = window.showModalDialog(url, "", paramers);
	if(value1.ids !== "")
	{
		document.getElementById("addMiscountName").value=value1.names;
		document.getElementById("addMiscountId").value=value1.ids;
	}
}
</script> 
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
		var zTree = $.fn.zTree.getZTreeObj("addMiscountTree"),
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
		$("#addPunishId").attr("value",id);
		$("#addPunishName").attr("value", v);
		hideMenu();
	}

	function showMenu() {
	 	var tempLeft = 480;
	 	var tempTop = 252;
		var cityObj = $("#addPunishName");
		var cityOffset = $("#addPunishName").offset();
		//alert(cityOffset.left + "   " + cityOffset.top + "   " + cityObj.outerHeight());
		var leftPX = tempLeft - 300;
		var topPX = tempTop + cityObj.outerHeight() - 45;
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
	        url: "<%=path%>/miscountManageAction.do?method=initTree&",//请求的action路径  
	        error: function () {//请求失败处理函数  
	            alert('请求失败');  
	        },  
	        success:function(data){ //请求成功后处理函数。    
	            treeNodes = data;   //把后台封装好的简单Json格式赋给treeNodes
	        }
	    });
	  
	    $.fn.zTree.init($("#addMiscountTree"), setting, treeNodes);
	});
</script> 
<div class="pageContent">
	<form method="post" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);" action="<%=path%>/configMiscountAction.do?method=save&operation=new">
		<div class="pageFormContent" layoutH="57">
			<dl class="nowrap">
				<dt>标题：</dt>
				<dd><input name="title" type="text" size="50" class="required"/></dd>
			</dl>			
			<dl class="nowrap">
				<dt>当事人身份证：</dt>
				<dd><input class="required number" name="individual" type="text" maxlength="16" minlength="16" size="24" /></dd>
			</dl>					
			<dl class="nowrap">
				<dt>当事单位代码：</dt>
				<dd>
					<input name="institute" type="text" size="24" maxlength="16" />
				</dd>
			</dl>				
			<dl class="nowrap">
				<dt>不端类型：</dt>
				<dd><input id="addMiscountId" name="mistype" type="hidden" />
				<textarea id="addMiscountName" class="required" readonly cols="30" rows="3" ></textarea>
				<a class="btnLook" href="javascript:showreason()">选择不端类型</a></dd>
			</dl>					
			<dl class="nowrap">
				<dt>处罚措施：</dt>
				<dd>
				<input id="addPunishId" name="punish" type="hidden" />
				<textarea id="addPunishName" class="required" readonly cols="30" rows="2"></textarea>
				<a id="menuBtn" class="btnLook" href="#" onclick="showMenu(); return false;">选择</a></dd>
			</dl>					
			<dl class="nowrap">
				<dt>生效时间：</dt>
				<dd><input class="required date" readonly name="time" type="text" size="20"/><a class="inputDateButton" href="#">选择</a></dd>
			</dl>		
			<dl class="nowrap">
				<dt>举报编号：</dt>
				<dd><input class="required" name="reportId" type="text" size="20" /></dd>
			</dl>			
			<dl class="nowrap">
				<dt>详细内容的文件地址：</dt>
				<dd><input class="required" name="detail" type="text" size="50" /></dd>
			</dl>				
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
	<ul id="addMiscountTree" class="ztree" style="margin-top:0; width:360px;"></ul>
</div>

