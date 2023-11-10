<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath" value="${pageContext.request.contextPath }"/>

<!-- 세션에서 SecurityContext를 가져옵니다. -->
<c:set var="securityContext" value="${sessionScope.SPRING_SECURITY_CONTEXT}"/>

<!-- SecurityContext에서 Authentication 객체를 가져옵니다. -->
<c:set var="authentication" value="${securityContext.authentication}"/>

<!-- Authentication 객체에서 Principal(사용자) 정보를 가져옵니다. -->
<c:set var="principal" value="${authentication.principal}"/>

<!-- Principal에서 사용자의 이름을 가져옵니다. -->
<c:set var="username" value="${principal.username}"/>

<!DOCTYPE html>
<html lang="ko">
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<meta charset="UTF-8">
<title>관리자화면</title>
<style type="text/css">
html {
	font-family: "AppleSDGothicNeoR00", "Noto Sans KR", "맑은 고딕";
	overflow: hidden;
}

#menu_bar {
	background-color: #ffa500
}

#menu_bar>a {
	color: #ffffff;
}

#menu_bar>a.active {
	background-color: #FF8339;
}

        .hidden {
            display: none;
        }

.hover_element {
	cursor: pointer;
}

.hover_element:hover {
	cursor: pointer;
}
</style>
<body>
<%--	<nav class="navbar navbar-expand-sm bg-info navbar-dark">--%>
<%--		<div class="container-fluid">--%>
<%--			<ul class="navbar-nav">--%>
<%--				<li class="nav-item"><a class="nav-link active"--%>
<%--					href="${cpath }/">Home</a></li>--%>
<%--				<li class="nav-item"><a class="nav-link"--%>
<%--					href="${cpath }/admin/seat">좌석관리</a></li>--%>
<%--				<li class="nav-item"><a class="nav-link"--%>
<%--					href="${cpath }/admin/product">상품관리</a></li>--%>
<%--				<li class="nav-item"><a class="nav-link"--%>
<%--					href="${cpath }/admin/productsales">매출관리</a></li>--%>
<%--				<li class="nav-item"><a class="nav-link"--%>
<%--					href="${cpath }/admin/ticket">이용권관리</a></li>--%>
<%--				<li class="nav-item"><a class="nav-link"--%>
<%--					href="${cpath }/admin/user">회원관리</a></li>--%>
<%--				<li class="nav-item"><a class="nav-link"--%>
<%--					href="${cpath }/admin/order">주문관리</a></li>--%>
<%--			</ul>--%>
<%--		</div>--%>
<%--	</nav>--%>
<nav id="menu_bar" class="nav nav-pills flex-column py-3 text-center"
	 style="position: absolute; height: 100%;">
	<a class="nav-link py-3"></a>
	<a class="nav-link py-3"></a>
	<a class="nav-link py-3 ${currentPage eq 'order' ? 'active' : ''}" href="${cpath }/admin/order">주문</a>
	<a class="nav-link py-3 ${currentPage eq 'product' ? 'active' : ''}" href="${cpath }/admin/product">재고</a>
	<a class="nav-link py-3 ${currentPage eq 'productsales' ? 'active' : ''}" href="${cpath }/admin/productsales">매출</a>
	<a class="nav-link py-3 ${currentPage eq 'user' ? 'active' : ''}" href="${cpath }/admin/user">회원</a>
	<a class="nav-link py-3 ${currentPage eq 'seat' ? 'active' : ''}" href="${cpath }/admin/seat">좌석</a>
	<a class="nav-link py-3 ${currentPage eq 'ticket' ? 'active' : ''}" href="${cpath }/admin/ticket">이용권</a>
</nav>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script>

	const from = '${username}';
	let stompClient = null;

	function openChatRoom(username) {
		let chatRoomDiv = document.getElementById('chat_box');
		if (!chatRoomDiv) {
			alert("채팅방을 찾지 못했습니다.");
		} else {
			// 채팅창 생성
			let chatInput = document.getElementById('message');
			if (!chatInput) {
				alert("채팅 입력창을 찾지 못했습니다.");
			} else {
				// 전송 버튼 생성
				let sendButton = document.createElement('button');
				sendButton.innerText = 'Send';

				// 전송 버튼 클릭 이벤트 핸들러
				sendButton.onclick = function() {
					let message = chatInput.value;
					send(username, message);
					chatRoomDiv.innerHTML += from + ': ' + message + ' (' + getCurrentTime() + ')<br>';
				};
			}
		}
	}

	function showMessageOutput(messageOutput) {
		let chatRoomDiv = document.getElementById('chat_box');
		if (!chatRoomDiv) {
			alert("채팅방을 찾지 못했습니다.");
		} else {
			// 새로운 메시지 추가
			let messageDiv = document.createElement('div');
			messageDiv.className = 'chat_message ' + (messageOutput.from === from ? 'from' : 'to');
			messageDiv.innerHTML = messageOutput.from + ': ' + messageOutput.message + ' (' + messageOutput.time + ')';
			chatRoomDiv.appendChild(messageDiv);

			// 스크롤을 채팅창의 가장 아래로 내립니다.
			chatRoomDiv.scrollTop = chatRoomDiv.scrollHeight;

			// 모달창이 열려있지 않을 때만 알림을 띄웁니다.
			if (modal.style.display !== 'inline-block') {
				document.getElementById('alert').style.display = 'block';
			}
		}
	}

	function msgDel() {
		document.getElementById('alert').style.display = 'none';
	}




	function connect() {
		let socket = new SockJS('/chat');
		stompClient = Stomp.over(socket);

		stompClient.connect({}, function(frame) {

			stompClient.subscribe('/user/queue/messages', function(messageOutput) {
				showMessageOutput(JSON.parse(messageOutput.body));
			});

			stompClient.subscribe('/user/queue/order', function (orderList) {
				addOrderCard(JSON.parse(orderList.body));
			})
		});
	}

	function send(to, message) {
		if (!to) {
			to = document.getElementById('to').value;
		}

		if (!message) {
			message = document.getElementById('message').value;
		}

		const msg = {
			'from': from,
			'message': message,
			'to': to,
			'time': getCurrentTime()
		};
		stompClient.send("/app/chat", {}, JSON.stringify(msg));

		// 메시지를 보낸 후에 화면에 최신 메시지를 출력합니다.
		showMessageOutput(msg);

		document.getElementById('message').value = '';
		document.getElementById('message').focus();
	}

	function getMessages() {
		// 상대방의 아이디를 'to' 입력창으로부터 가져옵니다.
		let to = document.getElementById('to').value;

		// Fetch API를 사용하여 서버로부터 메시지를 가져옵니다.
		fetch('/sync/' + to)
				.then(response => response.json())
				.then(data => {
					// 서버로부터 받은 메시지를 시간 순으로 정렬합니다.
					data.sort((a, b) => (a.time > b.time) ? 1 : ((b.time > a.time) ? -1 : 0));

					// chat_box 내용을 초기화합니다.
					let chatRoomDiv = document.getElementById('chat_box');
					chatRoomDiv.innerHTML = '';

					// 모든 메시지를 화면에 출력합니다.
					for (let i = 0; i < data.length; i++) {
						showMessageOutput(data[i]);
					}
				})
				.catch(error => console.error('Error:', error));
	}

	connect();
</script>