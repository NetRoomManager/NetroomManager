package com.itbank.wersocketConfig;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.*;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

    @Override
    public void configureMessageBroker(MessageBrokerRegistry config) {
        // MessageMapping으로 받는 주소
        config.setApplicationDestinationPrefixes("/app");

        // STOMP 메시지를 처리할 주소 prefix 설정
        config.enableSimpleBroker("/broker");
    }

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        registry.addEndpoint("/chat")
                // 모든 주소 허용
                .setAllowedOriginPatterns("*")
                // SockJS 사용
                .withSockJS();
    }
}
