<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<script type="text/javascript">
var zTree;
var treeNodes;
var key;
var setting = {
	data: {
		key: {
			title: "t"
		},
		simpleData: {
			enable: true
		}
	},
	callback: {
		beforeClick: beforeClick,
		onClick: onClick
	}
};

function beforeClick(treeId, treeNode, clickFlag) {
	return (treeNode.click != false);
}
function onClick(event, treeId, treeNode, clickFlag) {
	var treeObj = $.fn.zTree.getZTreeObj("zzTree");
	var nodes = treeObj.getSelectedNodes();
	var id = nodes[0].id;
	if(id != "" && id != null)
	{
		$('#contactBox').loadUrl('<%=path%>/createGroupAction.do?method=select&id=' + id);
	}
}
$(function(){  
    $.ajax({
        async : false,  
        cache:false,  
        type: 'POST',  
        dataType : "json",  
        url: "<%=path%>/createGroupAction.do?method=init",//请求的action路径  
        error: function () {//请求失败处理函数  
            alert('请求失败');  
        },  
        success:function(data){ //请求成功后处理函数。    
            treeNodes = data;   //把后台封装好的简单Json格式赋给treeNodes  
        }  
    });
  
    $.fn.zTree.init($("#zzTree"), setting, treeNodes);
});
</script>
<script language="JavaScript">
	var intRowIndex = 0;
	var celCount = 5;
	function insertRow(id, name, unit){
		var rowNum = myTable.rows.length;
		var objRow,objCel,celNum;
		if(rowNum == 0)
		{
			objRow = myTable.insertRow(rowNum);
			celNum = 0;
		}
		else
		{
			rowNum = rowNum - 1;
			objRow = myTable.rows[rowNum];
			celNum = objRow.cells.length;
			if(celNum == celCount)
			{
				objRow = myTable.insertRow(rowNum + 1);
				celNum = 0;
			}
		}
		//var tbIndex = myTable.rows.length;
		//var objRow = myTable.insertRow(tbIndex);
		objCel = objRow.insertCell(celNum);
		//objCel.innerText = id;
		objCel.innerHTML="<input type='button' value='" + name + "'>";
		//var objCel = objRow.insertCell(1);
		//objCel.innerText = name;
		//var objCel = objRow.insertCell(2);
		//objCel.innerText = unit;
		//objRow.attachEvent("ondblclick", dblclickIt);
		//objRow.height="30";
		
	}
	function dblclickIt(){
		var tbIndex = event.srcElement.parentElement.rowIndex;
		myTable.deleteRow(tbIndex);
	}
	function commit()
	{
		var tbIndex = myTable.rows.length;
		var result = "";
		var i = 0;
		for(i=0; i < tbIndex; i++)
		{
			result += myTable.rows[i].cells[0].innerText + ",";
		}
		if(tbIndex <= 0)
		{
			alert("您尚没有选择任何人员，请选择后再成立调查组");
		}
		else
		{
			document.forms[0].action = "<%=path%>/createGroupAction.do?method=create&result='" + result + "'";
    		document.forms[0].submit();
		}
	}
</script>
<script type="text/javascript">
	$('#contactBox').loadUrl('<%=path%>/createGroupAction.do?method=select');
</script>
<div class="pageContent">
	<form id="createForm" method="post" action="<%=path%>/createGroupAction.do?method=create" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
	<div class="pageFormContent" layoutH="56">
	<input type="hidden" name="reportID" value="<%=request.getAttribute("ReportID") %>"/>
		<div class="tabs">
			<div class="tabsHeader">
				<div class="tabsHeaderContent">
					<ul>
						<li><a href="javascript:;"><span>通讯录列表</span></a></li>
					</ul>
				</div>
			</div>
			<div class="tabsContent">
				<div>
					<div layoutH="260" style="float: left; display: block; overflow: auto; width: 240px; border: solid 1px #CCC; line-height: 21px; background: #fff">
					    <ul id="zzTree" class="ztree"></ul>
					</div>
					<div id="contactBox" class="unitBox" style="margin-left:246px;">
						
					</div>
				</div>
			</div>
			<div class="tabsFooter">
				<div class="tabsFooterContent"></div>
			</div>
		</div>
		<div class="panel">
			<h1>其他专家（注意：标有<font color="#ff0000">*</font>的必须填写，最多输入5个专家）</h1>
			<div style="background:#ffffff;">
				<table class="list nowrap itemDetail" addButton="新建专家" width="100%">
					<thead>
						<tr>
							<th align="center" type="text" name="items.name[#index#]" size="15" fieldClass="required">姓名</th>
							<th align="center" type="text" name="items.dept[#index#]" fieldClass="required"  size="40">所属单位</th>
							<th align="center" type="text" name="items.phone[#index#]" size="20">联系方式</th>
							<th align="center" type="text" name="items.email[#index#]" size="20">邮箱地址</th>
							<th align="center" type="text" name="items.research[#index#]" size="30">研究方向</th>
							<th align="center" type="del" width="30">操作</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
		<div class="panel">
				<h1>已选择人员(双击可删除人员)</h1>
				<div style="background:#ffffff;">
					<table width="99%" id="myTable" border="0">
					</table>
				</div>
		</div>
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">成立调查组</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div></li>
			</ul>
		</div>
	</form>
</div>