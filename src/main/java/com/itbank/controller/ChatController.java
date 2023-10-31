package com.itbank.controller;

import com.itbank.model.ChatMessage;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

@Controller
public class ChatController {

    private final SimpMessagingTemplate messagingTemplate;

    public ChatController(SimpMessagingTemplate messagingTemplate) {
        this.messagingTemplate = messagingTemplate;
    }

//    // stompClient.send
//    @MessageMapping("/enter")
//
//    // 구독링크
//    @SendTo("/broker/room/{roomId}")
//    public ChatMessage sendMessage(ChatMessage chatMessage) {
//
//        System.out.println(chatMessage.toString());
//
//        return chatMessage;
//    }

    @MessageMapping("/enter")
    public void sendMessage(ChatMessage chatMessage) {
        System.out.println(chatMessage.toString());
        messagingTemplate.convertAndSend("/broker/room/" + chatMessage.getRoomId(), chatMessage);
    }


}
