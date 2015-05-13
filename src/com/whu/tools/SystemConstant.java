package com.whu.tools;

import com.whu.web.common.SystemShare;

public class SystemConstant {
	
	public static String SYSTEMROOT = "/KXJJBDXW";
	//得到服务器的路径
	public static String GetServerPath()
	{
		String result = "http://" + SystemShare.GetIPAddr() + SYSTEMROOT;
		return result;
	}
	//word文档在线预览工具swfTools的路径
	public static String swfToolsPath = "D:/Program Files/SWFTools/pdf2swf.exe";
	
	public static String domainName="http://" + SystemShare.GetIPAddr() + SYSTEMROOT;
	
	//打印时需要模板文件，该变量设置模板的路径
	public static String TemplateLocalPath = "/home/tmp/kxjjbdxw/";
	
	public static String debugLogPath = "/home/tmp/kxjjbdxwLog.txt";

	//web服务器的端口
	public static String PORT = "80";

	//事件状态
	public static String sjzt = "ZDBZ_SJZT";
	//举报方式
	public static String jbfs = "ZDBZ_JBFS";
	//调查方式
	public static String dcfs = "ZDBZ_DCFS";
	//处理规则
	public static String clgz = "ZDBZ_CLGZ";
	//���˴�������
	public static String grclzl = "ZDBZ_GRCLZL";
	//��λ��������
	public static String dwclzl = "ZDBZ_DWCLZL";
	//������Ϊ�ٱ�����
	public static String bdxwzt = "ZDBZ_BDXWZT";
	//������س̶�
	public static String qjyzcd = "ZDBZ_QJYZCD";
	//字典标示：处理决定
	public static String cljd = "ZDBZ_CLJD";
	
	//被举报人最多添加的个数限制
	public static int beReportNum = 5;
	//新增专家的个数限制
	public static int expertNum = 5;
	
	//事件所处阶段
	//受理阶段
	public static String SS_SLJD = "1";
	//立案调查阶段
	public static String SS_LADCJD = "2";
	//处理阶段
	public static String SS_CLJD = "3";
	//事件审核
	public static String SS_SJSH = "4";
	//已删除事件
	public static String SS_DELETE = "8";
	//全部事件
	public static String SS_ALL = "9";
	
	//事件状态定义
	//新增
	public static String SS_NEWEVENT="10";

	//已初步核实
	public static String SS_CHECKEVENT="11";
	//已受理
	public static String SS_RECVEVENT = "12";
	//未受理
	public static String SS_UNRECVEVENT = "42";
	//不予调查
	public static String SS_UNLA = "41";
	//调查中
	public static String SS_SURVEYING = "22";
	//处理讨论中
	public static String SS_HANDLEING = "30";
	//已处理
	public static String SS_HANDLEDECIDE = "31";
	//复议申请
	public static String SS_FYAPPLY = "32";
	//已立案
	//public static String SS_LAEVENT="20";
	//结束
	public static String SS_END = "40";

	
	//总共数据库表的个数
	public static int TBNum = 10;
	
	//表TB_REPORT需要的密钥个数
	public static int TB_REPORTNUM = 3;
	
	public static String[] TBARRAY = {"TB_REPORTINFO", "TB_BEREPORTPE","TB_CHECKINFO"};
	
	//日志类型
	public static String LOG_DELETE="删除记录";
	public static String LOG_DELETES = "批量删除";
	public static String LOG_NEW = "录入事件";
	public static String LOG_EDIT = "编辑记录";
	public static String LOG_RECV = "接收举报";
	public static String LOG_LOGIN = "登陆系统";
	public static String LOG_NEWKEY = "生成密钥";
	public static String LOG_IMPORTKEY = "导入密钥";
	public static String LOG_ENABLEKEY = "启用密钥";
	public static String LOG_DISABLEKEY = "停用密钥";
	public static String LOG_APPROVE = "审批事件";
	public static String LOG_CHECK = "初步核实事件";
	public static String LOG_DEPTADVICE = "依托单位调查函";
	public static String LOG_EXPERTADVICE = "专家鉴定意见";
	public static String LOG_LITIGANTSTATE = "当事人陈述";
	public static String LOG_SURVEYREPORT = "调查报告";
	public static String LOG_HANDLEDECIDE = "处理决定";
	public static String LOG_FYAPPLY = "复议申请";
	public static String LOG_DISPATCH = "分派查办人员";
	public static String LOG_FACULTYADVICE = "学部意见";
	public static String LOG_HANDLEUPFACULTY = "提交学部";
	
	//密钥文件改变后，无法解密
	public static byte[] UNDECRPTOR = "无法解密".getBytes();
	public static byte[] NODATA = "无".getBytes();
	
	//事件处理过程类型 HandleProcess
	public static String HP_REPORT = "在线举报科研不端行为";
	public static String HP_RECVEVENT = "接收从网上提交的投诉举报";
	public static String HP_INPUT = "录入事件";
	public static String HP_CHECKEVENT = "初步调查核实";
	public static String HP_APPROVEEVENT = "审核事件是否开展调查";
	public static String HP_KZDC = "领导审核完毕，开展调查";
	public static String HP_NOKZDC = "领导审核完毕，不予开展调查";
	public static String HP_DEPTADVICE = "编辑依托单位反馈意见";
	public static String HP_EXPERTADVICE = "编辑鉴定专家意见";
	public static String HP_LIGITANTSTATE = "编辑当事人陈述";
	public static String HP_SURVEYREPORT = "编辑调查报告";
	public static String HP_QWHTL = "提交全委会讨论";
	public static String HP_HANDLEDECIDE = "添加处理决定";
	public static String HP_FYAPPLY = "当事人提出复议申请";
	public static String HP_RESURVEY = "复议申请通过，对事件重新开展调查";
	public static String HP_FACULTYADVICE = "编辑学部意见";
	
	//举报方式
	public static String JBFS_SXJB = "书信举报";
	public static String JBFS_YJJB = "邮件举报";
	public static String JBFS_WLJB = "网络举报";
	public static String JBFS_DHJB = "电话举报";
	public static String JBFS_QTFS = "其他方式";
	//反馈信息
	public static String FK_RECVEVENT = "您举报的事件已经被接收，正在核实中...";
	public static String FK_CHECKEVENT = "已经初步调查核实，审核中!";
	public static String FK_APPROVEEVENT1 = "审核完毕，开展调查中！";
	public static String FK_APPROVEEVENT2 = "经审核，对该事件不予调查！";
	public static String FK_HANDLING = "调查完成，等待委员会讨论！";
	public static String FK_HANDLEDECIDE = "处理决定已经讨论完成，具体结果请等待我们的另行通知！";
	
	//消息通知类型
	//工作提醒
	public static String MSG_GZTX = "1";
	//消息提醒
	public static String MSG_XXTX = "2";
	//邮件提醒
	public static String MSG_YJTX = "3";
	// faculty advice
	public static String MSG_XBYJ = "4";
	
	//最新反馈类型
	//专家鉴定意见
	public static String REPLY_EXPERT = "专家提交鉴定意见和鉴定结论";
	//单位反馈调查结果
	public static String REPLY_DEPT = "依托单位反馈事件的调查结果、当事人陈述和其他意见";
	
	//待办事项显示内容
	//已初步核实，待审批
	public static String DBSX_CHECK = "事件已初步核实，请您审批是否需要立案调查！";
	
	// 请录入学部意见
	public static String DBSX_XBYJ= "请录入学部意见";
	
	//流程图需要显示节点的文本内容
	//
	public static String LCT_SLJB = "监委会受理举报";
	public static String LCT_LDSP = "领导审批";
	public static String LCT_BYLA = "不予调查";
	public static String LCT_DWDC = "委托依托单位调查";
	public static String LCT_ZJJD = "委托专家鉴定";
	public static String LCT_JB = "个人/单位举报";
	public static String LCT_DCHS = "初步调查核实";
	public static String LCT_CS = "当事人陈述";
	public static String LCT_DCBG = "调查报告";
	public static String LCT_TL = "全委会讨论";
	public static String LCT_CLJD = "处理决定";
	public static String LCT_XGBM = "委内相关部门";
	public static String LCT_DWGR = "依托单位/个人";
	public static String LCT_LADC = "开展调查";
	public static String LCT_FYSQ = "复议申请";
	public static String LCT_FACULTY = "学部意见";
	
	public static String[] LCT_ARR = new String[]{"监委会受理举报","领导审批","不予调查","委托依托单位调查","委托专家鉴定","个人/单位举报","初步调查核实","当事人陈述","调查报告","全委会讨论","处理决定","委内相关部门","依托单位/个人","开展调查", "复议申请","学部意见"};
}
