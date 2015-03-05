<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";  
%> 
<link href="<%=path %>/styles/jquery-ui.min.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=path %>/js/jquery-ui.min.js"></script>
<script>
	var saveWeight = function() {
		var sum = $("#weightSum").html();
		if(sum != 1 || sum != "1.00") {
			alert("权值和因为1");
		} else {
			result = [];
			$.each($(".weightInput"), function() {
				var tmp = {};
				tmp.rid = this.id;
				tmp.weight = this.value;
				result.push(tmp);
			});
			var postObj = {};
			postObj.weightList = JSON.stringify(result);
			var url = "<%=path%>/configMistypeAction.do?method=saveWeight";
			$.post(url, postObj).done(function(data){$.pdialog.closeCurrent();navTab.reload(data.forwardUrl, {},data.navTabId);}).fail(function(){alert("save error!")});
		}
	}

	$(function() {
		var data=eval(<%=request.getAttribute("weightJson")%>);
		var sum = 0.0;
		for(var i=0; i<data.length; i++){
            sum+=data[i].weight;
			$("<tr/>")
			.appendTo("#weightTable")
			.append($("<td/>").html(data[i].rname + "：").attr("align","right"))
			.append($("<td/>")
				.css("align","left")
				.append($("<input/>", {
					"name":data[i].rid,
					"id": data[i].rid,
					"class": "weightInput",
					"value": data[i].weight
					})					
				)
			)
		}
		$(".weightInput").spinner({
			min: 0.00,
			max: 1.00,
			step: 0.01,
			numberFormat: "n",
			spin: function( event, ui ) {
					sum = 0;
					$.each($(".weightInput"), function(){
					sum += Number(Number(this.value).toFixed(2));
					})
					$("#weightSum").text(sum.toFixed(2));
					if(sum === 1){$("#weightSum").css("color", "green")}
					else {$("#weightSum").css("color", "red")};
				}
			})
			
		$("#weightSum").html(sum.toFixed(2));
	});	
</script>

<div class="pageContent">
	<form method="post" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		
	<div class="pageFormContent" layoutH="56">
		<table  width="100%" overflow="auto" cellpadding="3" cellspacing="10" border="0" align="center" id="weightTable">
			<tr background="red">
				<td width="50%" align="right">权值和为：</td>
				<td ><span id="weightSum"></span></td>
			</tr>		
			
		</table>
		</div>
		<div class="formBar">
			<ul>
				<li><div class="button"><div class="buttonContent"><button type="button" onclick="saveWeight();">保存</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">返回</button></div></div></li>
			</ul>
		</div>
	</form>
</div>
