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
	paramers="dialogWidth:400px; dialogHeight:500px; resizable:yes; overflow:auto; status:no";
	url = "<%=path%>/web/event/reportReason.jsp";
	var value1 = window.showModalDialog(url, "", paramers);
	if(value1.ids !== "")
	{
		document.getElementById("editMiscountName").value=value1.names;
		document.getElementById("editMiscountId").value=value1.ids;
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
		var zTree = $.fn.zTree.getZTreeObj("editMiscountTree"),
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
		$("#editPunishId").attr("value",id);
		$("#editPunishName").attr("value", v);
		hideMenu();
	}

	function showMenu() {
	 	var tempLeft = 480;
	 	var tempTop = 252;
		var cityObj = $("#editPunishName");
		var cityOffset = $("#editPunishName").offset();
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
	  
	    $.fn.zTree.init($("#editMiscountTree"), setting, treeNodes);
	});
</script> 
<div class="pageContent">
	<form method="post" action="<%=path%>/configMiscountAction.do?method=save&operation=edit" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<logic:notEmpty name="configMiscountForm" property="recordList">
     	<logic:iterate name="configMiscountForm" property="recordList" id="MiscountInfo">
		<div class="pageFormContent" layoutH="56">
			<input type="hidden" name="id" value="${MiscountInfo.id}">
			<dl class="nowrap">
				<dt>标题：</dt>
				<dd><input required minlength="2" maxlength="50" name="code" type="text" size="55" value="${MiscountInfo.title}"/></dd>
			</dl>			
			<dl class="nowrap">
				<dt>当事人：</dt>
				<dd><input required name="individual" type="text" size="50" value="${MiscountInfo.individual}"/></dd>
			</dl>					
			<dl class="nowrap">
				<dt>当事单位：</dt>
				<dd>
					<input name="institute" type="text" size="25" value="${MiscountInfo.institute}"/>
				</dd>
			</dl>				
			<dl class="nowrap">
				<dt>不端类型：</dt>
				<dd><input id="editMiscountId" name="mistype" type="hidden" />
				<textarea id="editMiscountName" class="required" readonly cols="30" rows="3" /></textarea>
				<a class="btnLook" href="javascript:showreason()">选择不端类型</a></dd>
			</dl>					
			<dl class="nowrap">
				<dt>处罚措施：</dt>
				<dd>
				<input id="editPunishId" name="punish" type="hidden" />
				<textarea id="editPunishName" class="required" readonly cols="30" rows="2" /></textarea>
				<a id="menuBtn" class="btnLook" href="#" onclick="showMenu(); return false;">选择</a></dd>
			</dl>				
			<dl class="nowrap">
				<dt>生效时间：</dt>
				<dd><input class="required date" readonly name="time" type="text" size="20" value="${MiscountInfo.time }"/></dd>
			</dl>		
			<dl class="nowrap">
				<dt>举报编号：</dt>
				<dd><input class="required" name="reportId" type="text" size="20" value="${MiscountInfo.reportId }"/></dd>
			</dl>			
			<dl class="nowrap">
				<dt>详细内容的文件地址：</dt>
				<dd><input class="required" name="detail" type="text" size="50" value="${MiscountInfo.detail }"/></dd>
			</dl>				
		</div>
		</logic:iterate>
		</logic:notEmpty>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">保存</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">返回</button></div></div></li>
			</ul>
		</div>
	</form>
</div>
<div id="menuContent" class="menuContent" style="display:none; border:solid 1px #CCC; background:#fff; position: absolute;">
	<ul id="editMiscountTree" class="ztree" style="margin-top:0; width:360px;"></ul>
</div>