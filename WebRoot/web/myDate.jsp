<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
var op = {
    view: "week", //默认视图，这里是周视图
    theme:1,//默认的主题风格
    autoload:true, //是否在页面加载完毕后自动获取当前视图时间的数据
    showday: new Date(), //当前视图的显示时间
    EditCmdhandler:edit, //点击的响应事件
    //DeleteCmdhandler:dcal, //删除的响应事件
    ViewCmdhandler:view,    //查看的响应事件
    onWeekOrMonthToDay:wtd,//当when weekview or month switch to dayview 
    onBeforeRequestData: cal_beforerequest,
    onAfterRequestData: cal_afterrequest,
    onRequestDataError: cal_onerror, 
    url: "<%=path%>/servlet/CalendarServlet?type=query" ,  //url for get event data by ajax request(post)
    quickAddUrl: "/calendar/add" ,   //url for quick add event data by ajax request(post)
    quickUpdateUrl: "/calendar/update" ,   //url for quick update event data by ajax request(post)
    quickDeleteUrl:  "/calendar/delete"  //url for quick delete event data by ajax request(post)
};
var _MH = document.documentElement.clientHeight; //获取页面高度，不同的文档类型需要不同的计算方法，注意示例中使用的doctype 用这个就搞定了
op.height = _MH-70; //container height;
op.eventItems =[]; //default event data;
$("#xgcalendarp").bcalendar(op);
</script>
<div class="pageContent" layoutH="1">
	<div id="xgcalendarp"></div>
</div>