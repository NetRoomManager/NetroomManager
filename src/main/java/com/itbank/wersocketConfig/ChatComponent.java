package com.itbank.wersocketConfig;

import com.itbank.model.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.util.Arrays;
import java.util.Collections;
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
        // 'from'과 'to'를 오름차순으로 정렬
        List<String> names = Arrays.asList(message.getFrom(), message.getTo());
        Collections.sort(names);

        // 레디스 키 생성
        String key = "chat:" + names.get(0) + ":" + names.get(1);

        // 메시지 저장
        redisTemplate.opsForList().rightPush(key, message);

    }

    public List<Message> getMessages(String currentUser, String otherUser) {
        // 'currentUser'와 'otherUser'를 오름차순으로 정렬
        List<String> names = Arrays.asList(currentUser, otherUser);
        Collections.sort(names);

        // 레디스 키 생성
        String key = "chat:" + names.get(0) + ":" + names.get(1);

        // 메시지 불러오기
        return redisTemplate.opsForList().range(key, 0, -1);
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
