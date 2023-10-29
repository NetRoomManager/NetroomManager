<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script>
	const socket = new WebSocket('ws://localhost:8080/websocket');

	// 웹소켓이 연결되었을 때 실행되는 로직
	socket.onopen = function() {
		console.log('웹소켓 연결 성공');

		// 채팅 메시지 전송 예시
		const message = {
			sender: '클라이언트1',
			content: '안녕하세요!'
		};
		socket.send(JSON.stringify(message));
	};

	// 서버로부터 메시지를 받았을 때 실행되는 로직
	socket.onmessage = function(event) {
		const message = JSON.parse(event.data);
		console.log('서버로부터 메시지 수신:', message);

		// 받은 메시지를 화면에 표시하는 로직 등을 추가할 수 있습니다.
	};

	// 웹소켓 연결이 종료되었을 때 실행되는 로직
	socket.onclose = function(event) {
		console.log('웹소켓 연결 종료:', event);
	};

</script>
</body>
</html>
