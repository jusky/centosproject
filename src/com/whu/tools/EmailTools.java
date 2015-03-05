package com.whu.tools;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Address;
import javax.mail.AuthenticationFailedException;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.Message.RecipientType;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

import com.whu.web.email.EmailBean;
import com.whu.web.email.EmailInfo;

/**
 * �����������ӡ������ʼ���
 * */
public class EmailTools {
	
	private Properties props;
	private Session session;
	
	public EmailTools()
	{
		props = new Properties();
		props.setProperty("mail.smtp.auth", "true");
		props.setProperty("mail.transport.protocol", "smtp");
		
		session = Session.getInstance(props);
		session.setDebug(false);
	}
	
	//������������
	public boolean TestConnection(EmailBean emailBean) throws Exception
	{
		String mailAddress = emailBean.getMailBoxAddress();
		String pwd = emailBean.getMailBoxPwd();
		String smtpPC = emailBean.getSmtpPC();
		String smtpPort = emailBean.getSmtpPort();

		Transport transport = session.getTransport();
		
		try {
			transport.connect(smtpPC, Integer.parseInt(smtpPort), mailAddress, pwd);
		} catch (AuthenticationFailedException e) {
			e.printStackTrace();
			DebugLog.WriteDebug(e);
			return false;
		}
		catch (Exception e) {
			e.printStackTrace();
			DebugLog.WriteDebug(e);
			return false;
		}
		return true;
	}
	/**
	 * 发送电子邮件
	 * @param emailInfo
	 * @param emailBean
	 * @throws Exception
	 */
	public boolean SendEmail(EmailInfo emailInfo, EmailBean emailBean)
	{
		try
		{
			String mailAddress = emailBean.getMailBoxAddress();
			String pwd = emailBean.getMailBoxPwd();
			String smtpPC = emailBean.getSmtpPC();
			String smtpPort = emailBean.getSmtpPort(); 
			
			String title = emailInfo.getTitle();
			String sendName = emailInfo.getSendName();
			String recvName = emailInfo.getRecvName();
			String csName = emailInfo.getCsName();
			String accessoryPath = emailInfo.getAccessory();
			String content = emailInfo.getContent();
			
			String allRecv = recvName + "," + csName;
			
			String[] allList, recvList, csList;
			int count = 0;
			String temp = "";
			String[] tempList;
			int flat = 0;
			String unionRecvName = "", unionCsName = "";
			if(allRecv != null && allRecv != "")
			{
				allList = allRecv.split(",");
				count += allList.length;
				
				recvList = recvName.split(",");
				csList = csName.split(",");
				
				Address[] addr = new Address[count];
				int i = 0, j = 0;
				for(i = 0; i < recvList.length; i++)
				{
					flat = recvList[i].indexOf("<");
					if(flat == -1 )
					{
						unionRecvName += recvList[i] + ",";
						temp = recvList[i];
					}
					else
					{
						tempList =  recvList[i].split("<");
						unionRecvName += MimeUtility.encodeText(tempList[0]) + "<" + tempList[1] + ",";
						temp = tempList[1];
						temp = temp.substring(0, temp.length() - 1);
						
					}
					if(temp != "")
					{
						addr[i] = new InternetAddress(temp);
					}
				}
				for(j = 0; j < csList.length; j++)
				{
					flat = csList[j].indexOf("<");
					if(flat == -1 )
					{
						unionCsName += csList[j] + ",";
						temp = csList[j];
					}
					else
					{
						tempList =  csList[j].split("<");
						unionCsName += MimeUtility.encodeText(tempList[0]) + "<" + tempList[1] + ",";
						temp = tempList[1];
						temp = temp.substring(0, temp.length() - 1);
						
					}
					if(temp != "")
					{
						addr[i] = new InternetAddress(temp);
						i++;
					}
				}
				
				unionRecvName = removeLastChar(unionRecvName);
				unionCsName = removeLastChar(unionCsName);
				
				/*
				Message msg = new MimeMessage(session);
				msg.setContent(content, "text/html;charset=gbk");
				msg.setSubject(title);
				msg.setFrom(new InternetAddress(sendName));
				
				msg.setRecipients(RecipientType.TO, InternetAddress.parse(unionRecvName));
				msg.setRecipients(RecipientType.CC, InternetAddress.parse(unionCsName));
				
				Transport transport = session.getTransport();
				transport.connect(smtpPC, Integer.parseInt(smtpPort), mailAddress, pwd);
				transport.sendMessage(msg, addr);
				transport.close();
				*/
				
				MimeMessage msg = new MimeMessage(session);
				msg.setFrom(new InternetAddress(sendName));
				msg.setSubject(title);
				msg.setRecipients(RecipientType.TO, InternetAddress.parse(unionRecvName));
				msg.setRecipients(RecipientType.CC, InternetAddress.parse(unionCsName));
				
				MimeMultipart msgMultipart = new MimeMultipart("mixed");
				msg.setContent(msgMultipart);
				
				
				MimeBodyPart emailContent = new MimeBodyPart();
				msgMultipart.addBodyPart(emailContent);
				
				File directory = new File(accessoryPath);
				if(!directory.isDirectory())
				{
					directory.mkdir();
				}
				File[] fileList = directory.listFiles();  //目录中的所有文件
				MimeBodyPart attch;
				DataSource ds;
				DataHandler dh;
				
		        String filePath = "";
	            for(File file : fileList){
                      if(!file.isFile())   //判断是不是文件
                      continue;
                      filePath = file.getAbsolutePath();
                      ds = new FileDataSource(filePath);
                      dh = new DataHandler(ds);
                      attch  = new MimeBodyPart();
                      attch.setDataHandler(dh);
      				  attch.setFileName(MimeUtility.encodeText(file.getName()));
      				  msgMultipart.addBodyPart(attch);
	            }

				MimeMultipart bodyMultipart = new MimeMultipart("alternative");
				emailContent.setContent(bodyMultipart);
				MimeBodyPart htmlPart= new MimeBodyPart();
				bodyMultipart.addBodyPart(htmlPart);

				htmlPart.setContent(content, "text/html;charset=gbk");
				
				msg.saveChanges();
				
				Transport transport = session.getTransport();
								
				transport.connect(smtpPC, Integer.parseInt(smtpPort), mailAddress, pwd);
				transport.sendMessage(msg, addr);
				transport.close();
				/*
				for(File file : fileList){
                    if(!file.isFile())   //判断是不是文件
                    continue;
                    file.delete();
				}
				*/
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
			DebugLog.WriteDebug(e);
			return false;
		}
		return true;
	}
	//�Ƴ��ַ�����һ���ַ�
	private String removeLastChar(String str)
	{
		if(str != "")
		{
			str = str.substring(0, str.length() - 1);
		}
		return str;
	}

	public static void SendEmail() throws MessagingException
	{
		//���û���
		Properties props = new Properties();
		//֪ͨ�������˻���Ҫ��֤
		props.setProperty("mail.smtp.auth", "true");
		//����Э��
		props.setProperty("mail.transport.protocol", "smtp");
		//�����ʼ�������
		props.setProperty("mail.host", "smtp.163.com");
		Session session = Session.getInstance(props);
		//���û�������봫��session
		/*
		Session session = Session.getInstance(props, 
				new Authenticator()
				{
					protected PasswordAuthentication getPasswordAuthentication()
					{
						return new PasswordAuthentication("wch_cs@163.com", "lvww3951345");
					}
				}
		);
		*/
		//��ӡ������Ϣ
		session.setDebug(true);
		
		//��д�ʼ�����
		Message msg = new MimeMessage(session);
		//���ʹ��ı�����
		//msg.setText("Hello!");
		//����html����
		msg.setContent("<span style='color:red'>��ð���", "text/html;charset=UTF-8");
		msg.setSubject("��ã�");
		msg.setFrom(new InternetAddress( "wch_cs@163.com"));
		//�����ռ��ˡ������ˡ�������
		msg.setRecipients(RecipientType.TO, InternetAddress.parse("wch_cs@163.com"));
		//msg.setRecipients(RecipientType.CC, InternetAddress.parse("137547627@qq.com"));
		msg.setRecipients(RecipientType.BCC, InternetAddress.parse("137547627@qq.com"));
		//Transport�ľ�̬send�����������ӡ����͡��ر��Զ�ִ��
		//Transport.send(msg);
		
		//�����ʼ�
		Transport transport = session.getTransport();
		transport.connect("smtp.163.com", 25, "wch_cs@163.com", "lvww3951345");
		//û����дĿ�ĵ�ַ�����msg��Ѱ��
		transport.sendMessage(msg, new Address[]{new InternetAddress("lvww_konghen@163.com"), new InternetAddress("137547627@qq.com")});
		transport.close();
	}
}
