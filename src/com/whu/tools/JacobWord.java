package com.whu.tools;
import java.io.File;
import java.util.ArrayList;
import java.util.List;
 
import com.jacob.activeX.ActiveXComponent;
import com.jacob.com.ComThread;
import com.jacob.com.Dispatch;
import com.jacob.com.Variant;
 
public class JacobWord {
    private ActiveXComponent app;
    private Dispatch document;
    private Dispatch selection;
    private Dispatch paragraph;
    private Dispatch font;
 
    // 初始化并新建Word文档
    public JacobWord() {
    	try
    	{
	       ComThread.InitSTA();// 初始化Com线程
	       app = new ActiveXComponent("Word.Application");// 初始化word应用程序
	       app.setProperty("Visible", new Variant(false));// 设置word文档不在前台打开
	       app.setProperty("AutomationSecurity", new Variant(3)); // 禁用宏
	       Dispatch docs = app.getProperty("Documents").toDispatch();// 获取文挡属性
	       document = Dispatch.call(docs, "Add").toDispatch(); // 创建新文档
	       selection = app.getProperty("Selection").toDispatch();// 获得选定内容
	       paragraph = Dispatch.get(selection, "ParagraphFormat").getDispatch();// 段落
	       font = Dispatch.get(selection, "Font").toDispatch();// 字体
    	}
    	catch (Exception e) {
			
		}
    }
 
    public static void main(String[] args) {
    }
 
    // 合并Word文档
    public boolean mergeWord(File[] file, String targetPath) {
    	boolean result = true;
       try {
    	   
           setWordTitle();
           // 设置文本样式，不包括接下来要插入的WORD文档内容
           Dispatch.put(paragraph, "Alignment", "3");// 1:中 2:右 3:左
           Dispatch.put(font, "Color", "1,0,0,0"); // 红色
           Dispatch.put(font, "Size", 12);
          
           for (int i = 0; i < file.length; i++) {
              String tempFile = file[i].getAbsolutePath();
              if (tempFile.endsWith(".doc") || tempFile.endsWith(".docx")) {
                  Dispatch.put(selection, "Text", file[i].getName() + "文档内容如下：");
                  Dispatch.call(selection, "MoveDown");
                  Dispatch.call(selection, "TypeParagraph"); // 空一行段落
                  Dispatch.call(selection, "insertFile", tempFile);// 插入文件内容
                  Dispatch.call(selection, "TypeParagraph"); // 空一行段落
              }
           }
 
           //fillBookmarks(new String[] { "author" }, new String[] { "victor" });
           Dispatch.call(document, "SaveAs", new Variant(targetPath)); //保存
           Dispatch.call(document, "Close", new Variant(false));// 关闭文档
       } catch (Exception ex) {
           ex.printStackTrace();
           result =  false;
       } finally {
           app.invoke("Quit", new Variant(0));// 退出word应用
           ComThread.Release();// 释放Com线程
       }
       return result;
    }
 
    // 设置合并后文档的标题及样式
    private void setWordTitle() {
       Dispatch.put(paragraph, "Alignment", 1);// 1:中 2:右 3:左
       Dispatch.put(font, "Bold", new Variant(true));
       Dispatch.put(font, "Color", "0,0,0,0"); // 黑色
       Dispatch.put(font, "Size", 16);
       Dispatch.call(selection, "TypeText", "合并后的调查文档"); // 写入标题内容
       Dispatch.call(selection, "TypeParagraph"); // 空一行段落
    }
 
    // 填充书签
    public void fillBookmarks(String[] bookmarks, String[] fillValues) {
       Dispatch bookMarks = Dispatch.call(document, "Bookmarks").toDispatch();
       if (bookmarks.length == fillValues.length) {
           for (int i = 0; i < bookmarks.length; i++) {
              Variant isExist = Dispatch.call(bookMarks, "Exists", bookmarks[i]);
              if (isExist.getBoolean()) {
                  Dispatch item = Dispatch.call(bookMarks, "Item", bookmarks[i]).toDispatch();
                  Dispatch range = Dispatch.call(item, "Range").toDispatch();
                  Dispatch.put(range, "Text", fillValues[i]);
              }
           }
       }
    }
    
    public boolean uniteDoc(List fileList, String savepaths) {  
        if (fileList.size() == 0 || fileList == null) {  
            return false;  
        }  
        //打开word  
        ActiveXComponent app = new ActiveXComponent("Word.Application");//启动word  
        try {  
            // 设置word不可见  
            app.setProperty("Visible", new Variant(false));  
            //获得documents对象  
            Object docs = app.getProperty("Documents").toDispatch();  
            //打开第一个文件  
            Object doc = Dispatch  
                .invoke(  
                        (Dispatch) docs,  
                        "Open",  
                        Dispatch.Method,  
                        new Object[] { (String) fileList.get(0),  
                                new Variant(false), new Variant(true) },  
                        new int[3]).toDispatch();  
            //追加文件  
            for (int i = 1; i < fileList.size(); i++) {  
            	 String tempFile = (String)fileList.get(i);
                 if (tempFile.endsWith(".doc") || tempFile.endsWith(".docx")) {
                Dispatch.invoke(app.getProperty("Selection").toDispatch(),  
                    "insertFile", Dispatch.Method, new Object[] {  
                            (String) fileList.get(i), "",  
                            new Variant(false), new Variant(false),  
                            new Variant(false) }, new int[3]);  
                 }
            }  
            //保存新的word文件  
            Dispatch.invoke((Dispatch) doc, "SaveAs", Dispatch.Method,  
                new Object[] { savepaths, new Variant(1) }, new int[3]);  
            Variant f = new Variant(false);  
            Dispatch.call((Dispatch) doc, "Close", f);  
        } catch (Exception e) {  
            //throw new RuntimeException("合并word文件出错.原因:" + e);  
        	return false;
        } finally {  
            app.invoke("Quit", new Variant[] {});  
        }  
        return true;
    } 
    
}