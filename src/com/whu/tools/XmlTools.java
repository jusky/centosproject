package com.whu.tools;

import java.io.File;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.TreeMap;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.w3c.dom.Document;
import org.xml.sax.InputSource;

import com.whu.web.common.SystemShare;
import com.whu.web.eventmanage.ItemAndNum;

public class XmlTools {
	/**
	 * 创建xml文件，用于前台统计结果的显示
	 * @param caption 标题
	 * @param xAsisName X坐标显示内容
	 * @param yAxisName Y坐标显示内容
	 * @param numberPrefix 单位
	 * @param setTable 数据
	 * @param type 统计方式，1表示以“各个阶段统计”，2表示以“各个状态统计”；此处的分别体现在key和javascript传入的值。
	 * @return
	 */
	public String CreateXml(String caption, String xAxisName, String yAxisName, String numberPrefix, ArrayList itemList, String type)
	{
		if(itemList.size() <= 0)
		{
			return "";
		}
		String head = "<chart caption='" + caption + "' xAxisName='" + xAxisName + "' yAxisName='" + yAxisName + "' numberPrefix='" + numberPrefix + "'>";
		String styles = "<styles>" + "\n" + "<definition>" + "\n" + "<style name='myCaptionSize' type='font' color='639ACE' bold='1' size='12' ></style>" + "\n" + "</definition>" + "\n" + "<application>" + "\n" + "<apply toObject='caption' styles='myCaptionSize' ></apply>" + "\n" + "</application>" + "\n" + "</styles>";
		String data = "";
		String key = "";
		String value = "";
		//javascript传入的参数，用于点击图标时，跳转到指定的页面
		String jsPar = "";
		ItemAndNum ian;
		for(int i = 0; i < itemList.size(); i++)
		{
			ian =(ItemAndNum) itemList.get(i);
			key = ian.getItem();
			value = ian.getNum();
			if(type.equals("1"))//以阶段统计
			{
				jsPar = "JavaScript:myJDJS('" + key + "');";
				key = SystemShare.GetJDNameFormID(key);
			}
			else if(type.equals("2"))//以状态统计
			{
				jsPar = "JavaScript:myJS('" + SystemShare.GetStatusFormName(key) + "');";
			}
			data += "\n" +  "<set label='" + key + "' value='" + value + "' link=\"" + jsPar + "\"/>";
		}
		String dataXml = head  + data + "\n" +  "</chart>";
		return dataXml;
	}
	/**
	 * 将xml格式的字符串保存为本地文件，如果字符串格式不符合xml规则，则返回失败
	 * @param str
	 * @param filename
	 * @return
	 */
	public static boolean string2XmlFile(String str,String filename) 
    { 
      boolean flag = true; 
      /* 以下格式生成的文件是以UTF-8为格式 */ 
      try 
       { 
          Document doc = string2Document(str);        
          flag = doc2XmlFile(doc,filename); 
       }catch (Exception ex) 
       { 
          flag = false; 
          ex.printStackTrace(); 
       } 
      /** 以下不通过xml格式验证，象生成普通文件格式的方法生成xml文件 
         OutputStream os = null;        
         try { 
                 os = new FileOutputStream(filename); 
                 os.write(str.getBytes()); 
                 os.flush(); 
         } catch (Exception ex) { 
                 flag = false; 
                 ex.printStackTrace(); 
         }finally 
         {      
               try{ 
                 if (os!=null) os.close(); 
               }catch (Exception ex) { 
                 ex.printStackTrace(); 
               }               
         } 
          */ 
      return flag; 
    }
	/**
	 * 将符合XML格式的String 转化为XML Document
	 * @param s
	 * @return
	 */
	public static Document string2Document(String s) 
    { 
       Document document = null; 
      try 
       { 
           DocumentBuilder parser = DocumentBuilderFactory.newInstance().newDocumentBuilder(); 
           document = parser.parse( new InputSource(new StringReader(s)) ); 
       }catch(Exception ex) 
       {             
            ex.printStackTrace(); 
       } 
      return document; 
    }
	/**
	 * 将Document对象保存为一个xml文件到本地
	 * @param document
	 * @param filename
	 * @return
	 */
	public static boolean doc2XmlFile(Document document,String filename) 
    { 
      boolean flag = true; 
      try 
       { 
            /** 将document中的内容写入文件中   */ 
             TransformerFactory tFactory = TransformerFactory.newInstance();    
             Transformer transformer = tFactory.newTransformer(); 
            /** 编码 */ 
            //transformer.setOutputProperty(OutputKeys.ENCODING, "GB2312"); 
             DOMSource source = new DOMSource(document); 
             StreamResult result = new StreamResult(new File(filename));    
             transformer.transform(source, result); 
         }catch(Exception ex) 
         { 
             flag = false; 
             ex.printStackTrace(); 
         } 
        return flag;       
    }
	/**
	 * 受理与立案数统计
	 * @param caption 标题
	 * @param yAxisName y坐标
	 * @param slList 受理月份和数目列表
	 * @param laList 立案月份和数目列表
	 * @return
	 */
	public String CreateLineXml(String caption, String yAxisName, String year, HashMap slTable, HashMap laTable) {
		String head = "<chart canvasPadding='10' caption=" + caption + " yAxisName=" + yAxisName + " bgColor='F7F7F7, E9E9E9' numVDivLines='10' divLineAlpha='30'  labelPadding ='10' yAxisValuesPadding ='10' showValues='1' rotateValues='1' valuePosition='auto'>";
		String categories = "<categories><category label='一月' /><category label='二月' /><category label='三月' /><category label='四月' /><category label='五月' /><category label='六月' /><category label='七月' /><category label=' 八月' /><category label='九月' /><category label='十月' /><category label='十一月' /><category label='十二月' /></categories>";
		
		String temp = "";
		for(int i = 1; i <= 12; i++)
		{
			temp = year;
			//个位数需要在前面补一个0
			if(i <= 9)
			{
				temp += "-0";
			}
			else
			{
				temp += "-"; 
			}
			temp += String.valueOf(i);
			//将没有的数据补充完整，以防止有些月份只有受理数，或者只有立案数，显示出错
			if(!slTable.containsKey(temp))
			{
				slTable.put(temp, "0");
			}
			if(!laTable.containsKey(temp))
			{
				laTable.put(temp, "0");
			}
		}
		
		String dataset = "<dataset seriesName='受理数' color='A66EDD' >";
		String dataset2 = "<dataset seriesName='调查数' color='F6BD0F'>";
		
		//TreeMap可以按照key自动排序，hasttable不能排序，数据需要与月份一一对应
		TreeMap treemap1 = new TreeMap(slTable);
		TreeMap treemap2 = new TreeMap(laTable);
		
		
		String key = "";
		String value = "";
		String tempStr = "";
		//显示受理数，以此遍历
		for(Iterator it = treemap1.keySet().iterator(); it.hasNext();)
		{
			key = (String)it.next();
			value = (String)treemap1.get(key);
			if(!key.equals(temp + "-12"))
			{
				tempStr += "<set value='" + value + "'/>";
			}
			else//如果是12月份，则将valuePosition属性设置为above
			{
				tempStr += "<set value='" + value + "' valuePosition='above'/>";
			}
		}
		dataset += tempStr + "</dataset>";
		tempStr = "";
		for(Iterator it = treemap2.keySet().iterator(); it.hasNext();)
		{
			key = (String)it.next();
			value = (String)treemap2.get(key);
			tempStr += "<set value='" + value + "'/>";
		}
		dataset2 += tempStr + "</dataset>";
		return head + "\n" + categories + "\n" + dataset + "\n" + dataset2 + "\n" + "</chart>";
	}
	public static void main(String[] args) {
		HashMap hm = new HashMap();
		hm.put("2","2");
		hm.put("3","3");
		hm.put("1","1");
		hm.put("7","7");
		hm.put("6","6");
		TreeMap treemap = new TreeMap(hm);  
		System.out.println("aa");
	}
}
