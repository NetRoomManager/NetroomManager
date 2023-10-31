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
	<li><a href="/auth/create_admin">관리자 생성하기</a></li>
	<li><a href="/admin/product">관리자 상품 관리</a></li>
</ul>

<!-- 메시지 입력 폼 -->

<p id="status">연결안됨</p>

<input type="text" id="room_id">
<button onclick="connect()">방 만들기</button>
<br><br>

<input type="text" id="message">
<button onclick="send()">보내기</button>

<div id="test"></div>


<!-- 메시지 출력 영역 -->
<div id="messageArea"></div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script>

	let socket;
	let stompClient;

	let roomId;


	function connect() {

		socket = new SockJS('/chat');
		stompClient = Stomp.over(socket);
		roomId = document.getElementById('room_id').value;

		stompClient.connect({}, (frame) => {


			const status = document.getElementById('status');
			status.innerText = '연결됨';


			console.log('Connected: ' + frame);

			// '/broker/receive' 주소를 구독하여 메시지를 받음
			stompClient.subscribe('/broker/room/' + roomId, onReceive);
		})

		function onReceive(chat){
			const param = JSON.parse(chat.body);
			const from = param.from;
			const content = param.content;

			const test = document.getElementById('test');
			const sender = document.createElement('p');
			sender.innerText = '<p>보낸사람: ' + from + '</p>';
			const msg = document.createElement('p');
			msg.innerText = '<p>메시지: ' + content + '</p>';
			test.appendChild(sender);
			test.appendChild(msg);
		}
	}

	function send() {
		const message = document.getElementById('message');

		stompClient.send('/app/enter', {}, JSON.stringify({
			from: '${username}',
			content: message.value,
			roomId: roomId
		}));
	}

</script>
</body>
</html>
