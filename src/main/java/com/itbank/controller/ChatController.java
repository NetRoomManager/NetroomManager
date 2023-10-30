package com.itbank.controller;

import com.itbank.model.ChatMessage;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

@Controller
public class ChatController {

    private final SimpMessagingTemplate messagingTemplate;

    public ChatController(SimpMessagingTemplate messagingTemplate) {
        this.messagingTemplate = messagingTemplate;
    }

    @MessageMapping("/enter/{roomId}")
    @SendTo("/broker/room/{roomId}")
    public ChatMessage sendMessage(ChatMessage chatMessage) {



        return chatMessage;
    }




}
