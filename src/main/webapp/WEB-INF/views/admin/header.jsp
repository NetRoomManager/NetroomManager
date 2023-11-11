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
.notification {
	position: fixed;
	right: 20px;
	bottom: 20px;
	padding: 10px;
	background-color: #f44336;
	color: white;
	cursor: pointer;
}
.from {
	text-align: right;
	background-color: #d2d2d2;
	border-radius: 10px;
	margin: 10px;
	padding: 10px;
}

.to {
	text-align: left;
	background-color: #eaeaea;
	border-radius: 10px;
	margin: 10px;
	padding: 10px;
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


<%--채팅 모달--%>
<div class="modal fade" id="seat_chat" aria-hidden="true"
	 data-bs-backdrop="static" data-bs-keyboard="false"
	 aria-labelledby="seat_chatLabel2" tabindex="-1"
	 style="z-index: 1056">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalToggleLabel2">좌석번호</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="chat_modal_content rounded">
					<span>name에게 보낼 메시지</span>
					<!-- 채팅 인터페이스 -->
					<div id="chat_box"
						 style="height: 300px; border: 1px solid #ccc; padding: 10px; overflow: auto;">
						<!-- 채팅 메시지가 여기에 표시됩니다 -->
					</div>
					<div class="d-flex">
						<input class="input mt-1" type="text" id="message"
							   placeholder="채팅 내용을 입력하세요" style="width: 80%">
						<input type="hidden" id="to">
						<button type="button" class="btn btn-primary mt-1 mx-3"
								style="width: 15%" onclick="send()">전송</button>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-primary" data-bs-target="#seat_select"
						data-bs-toggle="modal" data-bs-dismiss="modal">상태</button>
				<button class="btn btn-danger" data-bs-target="#exampleModalToggle"
						data-bs-toggle="modal" data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>


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

			getMessages();
		}
	}

	function showMessageOutput(messageOutput) {



		let chatRoomDiv = document.getElementById('chat_box');

		let to = document.getElementById('to').value;
		// 'to' 값이 빈 문자열인 경우 'messageOutput.from' 값을 'to'로 설정
		if (!to) {
			to = messageOutput.from;
			document.getElementById('to').value = to;
		}

		if (!chatRoomDiv) {
			alert("채팅방을 찾지 못했습니다.");
		} else {

			// 받는사람 아이디 설정
			// const to = document.getElementById('to');
			// to.value=messageOutput.from;
			// console.log('to1: ' + messageOutput.from);

			// 새로운 메시지 추가
			let messageDiv = document.createElement('div');
			messageDiv.className = 'chat_message ' + (messageOutput.from === from ? 'from' : 'to');
			messageDiv.innerHTML = messageOutput.from + ': ' + messageOutput.message + ' (' + messageOutput.time + ')';
			chatRoomDiv.appendChild(messageDiv);

			// 스크롤을 채팅창의 가장 아래로 내립니다.
			chatRoomDiv.scrollTop = chatRoomDiv.scrollHeight;

			// 모달창 열기
			let modal = document.getElementById('seat_chat');
			let modalInstance = bootstrap.Modal.getInstance(modal); // 기존 모달 인스턴스 가져오기

			// 모달 인스턴스가 없는 경우 새로 생성
			if (modalInstance === null) {
				modalInstance = new bootstrap.Modal(modal);
				getMessages();
			}


			// 모달이 이미 열려있지 않은 경우에만 show 메소드 호출
			if (!modalInstance._isShown) {
				// 같은 유저로부터 받은 이전 알림 제거
				let prevNotification = document.querySelector('.notification[data-user="' + messageOutput.from + '"]');
				if (prevNotification) {
					prevNotification.remove();
				}

				// 새로운 메시지 알림 생성
				let notification = document.createElement('div');
				notification.className = 'notification';
				notification.setAttribute('data-user', messageOutput.from); // 유저 정보를 속성으로 추가
				notification.innerHTML = messageOutput.from + '님으로부터 새로운 메시지가 도착했습니다.';
				notification.onclick = function() {
					modalInstance.show();
					let currentNotification = document.querySelector('.notification[data-user="' + messageOutput.from + '"]');
					if (currentNotification) {
						currentNotification.remove();
					}
				};

				// AJAX 요청을 이용해 알림을 서버에 저장
				$.ajax({
					url: '/notification',  // 요청을 보낼 서버의 URL
					headers: {
						'Content-Type': 'application/json'
					},
					type: 'POST',  // HTTP 메소드
					data: JSON.stringify({ 'username':  messageOutput.from }),  // 수정된 부분
					success: function(response) {  // 응답이 성공적으로 도착했을 때 실행할 콜백 함수
						console.log('Notification saved successfully');
					},
					error: function(request, status, error) {  // 요청이 실패했을 때 실행할 콜백 함수
						console.error('Error: ', error);
					}
				});


				document.body.appendChild(notification);

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
		// showMessageOutput(msg);  // 이 부분을 주석 처리하거나 삭제

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
					console.log(data);
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

	function switchChatRoom(userId) {
		// 채팅 내역 초기화
		let chatRoomDiv = document.getElementById('chat_box');
		chatRoomDiv.innerHTML = '';

		// 수신자 정보 업데이트
		let toInput = document.getElementById('to');
		toInput.value = userId;

		console.log('to2: ' + userId);


		// 새로운 유저의 채팅 내역 로드
		getMessages();

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

	window.onload = function() {
		// Bootstrap 모달 인스턴스를 가져옵니다.
		let modal = document.getElementById('seat_chat');
		let modalInstance = bootstrap.Modal.getInstance(modal);

		// AJAX 요청을 이용해 서버에서 모든 알림을 불러옴
		$.ajax({
			url: '/notification',
			type: 'GET',
			success: function(usernames) {
				usernames.forEach(function(username) {
					// 관리자로부터 온 메시지는 건너뛰기
					if (username === 'admin') {
						return;
					}

					let notification = document.createElement('div');
					notification.className = 'notification';
					notification.setAttribute('data-user', username);
					notification.innerHTML = username + '님으로부터 새로운 메시지가 도착했습니다.';
					notification.onclick = function() {
						document.getElementById('to').value = username;

						// 모달 인스턴스가 없는 경우 새로 생성
						if (modalInstance === null) {
							modalInstance = new bootstrap.Modal(modal);
							getMessages();
						}

						// 모달이 이미 열려있지 않은 경우에만 show 메소드 호출
						if (!modalInstance._isShown) {
							modalInstance.show();
							$.ajax({
								url: '/notification/delete',
								type: 'DELETE',
								data: JSON.stringify({ 'username': username }),
								contentType: 'application/json'
							});
							notification.remove();
						}
					};
					document.body.appendChild(notification);
				});
			},
			error: function(request, status, error) {
				console.error('Error: ', error);
			}
		});

	};





	connect();

</script>