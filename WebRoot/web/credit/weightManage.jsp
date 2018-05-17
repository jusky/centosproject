<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";  
%> 
<script>
	$.validator.addClassRules({weightInput: {ratePercent: true}});
	var saveWeight = function() {
		var sum = $("#weightSum").html();
		if(sum != 1 || sum != 1.00) {
			$("#weightSum").focus();
			$("#weightSumAlert").show();
			setTimeout(function(){$("#weightSumAlert").hide()}, 5000);
		} else {
			result = [];
			$.each($(".weightInput"), function() {
				var tmp = {};
				tmp.rid = this.id.substring(this.id.indexOf("_")+1);
				tmp.weight = this.value;
				result.push(tmp);
			});
			var postObj = {};
			postObj.weightList = JSON.stringify(result);
			var url = "<%=path%>/configMistypeAction.do?method=saveWeight";
	//		$.post(url, postObj).done(dialogAjaxDone).fail(function(){alert("save error!")});
			$.post(url, postObj, dialogAjaxDone, "json");
		}
	}

	$(function() {
		var data=eval(<%=request.getAttribute("weightJson")%>);
		for(var i=0; i<data.length; i++){
			$("<p/>")
         .css({"margin-top":"10px"})
			.appendTo("#weightConfigDiv")
			.append($("<label for='" + data[i].rid + "'/>").html(data[i].rname + "："))
			.append($("<input/>", {
                    "name":data[i].rid,
                    "id": "weightInputId_" + data[i].rid,
                    "class": "weightInput",
                    "value": data[i].weight,
                    	"type": "number",
                    	"step": "0.01",
                    	"alt": "0.00~1.00"
                })					
			);
		};	

		function sumUp(){
			var sum = 0.0;
			$(".weightInput").each(function() {
				sum += Number($(this).val());
				$("#weightSum").html(sum);
				if(sum != 1 || sum != 1.00) $("#weightSum").css("color", "red");
				else {$("#weightSum").css("color", "green");$("#weightSumAlert").hide();}
			})
		}
		$(".weightInput").change(sumUp);
		sumUp();
	});	
</script>

<div class="pageContent">
	<form method="post" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone);">
		
		<div class="pageFormContent" id="weightConfigDiv" layoutH="56">
			<p>
				<label>权值和为：</label>
				<span id="weightSum"></span>
				<span id="weightSumAlert" style="display:none; color:#ff0000; margin-left:30px">权值和应为1</span>
			</p>
		</div>
		<div class="formBar">
			<ul>
				<li><div class="button"><div class="buttonContent"><button type="button" onclick="saveWeight();">保存</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">返回</button></div></div></li>
			</ul>
		</div>
	</form>
</div>
