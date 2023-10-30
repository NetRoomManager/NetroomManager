    package com.itbank.model;

    import lombok.Getter;
    import lombok.Setter;
    import org.springframework.web.socket.WebSocketSession;

    import java.util.HashSet;
    import java.util.Set;

    @Getter
    @Setter
    public class ChatMessage {

        private Set<WebSocketSession> sessions = new HashSet<>();
        private String from;
        private String content;
        private String roomId;

        @Override
        public String toString() {
            return "받은 메시지: " + from + content;
        }
    }
