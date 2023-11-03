package com.itbank.listener;

import com.itbank.wersocketConfig.ChatComponent;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.connection.Message;
import org.springframework.data.redis.connection.MessageListener;
import org.springframework.data.redis.serializer.StringRedisSerializer;
import org.springframework.stereotype.Component;

@Slf4j
@Component
public class RedisMessageListener implements MessageListener {

    @Autowired
    private StringRedisSerializer serializer;

    @Override
    public void onMessage(Message message, byte[] pattern) {
        String username = serializer.deserialize(message.getBody());
        String receivedChannel = serializer.deserialize(message.getChannel());
        if(receivedChannel.equals("__keyevent@0__:expired")) { // 키가 만료되었다면
            String alert = username + "님의 사용시간이 만료되었습니다";
            log.info(alert);
            ChatComponent.convertAndSendToUser(username, "/queue/alert", alert);
        }
    }
}

