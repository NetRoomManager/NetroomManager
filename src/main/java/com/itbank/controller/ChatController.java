package com.itbank.controller;

import com.itbank.model.Message;
import com.itbank.wersocketConfig.ChatComponent;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.stereotype.Controller;

@Controller
@Slf4j
public class ChatController {

    @Autowired
    private ChatComponent chatComponent;

    @MessageMapping("/chat")
    public void send(@Payload Message message) {
        log.info(message.toString());
        chatComponent.saveMessage(message);
        chatComponent.convertAndSendToUser(message.getTo(), "/queue/messages", message);
    }




}
