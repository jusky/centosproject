package com.whu.tools;


import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;

import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.usermodel.Bookmark;
import org.apache.poi.hwpf.usermodel.Range;



public class POIHWPFHelper {
	
	
    public void fillBookmarks(String[] bookmarks, String[] fillValues, String file) {
    	try{
    		InputStream in = new FileInputStream(file);
 	    	final HWPFDocument doc = new HWPFDocument(in);
	    	
	    	for (int i=0; i<doc.getBookmarks().getBookmarksCount(); i++) {
	    		final Bookmark bookmark = doc.getBookmarks().getBookmark(i);
	    		if(bookmark.getName() !=null){
	    			for(int j=0; j<bookmarks.length; j++) {
	    				if(bookmark.equals(bookmarks[j])) {
	    					Range range = new Range(bookmark.getStart(), bookmark.getEnd(), doc);
	    					if(range.text().length()>0)
	    						range.replaceText(fillValues[j], false);
	    					else
	    						range.insertAfter(fillValues[j]);
	    					break;
	    				}
	    			}
	    			
	    		}
	    	}
	    	OutputStream out = new FileOutputStream(file);
	    	doc.write(out);
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
     }
    
    public void fillBookmark(String bookmarks, String fillValues, String file) {
    	try{
    		InputStream in = new FileInputStream(file);
 	    	final HWPFDocument doc = new HWPFDocument(in);
	    	for (int i=0; i<doc.getBookmarks().getBookmarksCount(); i++) {
	    		final Bookmark bookmark = doc.getBookmarks().getBookmark(i);
	    		if(bookmark.getName() !=null){
	    			if(bookmark.getName().equals(bookmarks)) {
	    				Range range = new Range(bookmark.getStart(), bookmark.getEnd(), doc);
	    			/*	if(range.text().length()>0)
	    					range.replaceText(fillValues, false);
	    				else {
	    					range.insertBefore(fillValues);
	    				} */
	    				range.insertBefore(fillValues);
	    				break;
	    			}
	    		}
	    	}
	    	OutputStream out = new FileOutputStream(file);
	    	doc.write(out);
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
     }

    public static void main(String[] argv) {
    	POIHWPFHelper poiHelper = new POIHWPFHelper();
    	String file = "/home/apache-tomcat-8.0.9/webapps/KXJJBDXW/attachment/dcbg.doc";
    	poiHelper.fillBookmark("facultyAdvice", "tHellsdf:\r\n\t  是否是\r\n", file);
    	poiHelper.fillBookmark("facultyAdvice", "tHellsdf:\r\n\t  是否是\r\n", file);
    	poiHelper.fillBookmark("facultyAdvice", "tHellsdf:\r\n\t  是否是\r\n", file);
    }

}
