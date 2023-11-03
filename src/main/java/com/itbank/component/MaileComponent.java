package com.itbank.component;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Properties;
import java.util.Scanner;


import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Component;

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
}