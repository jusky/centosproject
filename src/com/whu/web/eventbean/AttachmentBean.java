package com.whu.web.eventbean;

public class AttachmentBean {

	//序号
	private String serialNum;
	//文件名
	private String fileName;
	//文件路径
	private String filePath;
	//扩展名
	private String extName;
	//预览文件路径
	private String swfPath;
	//文件大小
	private long fileSize;
	public String getSerialNum() {
		return serialNum;
	}
	public void setSerialNum(String serialNum) {
		this.serialNum = serialNum;
	}
	public long getFileSize() {
		return fileSize;
	}
	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}
	public String getSwfPath() {
		return swfPath;
	}
	public void setSwfPath(String swfPath) {
		this.swfPath = swfPath;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getExtName() {
		return extName;
	}
	public void setExtName(String extName) {
		this.extName = extName;
	}
}
