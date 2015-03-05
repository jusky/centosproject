package com.whu.tools;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFFooter;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.PrintSetup;
import org.apache.poi.ss.util.CellRangeAddress;

import com.whu.web.email.ContactBean;
import com.whu.web.event.EventBean;
import com.whu.web.eventbean.ExpertInfo;
import com.whu.web.eventbean.HandleDecide;
import com.whu.web.user.WYBean;
import com.whu.web.wsjb.WsjbInfo;
import com.whu.web.credit.InstituteInfo;
import com.whu.web.credit.IndividualInfo;
import com.whu.web.credit.MiscountInfo;

public class ExcelTools {
	
	private HSSFWorkbook wb = null;
	private HSSFCellStyle cellstyle = null;
	/**
	 * ����һ����Ԫ������
	 * @param wb �����ռ�
	 * @param row ��
	 * @param col �к�
	 * @param align ���뷽ʽ
	 * @param val ��Ԫ���ֵ
	 */
	private void createCell(HSSFWorkbook wb, HSSFRow row, short col,
			short align, String val) {
		HSSFCell cell = row.createCell(col);
		cell.setCellValue(val);
		cellstyle.setAlignment(align);
		cell.setCellStyle(cellstyle);
	}
	
	public ExcelTools()
	{
		wb = new HSSFWorkbook();
		cellstyle = wb.createCellStyle();
		cellstyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellstyle.setWrapText(true);
		cellstyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellstyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellstyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cellstyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
	}
	
	public void createSheet(ResultSet res, OutputStream os) throws IOException
	{
		HSSFSheet sheet = wb.createSheet("new sheet");
		wb.setSheetName(0, "事件列表");
		HSSFRow row = sheet.createRow((short)0);
		sheet.createFreezePane(0, 1);
		createCell(wb, row, (short)0, HSSFCellStyle.ALIGN_CENTER_SELECTION, "编号");
		createCell(wb, row, (short)1, HSSFCellStyle.ALIGN_CENTER_SELECTION, "举报人");
		createCell(wb, row, (short)2, HSSFCellStyle.ALIGN_CENTER_SELECTION, "被举报人");
		createCell(wb, row, (short)3, HSSFCellStyle.ALIGN_CENTER_SELECTION, "举报事由");
		createCell(wb, row, (short)4, HSSFCellStyle.ALIGN_CENTER_SELECTION, "办理情况");
		
		exportExcel(res, os, sheet);
	}
	/**
	 * 生成Excel表的行和列，并填充数据
	 * @param result
	 * @param os
	 * @param sheetName
	 * @param type
	 * @throws IOException
	 */
	public void createEventSheet(ArrayList result, OutputStream os, String sheetName,int type, ArrayList titleList) throws IOException
	{
		HSSFSheet sheet = wb.createSheet("new sheet");
		wb.setSheetName(0, sheetName);
		Map<String, HSSFCellStyle> styles = createStyles(wb);

		//excel表头
		HSSFRow titleRow = sheet.createRow(0);
        titleRow.setHeightInPoints(45);
        Cell titleCell = titleRow.createCell(0);
        titleCell.setCellValue(sheetName);
        titleCell.setCellStyle(styles.get("title"));
        //A表示第一列，F表示最后一列，合并单元格
        if(type == 3 || type == 4 || type == 9)
        {
        	sheet.addMergedRegion(CellRangeAddress.valueOf("$A$1:$H$1"));
        }
        else if(type == 5)
        {
        	sheet.addMergedRegion(CellRangeAddress.valueOf("$A$1:$G$1"));
        }
        else if(type == 6)
        {
        	sheet.addMergedRegion(CellRangeAddress.valueOf("$A$1:$C$1"));
        }
        else if(type == 7 || type == 8){
        	sheet.addMergedRegion(CellRangeAddress.valueOf("$A$1:$E$1"));
        }
        else
        {
        	sheet.addMergedRegion(CellRangeAddress.valueOf("$A$1:$F$1"));
        }

		//设置页面为横向
		PrintSetup printSetup = sheet.getPrintSetup();
        printSetup.setLandscape(true);
        
        HSSFFooter footer = sheet.getFooter();
        footer.setRight( "Page " + HSSFFooter.page() + " of " + HSSFFooter.numPages() );

		HSSFRow row = sheet.createRow((short)1);
		
		//设置行的高度
		row.setHeightInPoints(25.75f);
		
		for(int i = 0; i < titleList.size(); i++)
		{
			createCell(wb, row, (short)i, HSSFCellStyle.ALIGN_CENTER, (String)titleList.get(i));
		}

		try{
		//网上举报列表
		if(type == 1)
		{
			WsjbInfo wi;
			int temp = 1;
			for(int i=0; i < result.size();)
			{
				temp++;
				wi = (WsjbInfo)result.get(i);
				HSSFRow row2 = sheet.createRow((short)temp);
				row2.setHeightInPoints(20.75f);
				createCell(wb, row2, (short)0, HSSFCellStyle.ALIGN_CENTER, wi.getSerialNum());
				createCell(wb, row2, (short)1, HSSFCellStyle.ALIGN_CENTER, wi.getReportName());
				createCell(wb, row2, (short)2, HSSFCellStyle.ALIGN_CENTER, wi.getBeReportName());
				createCell(wb, row2, (short)3, HSSFCellStyle.ALIGN_CENTER, wi.getTime());
				createCell(wb, row2, (short)4, HSSFCellStyle.ALIGN_CENTER, wi.getJbsy2());
				createCell(wb, row2, (short)5, HSSFCellStyle.ALIGN_CENTER, "新增");
				i++;
			}
			//设置列的宽度
			sheet.setColumnWidth(3, 256*15);
			sheet.setColumnWidth(4, 256*70);
		}
		else if(type == 2)//事件列表
		{
			EventBean eb;
			int temp = 1;
			for(int i=0; i < result.size();i++)
			{
				temp++;
				eb = (EventBean)result.get(i);
				HSSFRow row2 = sheet.createRow((short)temp);
				row2.setHeightInPoints(20.75f);
				createCell(wb, row2, (short)0, HSSFCellStyle.ALIGN_CENTER, eb.getSerialNum());
				createCell(wb, row2, (short)1, HSSFCellStyle.ALIGN_CENTER, eb.getReportName());
				createCell(wb, row2, (short)2, HSSFCellStyle.ALIGN_CENTER, eb.getBeReportName());
				createCell(wb, row2, (short)3, HSSFCellStyle.ALIGN_CENTER, eb.getReportReason());
				createCell(wb, row2, (short)4, HSSFCellStyle.ALIGN_CENTER, eb.getReportTime());
				createCell(wb, row2, (short)5, HSSFCellStyle.ALIGN_CENTER, eb.getStatus());
			}
			//设置列的宽度
			sheet.setColumnWidth(3, 256*70);
			sheet.setColumnWidth(4, 256*15);
		}
		else if(type == 3)//专家信息列表
		{
			ExpertInfo ei;
			int temp = 1;
			for(int i=0; i < result.size();i++)
			{
				temp++;
				ei = (ExpertInfo)result.get(i);
				HSSFRow row2 = sheet.createRow((short)temp);
				row2.setHeightInPoints(20.75f);
				createCell(wb, row2, (short)0, HSSFCellStyle.ALIGN_CENTER, ei.getSerialNum());
				createCell(wb, row2, (short)1, HSSFCellStyle.ALIGN_CENTER, ei.getName());
				createCell(wb, row2, (short)2, HSSFCellStyle.ALIGN_CENTER, ei.getTitle());
				createCell(wb, row2, (short)3, HSSFCellStyle.ALIGN_CENTER, ei.getDept());
				createCell(wb, row2, (short)4, HSSFCellStyle.ALIGN_CENTER, ei.getSpecialty());
				createCell(wb, row2, (short)5, HSSFCellStyle.ALIGN_CENTER, ei.getResearch());
				createCell(wb, row2, (short)6, HSSFCellStyle.ALIGN_CENTER, ei.getPhone());
				createCell(wb, row2, (short)7, HSSFCellStyle.ALIGN_CENTER, ei.getFaculty());
			}
			//设置列的宽度
			sheet.setColumnWidth(3, 256*25);
			sheet.setColumnWidth(4, 256*20);
			sheet.setColumnWidth(5, 256*20);
			sheet.setColumnWidth(6, 256*15);
			sheet.setColumnWidth(3, 256*25);
		}
		else if(type == 4)//委员信息列表
		{
			WYBean wyBean;
			int temp = 1;
			for(int i=0; i < result.size();i++)
			{
				temp++;
				wyBean = (WYBean)result.get(i);
				HSSFRow row2 = sheet.createRow((short)temp);
				row2.setHeightInPoints(20.75f);
				createCell(wb, row2, (short)0, HSSFCellStyle.ALIGN_CENTER, wyBean.getSerialNum());
				createCell(wb, row2, (short)1, HSSFCellStyle.ALIGN_CENTER, wyBean.getName());
				createCell(wb, row2, (short)2, HSSFCellStyle.ALIGN_CENTER, wyBean.getSex().equals("1") ? "男" : "女");
				createCell(wb, row2, (short)3, HSSFCellStyle.ALIGN_CENTER, wyBean.getDept());
				createCell(wb, row2, (short)4, HSSFCellStyle.ALIGN_CENTER, wyBean.getTitle());
				createCell(wb, row2, (short)5, HSSFCellStyle.ALIGN_CENTER, wyBean.getTxAddress());
				createCell(wb, row2, (short)6, HSSFCellStyle.ALIGN_CENTER, wyBean.getEmail());
				createCell(wb, row2, (short)7, HSSFCellStyle.ALIGN_CENTER, wyBean.getPhone());
			}
			//设置列的宽度
			sheet.setColumnWidth(3, 256*25);
			sheet.setColumnWidth(4, 256*20);
			sheet.setColumnWidth(5, 256*30);
			sheet.setColumnWidth(6, 256*20);
			sheet.setColumnWidth(3, 256*20);
		}
		else if(type == 5)//处理决定列表
		{
			HandleDecide hd;
			int temp = 1;
			for(int i=0; i < result.size();i++)
			{
				temp++;
				hd = (HandleDecide)result.get(i);
				HSSFRow row2 = sheet.createRow((short)temp);
				row2.setHeightInPoints(20.75f);
				createCell(wb, row2, (short)0, HSSFCellStyle.ALIGN_CENTER, hd.getXuhao());
				createCell(wb, row2, (short)1, HSSFCellStyle.ALIGN_CENTER, hd.getSerialNum());
				createCell(wb, row2, (short)2, HSSFCellStyle.ALIGN_CENTER, hd.getHandleName());
				createCell(wb, row2, (short)3, HSSFCellStyle.ALIGN_CENTER, hd.getDeptName());
				createCell(wb, row2, (short)4, HSSFCellStyle.ALIGN_CENTER, hd.getConference());
				createCell(wb, row2, (short)5, HSSFCellStyle.ALIGN_CENTER, hd.getHandleTime());
				createCell(wb, row2, (short)6, HSSFCellStyle.ALIGN_CENTER, hd.getDecideContent());
			}
			//设置列的宽度
			sheet.setColumnWidth(3, 256*25);
			sheet.setColumnWidth(4, 256*20);
			sheet.setColumnWidth(5, 256*15);
			sheet.setColumnWidth(6, 256*50);
		}
		else if(type == 6)//通讯录
		{
			ContactBean contactBean;
			int temp = 1;
			for(int i=0; i < result.size();i++)
			{
				temp++;
				contactBean = (ContactBean)result.get(i);
				HSSFRow row2 = sheet.createRow((short)temp);
				row2.setHeightInPoints(20.75f);
				createCell(wb, row2, (short)0, HSSFCellStyle.ALIGN_CENTER, contactBean.getId());
				createCell(wb, row2, (short)1, HSSFCellStyle.ALIGN_CENTER, contactBean.getContactName());
				createCell(wb, row2, (short)2, HSSFCellStyle.ALIGN_CENTER, contactBean.getContactAddr());
				
			}
			//设置列的宽度
			sheet.setColumnWidth(1, 256*20);
			sheet.setColumnWidth(2, 256*30);
		}
		else if(type == 7) { //institute info
			InstituteInfo inst;
			int temp = 1;
			for(int i=0; i < result.size();i++)
			{
				temp++;
				inst = (InstituteInfo)result.get(i);
				HSSFRow row2 = sheet.createRow((short)temp);
				row2.setHeightInPoints(20.75f);
				createCell(wb, row2, (short)0, HSSFCellStyle.ALIGN_CENTER, inst.getCode());
				createCell(wb, row2, (short)1, HSSFCellStyle.ALIGN_CENTER, inst.getName());
				createCell(wb, row2, (short)2, HSSFCellStyle.ALIGN_CENTER, inst.getCredit());
				createCell(wb, row2, (short)3, HSSFCellStyle.ALIGN_CENTER, inst.getCount());
				createCell(wb, row2, (short)4, HSSFCellStyle.ALIGN_CENTER, inst.getAddress());
			} 
			//设置列的宽度
			sheet.setColumnWidth(4, 256*70);
			sheet.setColumnWidth(0, 256*25);
			sheet.setColumnWidth(1, 256*40);
			sheet.setColumnWidth(3, 256*20);
			sheet.setColumnWidth(2, 256*20);
		}
		else if(type == 8) {	//individual info

			IndividualInfo indi;
			int temp = 1;
			for(int i=0; i < result.size();i++)
			{
				temp++;
				indi = (IndividualInfo)result.get(i);
				HSSFRow row2 = sheet.createRow((short)temp);
				row2.setHeightInPoints(20.75f);
				createCell(wb, row2, (short)0, HSSFCellStyle.ALIGN_CENTER, indi.getName());
				createCell(wb, row2, (short)1, HSSFCellStyle.ALIGN_CENTER, indi.getPid());
				createCell(wb, row2, (short)2, HSSFCellStyle.ALIGN_CENTER, indi.getCredit());
				createCell(wb, row2, (short)3, HSSFCellStyle.ALIGN_CENTER, indi.getInstitute());
				createCell(wb, row2, (short)4, HSSFCellStyle.ALIGN_CENTER, indi.getAddress());
			}
			//设置列的宽度
			sheet.setColumnWidth(4, 256*70);
			sheet.setColumnWidth(1, 256*30);
		}
		else if(type == 9) { //miscount info

			MiscountInfo mis;
			int temp = 1;
			for(int i=0; i < result.size();i++)
			{
				temp++;
				mis = (MiscountInfo)result.get(i);
				HSSFRow row2 = sheet.createRow((short)temp);
				row2.setHeightInPoints(20.75f);
				createCell(wb, row2, (short)0, HSSFCellStyle.ALIGN_CENTER, mis.getMiscountId());
				createCell(wb, row2, (short)1, HSSFCellStyle.ALIGN_CENTER, mis.getTitle());
				createCell(wb, row2, (short)2, HSSFCellStyle.ALIGN_CENTER, mis.getIndividual());
				createCell(wb, row2, (short)3, HSSFCellStyle.ALIGN_CENTER, mis.getInstitute());
				createCell(wb, row2, (short)4, HSSFCellStyle.ALIGN_CENTER, mis.getMistype());
				createCell(wb, row2, (short)5, HSSFCellStyle.ALIGN_CENTER, mis.getPunish());
				createCell(wb, row2, (short)6, HSSFCellStyle.ALIGN_CENTER, mis.getTime());
				createCell(wb, row2, (short)7, HSSFCellStyle.ALIGN_CENTER, mis.getReportId());
			}
			//设置列的宽度
			sheet.setColumnWidth(0, 256*25);
			sheet.setColumnWidth(1, 256*40);
			sheet.setColumnWidth(3, 256*30);
			sheet.setColumnWidth(4, 256*55);
			sheet.setColumnWidth(5, 256*35);
			sheet.setColumnWidth(6, 256*25);
			sheet.setColumnWidth(7, 256*20);
		}
		} catch (Exception e) { e.printStackTrace();};
		wb.write(os);
		os.flush();
		os.close();
	}
	/**
	 * 导出事件列表到excel
	 * @param res
	 * @param os
	 * @throws IOException
	 */
	public boolean expertEvent(ResultSet res, OutputStream os)
	{
		HSSFSheet sheet = wb.createSheet("new sheet");
		wb.setSheetName(0, "事件列表");
		HSSFRow row = sheet.createRow((short)0);
		sheet.createFreezePane(0, 1);
		createCell(wb, row, (short)0, HSSFCellStyle.ALIGN_CENTER_SELECTION, "编号");
		createCell(wb, row, (short)1, HSSFCellStyle.ALIGN_CENTER_SELECTION, "举报人");
		createCell(wb, row, (short)2, HSSFCellStyle.ALIGN_CENTER_SELECTION, "被举报人");
		createCell(wb, row, (short)3, HSSFCellStyle.ALIGN_CENTER_SELECTION, "举报时间");
		createCell(wb, row, (short)4, HSSFCellStyle.ALIGN_CENTER_SELECTION, "举报事由");
		createCell(wb, row, (short)5, HSSFCellStyle.ALIGN_CENTER_SELECTION, "办理情况");
		
		try
		{
			exportExcel(res, os, sheet);
			return true;
		}
		catch(IOException e)
		{
			return false;
		}
	}
	/**
	 * 导出指定的sheet到文件中
	 * @param res
	 * @param os
	 * @param sheet
	 * @throws IOException
	 */
	private void exportExcel(ResultSet res, OutputStream os, HSSFSheet sheet) throws IOException
	{
		int ii = 0;
		try
		{
			int i = 0;
			ii = res.getMetaData().getColumnCount();
			while(res.next())
			{
				i++;
				HSSFRow row2 = sheet.createRow((short)i);
				createCell(wb, row2, (short)0, HSSFCellStyle.ALIGN_CENTER_SELECTION, res.getString("SERIALNUM"));
				createCell(wb, row2, (short)1, HSSFCellStyle.ALIGN_CENTER_SELECTION, res.getString("REPORTNAME"));
				createCell(wb, row2, (short)2, HSSFCellStyle.ALIGN_CENTER_SELECTION, res.getString("BEREPORTNAME"));
				createCell(wb, row2, (short)3, HSSFCellStyle.ALIGN_CENTER_SELECTION, res.getString("REPORTTIME"));
				createCell(wb, row2, (short)4, HSSFCellStyle.ALIGN_CENTER_SELECTION, res.getString("REPORTREASON"));
				createCell(wb, row2, (short)5, HSSFCellStyle.ALIGN_CENTER_SELECTION, res.getString("CAPTION"));
				/*
				for(int j = 0; j < ii; j++)
				{
					String ss = "";
					
					if(res.getString(j+1) == null)
						ss = "�� null";
					else
						ss = res.getString(j+1);
					createCell(wb, row2, (short)j, HSSFCellStyle.ALIGN_CENTER_SELECTION, res.getString("SERIALNUM"));
				}
				*/
			}
		}
		catch (Exception e) {
			System.out.println(e);
		}
		wb.write(os);
		os.flush();
		os.close();
	}
	
	private Map<String, HSSFCellStyle> createStyles(HSSFWorkbook wb){
        Map<String, HSSFCellStyle> styles = new HashMap<String, HSSFCellStyle>();
        HSSFCellStyle style;
        HSSFFont titleFont = wb.createFont();
        titleFont.setFontHeightInPoints((short)18);
        titleFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
        style = wb.createCellStyle();
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        style.setFont(titleFont);
        styles.put("title", style);
        
        style = wb.createCellStyle();
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        style.setWrapText(true);
        style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        style.setBorderTop(HSSFCellStyle.BORDER_THIN);
        style.setBorderRight(HSSFCellStyle.BORDER_THIN);
        styles.put("cell", style);
        
        return styles;
    }

	
	public static void main(String[] args) throws IOException {}
}
