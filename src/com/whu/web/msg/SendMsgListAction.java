/*
 * Generated by MyEclipse Struts
 * Template path: templates/java/JavaClass.vtl
 */
package com.whu.web.msg;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

/** 
 * MyEclipse Struts
 * Creation date: 07-02-2013
 * 
 * XDoclet definition:
 * @struts.action path="/sendMsgListAction" name="sendMsgListForm" input="/jsp/message/sendMsgList.jsp" parameter="method" scope="request" validate="true"
 */
public class SendMsgListAction extends DispatchAction {
	/*
	 * Generated Methods
	 */

	/** 
	 * Method execute
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return ActionForward
	 */
	public ActionForward init(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		SendMsgListForm sendMsgListForm = (SendMsgListForm) form;// TODO Auto-generated method stub
		sendMsgListForm.setRecordNotFind("true");
		request.setAttribute("pageNum",String.valueOf(0));
		request.setAttribute("totalRows",String.valueOf(0));
		request.setAttribute("pageCount",String.valueOf(0));
		return mapping.findForward("init");
	}
}