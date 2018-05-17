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
		var zTree = $.fn.zTree.getZTreeObj("gjSearchTree"),
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
		var cityObj = $("#citySel");
		cityObj.attr("value", v);
	}

	function showMenu() {
		var tempLeft=430;
		var tempTop = 246;
		var cityObj = $("#citySel");
		var cityOffset = $("#citySel").offset();
		var leftPX = cityOffset.left - (cityOffset.left - tempLeft + 288);
		var topPX = cityOffset.top + cityObj.outerHeight() - (cityOffset.top - tempTop + 60);
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
	  
	    $.fn.zTree.init($("#gjSearchTree"), setting, treeNodes);
	});
</script> 
<div class="pageContent">
	<form method="post" action="<%=path %>/eventManageAction.do?method=gjSearch" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		<div class="pageFormContent" layoutH="58">
			<div class="unit">
				<label>事件编号：</label>
				<input type="text" size="15" name="serialNum"/>
				<span class="inputInfo">全称</span>
			</div>
			<div class="divider">divider</div>
			<div class="unit">
				<label>举报人姓名：</label>
				<input type="text" size="25" name="reportName"/>
				<label class="radioButton"><input name="isNi" type="radio" value="实名"/>实名举报</label>
				<label class="radioButton"><input name="isNi" type="radio" value="匿名"/>匿名举报</label>
				<label class="radioButton"><input name="isNi" type="radio" value="高相似度"/>高相似度</label>
				<!-- 
				<input type="checkbox" name="isNi" value="匿名举报" />匿名
				 -->
			</div>
			<div class="unit">
				<label>被举报人姓名：</label>
				<input type="text" size="25" name="beReportName"/>
				<span class="inputInfo">全称</span>
			</div>
			<div class="unit">
				<label>依托单位：</label>
				<input type="text" size="35" name="dept"/>
				<span class="inputInfo">全称</span>
			</div>
			<div class="unit">
				<label>所属学部：</label>
				<input id="citySel" name="faculty" type="text" size="30" />
				<a id="menuBtn" class="btnLook" href="#" onclick="showMenu(); return false;">选择</a>
				<span class="info">选择</span>
			</div>
			<div class="unit">
				<label>举报时间    从：</label>
				<input type="text" size="25" name="jbBeginTime" class="date readonly"/>
				<span class="inputInfo">大于等于</span>
			</div>
			<div class="unit">
				<label>至：</label>
				<input type="text" size="25" name="jbEndTime" class="date readonly"/>
				<span class="inputInfo">小于等于</span>
			</div>
			<div class="unit">
				<label>受理时间    从：</label>
				<input type="text" size="25" name="createBeginTime" class="date readonly"/>
				<span class="inputInfo">大于等于</span>
			</div>
			<div class="unit">
				<label>至：</label>
				<input type="text" size="25" name="createEndTime" class="date readonly"/>
				<span class="inputInfo">小于等于</span>
			</div>
			<!-- 
			<div class="unit">
				<label>举报事由：</label>
				<select name="reportReason">
					<option value="">全部</option>
					<option>按客户号倒排</option>
					<option>按建档日期倒排</option>
					<option>按信用等级顺排</option>
					<option>按客户号顺排</option>
					<option>按建档日期顺排</option>
					<option>按所属行业顺排</option>
				</select>
			</div>
			 -->
			<div class="unit">
				<label>处理会议：</label>
				<input type="text" size="35" name="conference"/>
				<span class="inputInfo">关键词或全称</span>
			</div>
			<div class="unit">
				<label>当前状态：</label>
				<label class="radioButton"><input name="status" type="radio" value="" checked/>全部</label>
				<label class="radioButton"><input name="status" type="radio" value="12"/>已受理</label>
				<label class="radioButton"><input name="status" type="radio" value="11"/>已初步核实</label>
				<label class="radioButton"><input name="status" type="radio" value="22"/>调查中</label>
				<label class="radioButton"><input name="status" type="radio" value="30"/>处理讨论中</label>
				<label class="radioButton"><input name="status" type="radio" value="41"/>不予调查</label>
				<label class="radioButton"><input name="status" type="radio" value="43"/>转出</label>
			</div>
			<div class="unit">
				<label>&nbsp;</label>
				<label class="radioButton"><input name="status" type="radio" value="42"/>未受理</label>
				<label class="radioButton"><input name="status" type="radio" value="31"/>已处理</label>
				<label class="radioButton"><input name="status" type="radio" value="32"/>异议申请</label>
				<label class="radioButton"><input name="status" type="radio" value="40"/>已结束</label>
				<label class="radioButton"><input name="status" type="radio" value="50"/>不予立案</label>
				<label class="radioButton"><input name="status" type="radio" value="51"/>暂不立案</label>
				<label class="radioButton"><input name="status" type="radio" value="52"/>暂不结案</label>
			</div>
			<div class="divider">divider</div>
			<div class="unit">
				<label>排序条件：</label>
				<select name="orderWay">
					<option value="">默认排序</option>
					<option value="a.SERIALNUM">按编号排序</option>
					<option value="a.REPORTTIME">按举报日期排序</option>
					<option value="a.CREATETIME">按受理日期排序</option>
					<option value="a.STATUS">按状态排序</option>
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
	<ul id="gjSearchTree" class="ztree" style="margin-top:0; width:240px;"></ul>
</div>