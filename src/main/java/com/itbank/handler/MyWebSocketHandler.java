package com.itbank.handler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.itbank.config.UserPrincipal;
import com.itbank.model.ChatMessage;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.util.Collection;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

public class MyWebSocketHandler extends TextWebSocketHandler {

    // 1. 사용자 식별자와 WebSocket 세션 매핑
    private Map<String, WebSocketSession> userSessions = new ConcurrentHashMap<>();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {

        // 쿼리스트링으로 전달한 유저아이디를 불러옴
        String username = Objects.requireNonNull(session.getUri()).getQuery().split("=")[1];

        // 유저아이디를 세션을 매핑
        userSessions.put(username, session);

        System.out.println("웹소켓 연결 성공: " + username);
        System.out.println("현재 세션: " + userSessions);
    }


    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        ObjectMapper objectMapper = new ObjectMapper();

        // 클라이언트로부터 메시지를 수신받았을 때 실행되는 로직
        String payload = message.getPayload();
        ChatMessage chatMessage = objectMapper.readValue(payload, ChatMessage.class);

        System.out.println("클라이언트로부터 메시지 수신: " + payload);

        // 받은 메시지를 처리하고, 필요한 로직을 수행한 후, 다시 클라이언트로 메시지를 전송할 수 있습니다.
        // 예를 들어, Redis에 메시지를 저장하거나 다른 클라이언트에게 메시지를 브로드캐스트할 수 있습니다.

        String receiver = chatMessage.getReceiver();
        WebSocketSession receiverSession = userSessions.get(receiver);

        // 객체를 JsonString으로 변환
        String response = objectMapper.writeValueAsString(chatMessage);

        // receiver의 세션으로 메시지를 반환
        receiverSession.sendMessage(new TextMessage(response));
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        // 클라이언트와의 연결이 종료되었을 때 실행되는 로직

        // 사용자 이름을 찾아서 맵에서 제거
        userSessions.entrySet().removeIf(entry -> entry.getValue().equals(session));

        System.out.println("웹소켓 연결 종료: " + status);
    }
}

