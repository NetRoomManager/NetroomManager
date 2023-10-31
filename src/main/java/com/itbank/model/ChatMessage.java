    package com.itbank.model;

    import lombok.Getter;
    import lombok.Setter;

    @Getter
    @Setter
    public class ChatMessage {

        private String from;
        private String content;
        private String roomId;


        @Override
        public String toString() {
            return "받은 메시지: " + from + content;
        }
    }
