<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="pageContent" layoutH="1">
	<form method="post" action="/sendMsgListAction?method=sendMsg" class="pageForm required-validate" onsubmit="return validateCallback(this, navTabAjaxDone);">
		<div class="panel collapse" defH="130">
			<h1>我的日程</h1>
			<div>

			</div>
		</div>
		<div class="panel collapse" defH="408">
			<h1>当前日历</h1>
			<div style="height: 408px;">
				<iframe src="<%=request.getContextPath()%>/web/date/time.jsp" width="100%" height="100%" name="show">
			</iframe>
		</div>
		</div>
	</form>
</div>

