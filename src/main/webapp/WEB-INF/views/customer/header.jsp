<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cpath" value="${pageContext.request.contextPath }" />

<!-- 세션에서 SecurityContext를 가져옵니다. -->
<c:set var="securityContext" value="${sessionScope.SPRING_SECURITY_CONTEXT}" />

<!-- SecurityContext에서 Authentication 객체를 가져옵니다. -->
<c:set var="authentication" value="${securityContext.authentication}" />

<!-- Authentication 객체에서 Principal(사용자) 정보를 가져옵니다. -->
<c:set var="principal" value="${authentication.principal}" />

<!-- Principal에서 사용자의 이름을 가져옵니다. -->
<c:set var="username" value="${principal.username}" />


<!-- 고객 헤더 -->
<!DOCTYPE html>
<html lang="ko">
<head>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="/css/main.css" rel="stylesheet">


<meta charset="UTF-8">
<title>관리자화면</title>
<style type="text/css">
html {
	font-family: "AppleSDGothicNeoR00", "Noto Sans KR", "맑은 고딕";
}

.hidden {
	display: none;
}

/* ---- reset ---- */
body {
	margin: 0;
	font: normal 75% Arial, Helvetica, sans-serif;
}

canvas {
	display: block;
	vertical-align: bottom;
} /* ---- particles.js container ---- */
#particles-js {
	position: absolute;
	width: 100%;
	height: 100%;
	background-color: #28455f;
	background-image: url("");
	background-repeat: no-repeat;
	background-size: cover;
	background-position: 50% 50%;
} /* ---- stats.js ---- */
.count-particles {
	background: #000022;
	position: absolute;
	top: 48px;
	left: 0;
	width: 80px;
	color: #13E8E9;
	font-size: .8em;
	text-align: left;
	text-indent: 4px;
	line-height: 14px;
	padding-bottom: 2px;
	font-family: Helvetica, Arial, sans-serif;
	font-weight: bold;
}

.js-count-particles {
	font-size: 1.1em;
}

#stats, .count-particles {
	-webkit-user-select: none;
	margin-top: 5px;
	margin-left: 5px;
}

#stats {
	border-radius: 3px 3px 0 0;
	overflow: hidden;
}

.count-particles {
	border-radius: 0 0 3px 3px;
}
</style>
</head>
<body style="height: 90%; overflow: hidden;">
	<div id="particles-js" style="z-index: -1"></div>
	<nav class="navbar navbar-expand-sm bg-info navbar-dark">
		<div class="container-fluid">
			<ul class="navbar-nav">
				<li class="nav-item"><a class="nav-link active"
					href="${cpath }/">Home</a></li>
				<li class="nav-item"><a class="nav-link"
					href="${cpath }/customer/customer_main.jsp">유저 메인페이지</a></li>
				<li class="nav-item"><a class="nav-link"
					href="${cpath }/customer/customer_order.jsp">유저 주문 페이지</a></li>
				<li class="nav-item"><a class="nav-link"
					href="${cpath }/customer/error.jsp">에러페이지</a></li>
			</ul>
		</div>
	</nav>

	<!-- particles.js / 배경 -->
	<script
		src="http://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js"></script>
	<script>
		particlesJS("particles-js", {
			"particles" : {
				"number" : {
					"value" : 400,
					"density" : {
						"enable" : true,
						"value_area" : 800
					}
				},
				"color" : {
					"value" : "#ffffff"
				},
				"shape" : {
					"type" : "polygon",
					"stroke" : {
						"width" : 0,
						"color" : "#000000"
					},
					"polygon" : {
						"nb_sides" : 5
					},
					"image" : {
						"src" : "img/github.svg",
						"width" : 100,
						"height" : 100
					}
				},
				"opacity" : {
					"value" : 0.5,
					"random" : true,
					"anim" : {
						"enable" : false,
						"speed" : 1,
						"opacity_min" : 0.1,
						"sync" : false
					}
				},
				"size" : {
					"value" : 10,
					"random" : true,
					"anim" : {
						"enable" : false,
						"speed" : 40,
						"size_min" : 0.1,
						"sync" : false
					}
				},
				"line_linked" : {
					"enable" : false,
					"distance" : 500,
					"color" : "#ffffff",
					"opacity" : 0.4,
					"width" : 2
				},
				"move" : {
					"enable" : true,
					"speed" : 6,
					"direction" : "bottom",
					"random" : false,
					"straight" : false,
					"out_mode" : "out",
					"bounce" : false,
					"attract" : {
						"enable" : false,
						"rotateX" : 600,
						"rotateY" : 1200
					}
				}
			},
			"interactivity" : {
				"detect_on" : "canvas",
				"events" : {
					"onhover" : {
						"enable" : true,
						"mode" : "repulse"
					},
					"onclick" : {
						"enable" : true,
						"mode" : "repulse"
					},
					"resize" : true
				},
				"modes" : {
					"grab" : {
						"distance" : 400,
						"line_linked" : {
							"opacity" : 0.5
						}
					},
					"bubble" : {
						"distance" : 407.5924075924076,
						"size" : 11.988011988011989,
						"duration" : 0.3,
						"opacity" : 1,
						"speed" : 3
					},
					"repulse" : {
						"distance" : 200,
						"duration" : 0.4
					},
					"push" : {
						"particles_nb" : 4
					},
					"remove" : {
						"particles_nb" : 2
					}
				}
			},
			"retina_detect" : true
		});
		let count_particles, stats, update;
		stats = new Stats;
		stats.setMode(0);
		stats.domElement.style.position = 'absolute';
		stats.domElement.style.left = '0px';
		stats.domElement.style.top = '0px';
		document.body.appendChild(stats.domElement);
		count_particles = document.querySelector('.js-count-particles');
		update = function() {
			stats.begin();
			stats.end();
			if (window.pJSDom[0].pJS.particles
					&& window.pJSDom[0].pJS.particles.array) {
				count_particles.innerText = window.pJSDom[0].pJS.particles.array.length;
			}
			requestAnimationFrame(update);
		};
		requestAnimationFrame(update);
		;
		document.getElementById('close_btn').addEventListener(
				'click',
				function() {
					const countdownElement = document
							.getElementById('countdown');
					let countdownValue = 5; // 5초 카운트다운

					// 카운트다운 함수
					function startCountdown() {
						countdownElement.textContent = countdownValue;
						countdownValue--;

						if (countdownValue < -1) {
							// 시간이 다 되면 모달을 닫고 메시지 표시
							$('#quit_modal').modal('hide');
							alert('컴퓨터가 종료됩니다.');
						} else if (countdownValue === -1) {
							location.href = "${cpath}/auth/login_form.jsp";
						} else {
							setTimeout(startCountdown, 1000);
						}
					}

					startCountdown(); // 카운트다운 시작
				});
	</script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- 폰트어썸 -->
	<script src="https://kit.fontawesome.com/a68b6c4b30.js"
		crossorigin="anonymous"></script>

	<!-- Swiper JS / 이미지 넘기기-->
	<script
		src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

	<!-- particles.js / 배경 -->
	<script
		src="http://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js"></script>

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
				stompClient.subscribe('/user/queue/alert', function(param) {
					const message = JSON.parse(param.body);
					let msg = message.msg;
					let time = message.time;
					location.href='/auth/logout?time='+time;
					alert(msg);
				});

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