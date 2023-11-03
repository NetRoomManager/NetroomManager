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
</head>
<body>

<p>사용자 : ${principal}</p>

<div>
    <label for="username">Username:</label>
    <input type="text" id="username">
</div>
<div>
    <label for="message">Message:</label>
    <input type="text" id="message">
    <button onclick="send()">Send</button>
</div>
<div id="response"></div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script>
    let stompClient = null;

    function connect() {
        let socket = new SockJS('/chat');
        stompClient = Stomp.over(socket);
        stompClient.connect({}, function(frame) {
            stompClient.subscribe('/user/queue/messages', function(messageOutput) {
                showMessageOutput(JSON.parse(messageOutput.body));
            });

            stompClient.subscribe('/user/queue/alert', function(alert) {
                console.log(JSON.parse(alert.body));
            });
        });
    }

    function send() {
        let from = document.getElementById('username').value;
        let text = document.getElementById('message').value;
        stompClient.send("/app/chat", {}, JSON.stringify({'username': from, 'content': text}));
    }

    function showMessageOutput(messageOutput) {
        let response = document.getElementById('response');
        response.innerHTML += messageOutput.username + ': ' + messageOutput.content + '<br>';
    }

    connect();
</script>
</body>
</html>
