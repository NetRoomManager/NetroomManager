package com.itbank.handler;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class MyWebSocketHandler extends TextWebSocketHandler {

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        // 클라이언트와의 연결이 성립되었을 때 실행되는 로직
        System.out.println("웹소켓 연결 성공");
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        // 클라이언트로부터 메시지를 수신받았을 때 실행되는 로직
        String payload = message.getPayload();
        System.out.println("클라이언트로부터 메시지 수신: " + payload);

        // 받은 메시지를 처리하고, 필요한 로직을 수행한 후, 다시 클라이언트로 메시지를 전송할 수 있습니다.
        // 예를 들어, Redis에 메시지를 저장하거나 다른 클라이언트에게 메시지를 브로드캐스트할 수 있습니다.

        // 메시지 전송 예시
        ObjectMapper objectMapper = new ObjectMapper();
        String response = objectMapper.writeValueAsString("서버에서 보내는 메시지");
        session.sendMessage(new TextMessage(response));
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        // 클라이언트와의 연결이 종료되었을 때 실행되는 로직
        System.out.println("웹소켓 연결 종료: " + status);
    }
}

