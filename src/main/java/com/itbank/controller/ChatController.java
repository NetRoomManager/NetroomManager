package com.itbank.controller;

import com.itbank.model.Message;
import com.itbank.wersocketConfig.ChatComponent;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;
import java.util.Map;
import java.util.Set;

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

    @PostMapping("/notification")
    @ResponseBody
    public ResponseEntity<?> saveNotification(@RequestBody Map<String, String> notification) {
        chatComponent.saveNotification(notification.get("username"));
        return ResponseEntity.ok().build();
    }

    @GetMapping("/notification")
    @ResponseBody
    public ResponseEntity<?> getNotifications() {
        Set<Object> notifications = chatComponent.getNotifications();
        return ResponseEntity.ok(notifications);
    }

    @DeleteMapping("/notification/delete")
    @ResponseBody
    public ResponseEntity<?> deleteNotification(@RequestBody Map<String, String> notification) {
        chatComponent.deleteNotification(notification.get("username"));
        return ResponseEntity.ok().build();
    }




}
