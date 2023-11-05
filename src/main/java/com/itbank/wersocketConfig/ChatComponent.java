package com.itbank.wersocketConfig;

import com.itbank.model.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.util.List;
import java.util.Map;

@Component
public class ChatComponent {

    @Autowired
    private  SimpMessagingTemplate simpMessagingTemplate;

    private static SimpMessagingTemplate messagingTemplate;

    @Autowired
    private RedisTemplate<String, Message> redisTemplate;

    public void saveMessage(Message message) {
        redisTemplate.opsForList().rightPush(message.getTo(), message);
    }

    public List<Message> getMessages(String username) {
        return redisTemplate.opsForList().range(username, 0, -1);
    }

    @PostConstruct
    private void initStatic() {
        messagingTemplate = this.simpMessagingTemplate;
    }


    public void convertAndSendToUser(String username, String path, Message message) {
        messagingTemplate.convertAndSendToUser(username, path, message);
    }

    public static void convertAndSendToUser(String username, String path, Map<String, String> msg) {
        messagingTemplate.convertAndSendToUser(username, path, msg);
    }
}
