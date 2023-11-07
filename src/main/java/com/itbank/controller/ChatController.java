package com.itbank.controller;

import com.itbank.model.Message;
import com.itbank.wersocketConfig.ChatComponent;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import java.security.Principal;
import java.util.List;

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


    @GetMapping("/sync/{username}")
    @ResponseBody
    public List<Message> getMessages(Principal principal, @PathVariable String username) {
        System.out.println("test");
        return chatComponent.getMessages(principal.getName(), username);
    }




}
