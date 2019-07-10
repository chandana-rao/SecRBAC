package com.secrbac.mail;

import java.util.List;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
public class SendMail {
	private static final String SMTP_HOST_NAME = "smtp.sendgrid.net";
	private static final String SMTP_AUTH_USER = System.getenv("SENDGRID_USERNAME");
	private static final String SMTP_AUTH_PWD = System.getenv("SENDGRID_PASSWORD");

	public static void send(List<String> to, String subject, String htmlContent) {
		try {
			Properties props = new Properties();
			props.put("mail.transport.protocol", "smtp");
			props.put("mail.smtp.host", SMTP_HOST_NAME);
			props.put("mail.smtp.port", 587);
			props.put("mail.smtp.auth", "true");

			Authenticator auth = new SMTPAuthenticator();
			Session mailSession = Session.getDefaultInstance(props, auth);

			Transport transport = mailSession.getTransport();

			MimeMessage message = new MimeMessage(mailSession);

			Multipart multipart = new MimeMultipart("alternative");

			BodyPart bodyPart = new MimeBodyPart();
			bodyPart.setContent(htmlContent, "text/html");
			multipart.addBodyPart(bodyPart);

			message.setContent(multipart);
//		  
			message.setFrom(new InternetAddress("project.secrbac@gmail.com"));  
			message.setSubject(subject);

			message.addRecipient(Message.RecipientType.TO, new InternetAddress(to.get(0)));

			transport.connect();
			transport.sendMessage(message, message.getRecipients(Message.RecipientType.TO));
			transport.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private static class SMTPAuthenticator extends javax.mail.Authenticator {
		public PasswordAuthentication getPasswordAuthentication() {
			String username = SMTP_AUTH_USER;

			String password = SMTP_AUTH_PWD;

			return new PasswordAuthentication(username, password);
		}

	}

}
