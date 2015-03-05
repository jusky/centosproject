	<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%  
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://"  
                + request.getServerName() + ":" + request.getServerPort()  
                + path + "/";  
%> 
<center>
		<div style="float:left; display:block; overflow:auto; width:650px; line-height:21px;">
			<div class="panel" defH="500">
				<h1>历年违规人次</h1>
					<div>
						<div id="creditTrendJson" style="display:none;"><%=request.getAttribute("creditTrend") %></div>
						<div id="creditTrendContainer" align="center">
						<script type="text/javascript">	
							var myChart = new FusionCharts( "<%=path%>/Charts/Line.swf", 
									"creditTrend", "600", "450", "0" ); 
							var chartJson = document.getElementById("creditTrendJson").innerHTML;
							myChart.setJSONData(chartJson);
							myChart.render("creditTrendContainer");
						</script>
						</div>
					</div>
				</div>
		</div>
</center>							