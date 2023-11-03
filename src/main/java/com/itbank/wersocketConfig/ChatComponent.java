package com.itbank.wersocketConfig;

import com.itbank.model.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;

@Component
public class ChatComponent {

    @Autowired
    private  SimpMessagingTemplate simpMessagingTemplate;

    private static SimpMessagingTemplate messagingTemplate;

    @PostConstruct
    private void initStatic() {
        messagingTemplate = this.simpMessagingTemplate;
    }


    public void convertAndSendToUser(String username, String path, Message message) {
        messagingTemplate.convertAndSendToUser(username, path, message);
    }

    public static void convertAndSendToUser(String username, String path, String alert) {
        messagingTemplate.convertAndSendToUser(username, path, alert);
    }
}
