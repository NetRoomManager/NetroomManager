package com.itbank.controller;

import com.itbank.model.Message;
import com.itbank.wersocketConfig.ChatComponent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.stereotype.Controller;

@Controller
public class ChatController {

    @Autowired
    private ChatComponent chatComponent;

    @MessageMapping("/chat")
    public void send(@Payload Message message) {
        chatComponent.convertAndSendToUser(message.getUsername(), "/queue/messages", message);
    }



}
