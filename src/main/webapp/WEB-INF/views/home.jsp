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

<!-- username을 출력합니다. -->
<p>사용자 : ${principal}</p>


<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!
</h1>

<P>  The time on the server is ${serverTime}. </P>


<ul>
	<li><a href="/auth/login">로그인</a></li>
	<li><a href="/auth/logout">로그아웃</a></li>
	<li><a href="/auth/buyTicket">티켓구매</a></li>
</ul>

<!-- 메시지 입력 폼 -->
<input type="text" id="receiverInput" placeholder="받는사람 입력하세요" required>
<input type="text" id="messageInput" placeholder="메시지를 입력하세요" required>
<button onclick="sendMessage()">전송</button>

<!-- 메시지 출력 영역 -->
<div id="messageArea"></div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script>
	const socket = new WebSocket('ws://localhost:8080/websocket?username=' + btoa(${username}));

	// 웹소켓이 연결되었을 때 실행되는 로직
	socket.onopen = function() {
		console.log('웹소켓 연결 성공');
	};

	// 서버로부터 메시지를 받았을 때 실행되는 로직
	socket.onmessage = function(event) {
		const message = JSON.parse(event.data);
		message.receiver = atob(message.receiver);
		message.sender = atob(message.sender);
		console.log('서버로부터 메시지 수신:', message);

		// 받은 메시지를 화면에 표시하는 로직
		const messageElement = document.createElement('p');
		messageElement.textContent = message.content;
		document.getElementById('messageArea').appendChild(messageElement);
	};

	// 웹소켓 연결이 종료되었을 때 실행되는 로직
	socket.onclose = function(event) {
		console.log('웹소켓 연결 종료:', event);
	};

	// 메시지 전송 함수
	function sendMessage() {
		const messageInput = document.getElementById('messageInput');
		const receiverInput = document.getElementById('receiverInput');

		const sender = '${username}'; // You may need to get the actual username here
		const receiver = receiverInput.value;
		const messageContent = messageInput.value;

		// Base64로 인코딩
		const encodedSender = btoa(sender);
		const encodedReceiver = btoa(receiver);

		const message = {
			sender: encodedSender,
			receiver: encodedReceiver,
			message: messageContent
		};

		socket.send(JSON.stringify(message));
		messageInput.value = '';
	}
</script>
</body>
</html>
