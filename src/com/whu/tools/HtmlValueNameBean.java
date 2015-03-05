package com.whu.tools;

public class HtmlValueNameBean {
	//页面显示的名字(标签)
	  private String name = null;
	  //实际提交的值
	  private String value = null;;

	  /**
	   * 构造方法
	   * @param name String 名字
	   * @param value String 值
	   */
	  public HtmlValueNameBean(String name,String value){
	    this.name =name;
	    this.value =value;
	  }
	  public String getName(){
	    return name;
	  }
	  public void setName(String name){
	    this.name = name;
	  }

	  public String getValue(){
	    return value;
	  }
	  public void setValue(String value){
	    this.value = value;
	  }
	  /**
	   * 比较是否相等
	   * @param o Object
	   * @return boolean
	   */
	  public boolean equals(Object o){
	    HtmlValueNameBean tmp = (HtmlValueNameBean)o;
	    if(this.value.equals(tmp.getValue())){
	      return true;
	    }else{
	      return false;
	    }
	  }

}
