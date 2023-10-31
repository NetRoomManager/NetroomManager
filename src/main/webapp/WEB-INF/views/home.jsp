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
