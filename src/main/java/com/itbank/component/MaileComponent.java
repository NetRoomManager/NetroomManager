package com.itbank.component;
import java.io.IOException;
import java.util.HashMap;
import java.util.Optional;
import java.util.Properties;
import java.util.Scanner;

import com.itbank.model.User;
import jakarta.mail.*;
import jakarta.mail.internet.AddressException;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
public class MaileComponent {

    private String host;
    private int port;
    private String serverId;
    private String serverPw;

    public MaileComponent(String host, int port, String serverId, String serverPw) {
        this.host = host;
        this.port = port;
        this.serverId = serverId;
        this.serverPw = serverPw;
        props = new Properties();
        props.put("mail.smtp.host",host);
        props.put("mail.smtp.port",port);
        props.put("mail.smtp.auth","true");
        props.put("mail.smtp.starttls.enable","true");
        props.put("mail.smtp.ssl.trust",host);
        System.out.println("mailComponent: " + props);
        System.out.println("mailComponent: " + serverId);
    }

    private Properties props;

    // classpath에서 특정 파일 불러오기
    // src/main/java
    // src/main/resources
    @Value("classpath:mailForm.html")
    private Resource mailForm;

    public int sendMimeMessage(HashMap<String, String> param) {
        Session mailSession = Session.getDefaultInstance(props, new Authenticator() {
            String un = serverId;
            String pw = serverPw;

            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(un,pw);
            }
        });
        mailSession.setDebug(true);

        Message message = new MimeMessage(mailSession);
        String tag = "";

        try {
            Scanner sc = new Scanner(mailForm.getInputStream(), "UTF-8");
            while(sc.hasNextLine()){
                tag += sc.nextLine();
            }
            sc.close();

            message.setFrom(new InternetAddress(serverId + "@gmail.com"));
            message.setRecipient(Message.RecipientType.TO,new InternetAddress(param.get("receiver")));
            message.setSubject(param.get("subject"));

            message.setContent(
                    String.format(tag, param.get("content")),
                    "text/html;charset=utf-8"
            );
            Transport.send(message);
            return 1;

        } catch (MessagingException | IOException e) {
            e.printStackTrace();
        }

        return 0;
    }

    // Id 찾기( name, email 일치시, email로 id 전송 )
    public int findUserId(HashMap<String, String> param, String userId) {
        Session mailSession = Session.getDefaultInstance(props, new Authenticator() {
            String un = serverId;
            String pw = serverPw;

            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(un, pw);
            }
        });
        mailSession.setDebug(true);

        Message message = new MimeMessage(mailSession);

        try {
            // HTML 템플릿을 수정합니다.
            String htmlContent = String.format(
                    "<fieldset style=\"padding: 10px; text-align: center;\">" +
                            "<h3>NetroomManager id는 [ <span style=\"color: blue;\">%s</span> ] 입니다</h3>" +
                            "</fieldset>",
                    userId
            );

            message.setFrom(new InternetAddress(serverId + "@gmail.com"));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(param.get("receiver")));
            message.setSubject(param.get("subject"));

            message.setContent(htmlContent, "text/html;charset=utf-8");
            Transport.send(message);
            return 1;
        } catch (MessagingException e) {
            e.printStackTrace();
        }

        return 0;
    }

    // password 찾기
    public int sendPw(HashMap<String, String> param) {
        Session mailSession = Session.getDefaultInstance(props, new Authenticator() {
            String un = serverId;
            String pw = serverPw;

            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(un, pw);
            }
        });
        mailSession.setDebug(true);

        Message message = new MimeMessage(mailSession);

        try {
            // HTML 템플릿을 수정합니다.
            String htmlContent = "<fieldset style=\"padding: 10px; text-align: center;\">\n" +
                    "<h3>\n" +
                    "NetroomManager password : [ <span style=\"color: blue;\">" + param.get("content") + "</span> ] 입니다\n" +
                    "</h3>\n" +
                    "</fieldset>";

            message.setFrom(new InternetAddress(serverId + "@gmail.com"));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(param.get("receiver")));
            message.setSubject(param.get("subject"));

            // HTML로 설정 (수정된 부분)
            message.setContent(
                    htmlContent,
                    "text/html;charset=utf-8"
            );
            Transport.send(message);
            return 1;

        } catch (MessagingException e) {
            e.printStackTrace();
        }

        return 0;
    }
}