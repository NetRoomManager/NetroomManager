<%--
  Created by IntelliJ IDEA.
  User: uk
  Date: 10/31/23
  Time: 11:42 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 세션에서 SecurityContext를 가져옵니다. -->
<c:set var="securityContext" value="${sessionScope.SPRING_SECURITY_CONTEXT}" />

<!-- SecurityContext에서 Authentication 객체를 가져옵니다. -->
<c:set var="authentication" value="${securityContext.authentication}" />

<!-- Authentication 객체에서 Principal(사용자) 정보를 가져옵니다. -->
<c:set var="principal" value="${authentication.principal}" />

<!-- Principal에서 사용자의 이름을 가져옵니다. -->
<c:set var="username" value="${principal.username}" />
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
</head>
<body>

<p>사용자 : ${principal}</p>

<div>
    <label for="to">Username:</label>
    <input type="text" id="to">
</div>
<div>
    <label for="message">Message:</label>
    <input type="text" id="message">
    <button onclick="send()">Send</button>
</div>
<div id="response"></div>

<div id="chat-room-${username}" title="Chat with ${username}" style="display: none;">
    <div id="chat-log-${username}" style="height: 200px; border: 1px solid #ccc; padding: 10px; margin-bottom: 10px; overflow-y: scroll;"></div>
    <input id="chat-input-${username}" type="text" style="width: 80%; height: 50px;">
    <button onclick="send('${username}', document.getElementById('chat-input-${username}').value)">Send</button>
</div>


<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script>

    const from = '${username}';
    let stompClient = null;

    function openChatRoom(username) {
        let chatRoomDiv = document.getElementById('chat-room-' + username);
        if (!chatRoomDiv) {
            chatRoomDiv = document.createElement('div');
            chatRoomDiv.id = 'chat-room-' + username;
            document.body.appendChild(chatRoomDiv);

            // 채팅창 생성
            let chatLogDiv = document.createElement('div');
            chatLogDiv.id = 'chat-log-' + username;
            chatRoomDiv.appendChild(chatLogDiv);

            // 입력 필드 생성
            let chatInput = document.createElement('input');
            chatInput.id = 'chat-input-' + username;
            chatRoomDiv.appendChild(chatInput);

            // 전송 버튼 생성
            let sendButton = document.createElement('button');
            sendButton.innerText = 'Send';
            chatRoomDiv.appendChild(sendButton);

            // 전송 버튼 클릭 이벤트 핸들러
            sendButton.onclick = function() {
                let message = chatInput.value;
                send(username, message);
                chatLogDiv.innerHTML += from + ': ' + message + ' (' + getCurrentTime() + ')<br>';
            };

            // jQuery UI dialog로 초기화
            $(chatRoomDiv).dialog({
                autoOpen: false,
                width: 400,
                buttons: {
                    "Close": function() {
                        $(this).dialog("close");
                    }
                }
            });
        }
        // 채팅창 열기
        $(chatRoomDiv).dialog("open");
    }

    function showMessageOutput(messageOutput) {
        let chatRoomDiv = document.getElementById('chat-room-' + messageOutput.from);
        if (!chatRoomDiv) {
            openChatRoom(messageOutput.from);
            chatRoomDiv = document.getElementById('chat-room-' + messageOutput.from);
        }

        let chatLogDiv = document.getElementById('chat-log-' + messageOutput.from);
        chatLogDiv.innerHTML += messageOutput.from + ': ' + messageOutput.message + ' (' + messageOutput.time + ')<br>';
        chatLogDiv.scrollTop = chatLogDiv.scrollHeight;  // 스크롤을 맨 아래로 이동

        // 유저의 채팅방이 닫혀 있다면 다시 열어줌
        if ($(chatRoomDiv).dialog('isOpen') === false) {
            $(chatRoomDiv).dialog('open');
        }
    }


    function connect() {
        let socket = new SockJS('/chat');
        stompClient = Stomp.over(socket);
        stompClient.connect({}, function(frame) {
            stompClient.subscribe('/user/queue/messages', function(messageOutput) {
                showMessageOutput(JSON.parse(messageOutput.body));
            });
        });
    }

    function send(to, message) {
        if (!to) {
            to = document.getElementById('to').value;
        }

        if (!message) {
            message = document.getElementById('message').value;
        }

        stompClient.send("/app/chat", {}, JSON.stringify({
            'from': from,
            'message': message,
            'to': to,
            'time': getCurrentTime()
        }));
    }




    function getCurrentTime() {
        let current = new Date();
        let year = current.getFullYear();
        let month = current.getMonth() + 1;
        let date = current.getDate();
        let hours = current.getHours();
        let minutes = current.getMinutes();
        let seconds = current.getSeconds();

        // 1자리 수를 2자리 수로 바꾸기
        month = (month < 10) ? '0' + month : month;
        date = (date < 10) ? '0' + date : date;
        hours = (hours < 10) ? '0' + hours : hours;
        minutes = (minutes < 10) ? '0' + minutes : minutes;
        seconds = (seconds < 10) ? '0' + seconds : seconds;

        return year + '-' + month + '-' + date + 'T' + hours + ':' + minutes + ':' + seconds;
    }



    connect();
</script>
</body>
</html>
