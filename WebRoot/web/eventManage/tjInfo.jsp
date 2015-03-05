<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";
%> 
<script type="text/javascript">
function setDisplay()
{
	document.getElementById("yearDiv").style.display="block";
}
function setNone()
{
	document.getElementById("yearDiv").style.display="none";
}
function myJS(str)
{
	var obj = document.getElementById("tjURL");
	obj.innerHTML=getStatusName(str);
	obj.href="<%=path%>/tjManageAction.do?method=initResult&status=" + str;
	obj.click();
}
function getStatusName(status)
{
	var result="";
	if(status == "11")
	{
		result = "已初步核实";
	}
	else if(status == "12")
	{
		result = "已受理";
	}
	else if(status == "41")
	{
		result = "不予调查";
	}
	else if(status == "22")
	{
		result = "调查中";
	}
	else if(status == "30")
	{
		result = "处理讨论中";
	}
	else if(status == "31")
	{
		result = "已处理";
	}
	else if(status == "40")
	{
		result = "已结束";
	}
	else if(status == "32")
	{
		result = "异议申请";
	}
	else if(status == "42")
	{
		result = "未受理";
	}
	return result;
}
</script>
<div class="pageHeader">
	<html:form  onsubmit="return navTabSearch(this);" action="/tjManageAction.do?method=search" method="post">
		<div class="searchBar">
		<table class="searchContent">
			<tr>
				<td>
					 统计时间 从：
					 <input type="text" class="date" readonly="true" name="tjBeginTime"/>
                                                   至：
        			<input type="text" class="date" readonly="true" name="tjEndTime"/>
				</td>
				<td>
					<label class="radioButton"><input name="type" type="radio" onclick="setNone();" value="1" checked/>状态统计</label>
					<label class="radioButton"><input name="type" type="radio" onclick="setDisplay();" value="2"/>受理与调查统计</label>
				</td>
				<td>
					<div id="yearDiv" style="display:none;">
						年份： <input type="text" name="tjYear"/>
					</div>
				</td>
			</tr>
		</table>
		<div class="subBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">检索</button></div></div></li>
			</ul>
		</div>
	</div>
	</html:form>
</div>
<div class="pageContent">
	<div class="pageFormContent" layoutH="56">
	<a id="tjURL" href="" style="display:none;" target="navTab" rel="testTJ">状态统计</a>
		<logic:equal value="true" name="tjManageForm" property="statusTj">
			<div id="chartXml" style="display:none"><%=request.getAttribute("chartXml") %></div>
			<div id="chartContainer" align="center">
				<script type="text/javascript">	
					var myChart = new FusionCharts( "<%=path%>/Charts/Column3D.swf", 
					"myChartId1", "700", "400", "0" ); 
					var chartXMLObj = document.getElementById("chartXml");
					
					var chartXML = chartXMLObj.innerHTML;
					 myChart.setDataXML(chartXML);
					 myChart.render("chartContainer");
				</script>
			</div>
		</logic:equal>
		<logic:equal value="false" name="tjManageForm" property="statusTj">
			<div id="chartXml2" style="display:none"><%=request.getAttribute("chartXml2") %></div>
			<div id="chartContainer2" align="center">
				<script type="text/javascript" >	
					var myChart2 = new FusionCharts( "<%=path%>/Charts/MSLine.swf", 
					"myChartId2", "700", "400", "0" ); 
					var chartXMLObj2 = document.getElementById("chartXml2");
					
					var chartXML2 = chartXMLObj2.innerHTML;
					 myChart2.setDataXML(chartXML2);
					 myChart2.render("chartContainer2");
				</script>
			</div>
		</logic:equal>
	</div>
</div>
