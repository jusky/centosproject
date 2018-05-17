package com.whu.web.expert;

import java.util.List;

import org.apache.struts.action.ActionForm;

public class UnLoginedExpertForm extends ActionForm{
		//是否发现有结果
		private String recordNotFind = "false";
		//结果链表
		private List recordList = null;
		//查询专家姓名
		private String expertName ;
		
		
		public String getRecordNotFind() {
			return recordNotFind;
		}
		public void setRecordNotFind(String recordNotFind) {
			this.recordNotFind = recordNotFind;
		}

		public List getRecordList() {
			return recordList;
		}
		public void setRecordList(List recordList) {
			this.recordList = recordList;
		}
		
		public String getExpertName() {
			return expertName;
		}

		public void setExpertName(String expertName) {
			this.expertName = expertName;
		}
}
