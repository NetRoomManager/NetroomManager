package com.itbank.listener;

import com.itbank.wersocketConfig.ChatComponent;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.connection.Message;
import org.springframework.data.redis.connection.MessageListener;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.StringRedisSerializer;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

@Slf4j
@Component
public class RedisMessageListener implements MessageListener {

    @Autowired
    private StringRedisSerializer serializer;

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    @Override
    public void onMessage(Message message, byte[] pattern) {
        String key = serializer.deserialize(message.getBody());
        String receivedChannel = serializer.deserialize(message.getChannel());
        if(receivedChannel.equals("__keyevent@0__:expired")) { // 키가 만료되었다면

            // 키의 실제 값 얻기
            String username = key.split(" ")[0];
            String time = key.split(" ")[1];

            log.info(username);
            log.info(time);

            Map<String, String> msg = new HashMap<>();
            msg.put("msg", "시간만료");
            msg.put("time", time);

            ChatComponent.convertAndSendToUser(username, "/queue/alert", msg);
        }
    }
}

