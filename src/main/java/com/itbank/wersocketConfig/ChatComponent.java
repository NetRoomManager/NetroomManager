package com.itbank.wersocketConfig;

import com.itbank.model.Message;
import com.itbank.model.OrderList;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.util.*;

@Component
@Slf4j
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

    public void saveOrder(OrderList orderList) {
        // 레디스 키 생성
        String key = "order:" + orderList.getId();

        // 메시지 저장
        redisTemplate.opsForList().rightPush(key, orderList);
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

    public void convertAndSendToUser(String admin, String path, HashMap<String, Object> stringObjectHashMap) {
        messagingTemplate.convertAndSendToUser(admin, path, stringObjectHashMap);
    }
}
