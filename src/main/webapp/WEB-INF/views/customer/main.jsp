	 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<!-- PC방 고객 메인 페이지 -->

<style>
/* 모달 창의 기본 스타일 */
.main_chat_modal {
	display: none;
	position: fixed;
	z-index: 10;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgba(0, 0, 0, 0.4);
}

/* 모달 컨텐츠의 스타일 */
.main_chat_modal_content {
	background-color: #fefefe;
	margin: 15% 0% 15% 60%;
	padding: 20px;
	border: 1px solid #888;
	width: 25%;
}

/* 닫기 버튼의 스타일 */
.chat_modal_close {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close:hover, .close:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}

.image-container {
	position: relative;
	display: inline-block;
}

.image-container img {
	display: block;
	width: 100%;
	height: auto;
	transition: filter 0.3s ease;
}

.image-container:hover img {
	filter: brightness(50%);
}

.text-overlay {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	color: white;
	font-size: 24px;
	font-weight: bold;
	opacity: 0;
	transition: opacity 0.3s ease;
}

.image-container:hover .text-overlay {
	opacity: 1;
}

.image-container2 {
	position: relative;
	display: inline-block;
}

.image-container2 img {
	display: block;
	width: 100%;
	height: auto;
	transition: filter 0.3s ease;
}

.image-container2:hover img {
	filter: brightness(50%);
}

.text-overlay2 {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	color: white;
	font-size: 12px;
	font-weight: bold;
	opacity: 0;
	transition: opacity 0.3s ease;
}

.image-container2:hover .text-overlay2 {
	opacity: 1;
}

/* 내 정보 modal 창 여닫기*/
.modal {
	display: none;
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0,0,0,0.7);
}

.modal-content {
	background-color: #fefefe;
	margin: 10% auto;
	padding: 20px;
	border: 1px solid #888;
	width: 350px;
	height: 600px;
	max-width: 400px;
}

.close {
	color: #aaaaaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
	cursor: pointer;
}

/* 모달 창을 닫는 스타일 */
.close:hover {
	color: #000;
}
/* 입력 필드 스타일 */
input[type="text"],
input[type="password"] {
	width: 100%;
	padding: 10px;
	margin: 5px 0;
}



.chat_box {
	overflow-y: auto;
	height: 500px;  /* 채팅창의 높이를 원하는 값으로 설정해주세요. */
}
.chat_message {
	margin: 10px;
}
.chat_message.from {
	text-align: right;
}
.chat_message.to {
	text-align: left;
}
</style>


<header class="position-fixed w-100 mx-auto">
	<div class="header_box">
		<div id="charge_btn" class="header_btn">
			<i class="fa-solid fa-hourglass-start"></i> &nbsp;&nbsp;&nbsp;
			<p>요금제 충전</p>
		</div>
		<div id="food_btn" class="header_btn">
			<i class="fa-solid fa-burger"></i> &nbsp;&nbsp;&nbsp;
			<p>먹거리 주문</p>
		</div>
		<div id="header_btn" class="header_btn">
			<i class="fa-solid fa-power-off"></i> &nbsp;&nbsp;&nbsp;
			<p id="main_close_btn" data-bs-toggle="modal"
			   data-bs-target="#end_of_user">
				사용종료</p>
		</div>
	</div>
	<!-- 모달 창 -->
<%--	<div class="modal fade" id="end_of_user" tabindex="-1" role="dialog"--%>
<%--		aria-labelledby="myModalLabel" aria-hidden="false">--%>
<%--		<div class="modal-dialog" role="document">--%>
<%--			<div class="modal-content">--%>
<%--				<div class="modal-body"  style="text-align:center">--%>
<%--					<p>컴퓨터를 종료하시겠습니까?</p>--%>
<%--					<p id="countdown">5</p>--%>
<%--				</div>--%>
<%--			</div>--%>
<%--		</div>--%>
<%--	</div>--%>
</header>

<!-- 시간정보 등등 -->
<div class="info" style="z-index: 3">
	<div class="title">
		<p class="p-0 mx-0 my-0">netroom ITBANK</p>
		<button id="btn_hidden">
			<i class="fa-solid fa-x" style="color: #ffffff; cursor: pointer;"></i>
		</button>
	</div>
	<div class="pc_number">
		<div class="seat_number">
			<p class="p-0 mx-0 my-0">
				no.<span>29</span>
			</p>
		</div>
		<a href="#">자리이동</a> <a href="#"> <i class="fa-solid fa-power-off"
			style="color: #ffffff;"></i> &nbsp;&nbsp;
			<p class="p-0 mx-0 my-0" id="header_close_btn">사용종료</p>
		</a>
	</div>

	<div class="username">
		<p class="p-0 mx-0 my-0">
			ID <span>${user.username}</span>
		</p>
		<p class="p-0 mx-0 my-0">회원정보</p>
	</div>
	<div class="time_wrap">
		<div class="start_date">
			<p class="p-0 mx-0 my-0">시작날짜</p>
			<p class="p-0 mx-0 my-0">${userLog.loginAt}</p>
		</div>
		<div class="usage_time">
			<p class="p-0 mx-0 my-0">사용시간</p>
			<p class="p-0 mx-0 my-0">${usingTime}</p>
		</div>
		<div class="remain_time">
			<p class="p-0 mx-0 my-0">남은시간</p>
			<p class="p-0 mx-0 my-0">${remainingTime}</p>
		</div>
	</div>
	<div class="consumption">
		<div class="food_order">
			<a href="#">먹거리 주문</a>
		</div>
		<div class="pc_ticket">
			<a href="#">PC방 이용권</a>
		</div>
		<div class="tire">
			<p class="p-0 mx-0 my-0">${user.tire}</p>
		</div>
		<div class="kakaopay">
			<a href="#"> <img src="/img/kakao-pay.png" alt="카카오페이">
			</a>
		</div>

	</div>
	<div class="service">
		<a href="#">호출</a> <a onclick="openChatModal(); getMessages(); msgDel();" style="color: #eee;">메시지</a>
		<a href="#">주문 목록</a> <a href="#">내 정보</a>
	</div>

	<!--  내 정보 모달  -->
	<div id="myModal" class="modal">
		<div class="modal-content">
			<span style="font-weight: bold;">내 정보 수정</span>
			<span class="close">&times;</span>
			<input type="text" id="name" placeholder="이름">
			<input type="text" id="id" placeholder="아이디">
			<form action="/action_page.php">
				<label for="birthday" style="font-weight: bold; ">생년월일</label>
				<input type="date" id="birthday" name="birthday" style="width: 200px; height: 35px;">
				<input type="submit" value="확인" style="width: 50px; height: 35px;">
			</form>
			<form action="/action_page.php" style="padding-bottom: 10px; padding-top: 10px;">
				  <input type="radio" id="html" name="fav_language" value="HTML">
				  <label for="html">남자</label>
				  <input type="radio" id="css" name="fav_language" value="CSS">
				  <label for="css">여자</label>
				<input type="submit" value="확인">
			</form>
			<input type="text" id="email" placeholder="이메일">
		</div>
	</div>


	<!-- 게임메뉴 -->
	<div class="game_menu_wrap">
		<div class="game_menu">
			<div>
				<img src="/img/game-menu01.ico" alt="냥코대전쟁" id="war_image">
				<p class="p-0 mx-0 my-0">냥코대전쟁</p>
			</div>
			<div>
				<img src="/img/game-menu02.ico" alt="로블록스" id="roblox_image">>
				<p class="p-0 mx-0 my-0">로블록스</p>
			</div>
			<div>
				<img src="/img/game-menu03.ico" alt="마피아42" id="mafia_image">
				<p class="p-0 mx-0 my-0">마피아42</p>
			</div>
			<div>
				<img src="/img/game-menu04.ico" alt="피파4M" id="fifa_image">
				<p class="p-0 mx-0 my-0">피파4M</p>
			</div>
			<div>
				<img src="/img/game-menu05.ico" alt="어몽어스" id="among_image">
				<p class="p-0 mx-0 my-0">어몽어스</p>
			</div>
			<div>
				<img src="/img/game-menu06.ico" alt="메이플스토리" id="maple_image">
				<p class="p-0 mx-0 my-0">메이플스토리</p>
			</div>
		</div>
		<div class="advertisement">
			<div class="main_advertisement">
				<div class="logoRight">
					<!-- Carousel -->
					<div id="main_ad" class="carousel slide" data-bs-ride="carousel">

						<!-- Indicators/dots -->
						<div class="carousel-indicators">
							<button type="button" data-bs-target="#main_ad"
								data-bs-slide-to="0" class="active"></button>
							<button type="button" data-bs-target="#main_ad"
								data-bs-slide-to="1"></button>
							<button type="button" data-bs-target="#main_ad"
								data-bs-slide-to="2"></button>
						</div>


						<!-- The slideshow/carousel -->
						<div class="carousel-inner">
							<div class="carousel-item active">
								<img src="/img/pc방 광고.jpg" alt="logo1" class="d-block"
									style="width: 345px; height: 315px;">
							</div>
							<div class="carousel-item">
								<img src="/img/pc방 광고2.jpg" alt="logo2" class="d-block"
									style="width: 345px; height: 315px;">
							</div>
						</div>



						<!-- Left and right controls/icons -->
						<button class="carousel-control-prev" type="button"
							data-bs-target="#main_ad" data-bs-slide="prev">
							<span class="carousel-control-prev-icon"></span>
						</button>
						<button class="carousel-control-next" type="button"
							data-bs-target="#main_ad" data-bs-slide="next">
							<span class="carousel-control-next-icon"></span>
						</button>
					</div>
				</div>
			</div>
			<div class="sub_advertisement">
				<img src="/img/nuguri.webp" alt="너굴맨"> <img
					src="/img/nuguri.webp" alt="너굴맨">
			</div>
		</div>
	</div>
	<div class="information">
		<a href="#">이용약관</a> <a href="#">개인정보처리방침</a> <a href="#">버전정보</a>
	</div>
</div>

<div class="position-fixed h-50 bg-secondary rounded"
	style="top: 40%; left: 10%; width: 60%">
	<div class="h-75">
		<div class="d-flex h-100">
			<div
					class="col-sm  text-white p-3 rounded mx-1 my-1 bg-primary  image-container"
					style="border: 1px solid black;">
				<img src="../img/lol.jpg" class="w-100" />
				<div class="text-overlay" onclick="openModal('인기게임')">인기게임</div>
			</div>

			<div
					class="col-sm  text-white p-3 rounded mx-1 my-1 bg-warning image-container"
					style="border: 1px solid black;">
				<img src="../img/rpg.jpg" class="w-100" />
				<div class="text-overlay">RPG</div>
			</div>
			<div
					class="col-sm  text-white p-3 rounded mx-1 my-1 bg-danger image-container"
					style="border: 1px solid black;">
				<img src="../img/starcraft.jpg" class="w-100" />
				<div class="text-overlay">CD게임</div>
			</div>
			<div
					class="col-sm   text-white p-3 rounded mx-1 my-1 bg-info image-container"
					style="border: 1px solid black;">
				<img src="../img/battleground.webp" class="w-100" />
				<div class="text-overlay">FPS게임</div>
			</div>
		</div>
	</div>
	<div class="d-flex h-25">
		<div id="aki"
			 class="col-sm bg-dark text-white p-3 rounded mx-1 my-1 image-container2">
			<img src="../img/archeage.jpg" class="w-100">
			<div class="text-overlay2">아키에이지</div>
		</div>
		<div id="item_mania"
			 class="col-sm bg-dark text-white p-3 rounded mx-1 my-1 image-container2">
			<img src="../img/itemmania.png " class="w-100">
			<div class="text-overlay2">아이템매니아</div>
		</div>
		<div id="item_bay"
			 class="col-sm bg-dark text-white p-3 rounded mx-1 my-1 image-container2">
			<img src="../img/itembay.jpg " class="w-100">
			<div class="text-overlay2">아이템베이</div>
		</div>
		<div id="cart"
			 class="col-sm bg-dark text-white p-3 rounded mx-1 my-1 image-container2">
			<img src="../img/kartrider.jpg " class="w-100">
			<div class="text-overlay2">카트라이더</div>
		</div>
		<div id="poe"
			 class="col-sm bg-dark text-white p-3 rounded mx-1 my-1 image-container2">
			<img src="../img/poe.png" class="w-100">
			<div class="text-overlay2">POE</div>
		</div>
		<div id="world_of"
			 class="col-sm bg-dark text-white p-3 rounded mx-1 my-1 image-container2">
			<img src="../img/worldofwarship.jpg" class="w-100">
			<div class="text-overlay2">월오브워쉽</div>
		</div>
		<div id="netflix"
			 class="col-sm bg-dark text-white p-3 rounded mx-1 my-1 image-container2">
			<img src="../img/netflix.jpg" class="w-100">
			<div class="text-overlay2">넷플릭스</div>
		</div>
	</div>
</div>

 <div id="alert" style="display: none;">새로운 메시지가 도착했습니다!</div>

<!-- 모달 창 -->
<div id="main_chat_modal" class="main_chat_modal">
	<div class="main_chat_modal_content rounded">
		<span>관리자에게 보낼 메시지</span>
		<h1 class="main_chat_modal_close" id="main_chat_modal_close"
			style="text-align: end;" onclick="closeChatModal()">&times;</h1>

		<!-- 채팅 인터페이스 -->
		<div id="chat_box"
			style="height: 300px; border: 1px solid #ccc; padding: 10px; overflow: auto;">
			<!-- 채팅 메시지가 여기에 표시됩니다 -->
		</div>


		<div class="d-flex">
			<input type="hidden" value="admin" id="to">
			<input class="input mt-1" type="text" id="message"
				placeholder="채팅 내용을 입력하세요" style="width: 80%">
			<button type="button" class="btn btn-primary mt-1 mx-3"
				style="width: 15%" onclick="send()">전송</button>
		</div>
	</div>
</div>

	 <script>
		 //모달 열기
		 function openModal(title) {
			 var modal = document.getElementById("myModal2");
			 var modalTitle = document.getElementById("modalTitle");

			 // 모달 제목 설정
			 modalTitle.innerText = title;

			 // 모달 내용 초기화 (기존 내용을 제거)
			 var modalContent = document.getElementById("modalContent");
			 modalContent.innerHTML = '';

			 // 16개의 이미지를 추가
			 for (var i = 1; i <= 16; i++) {
				 var image = document.createElement("img");
				 image.src = ""; // 이미지 URL을 추가
				 image.className = "image-class"; // 이미지에 클래스를 추가하여 스타일을 적용할 수 있습니다
				 modalContent.appendChild(image);
			 }

			 modal.style.display = "block";
		 }


		 // 모달 닫기
		 function closeModal() {
			 var modal = document.getElementById("myModal2");
			 modal.style.display = "none";
		 }

		 // 모달 창 외부를 클릭하면 모달 닫기 (선택 사항)
		 window.onclick = function(event) {
			 var modal = document.getElementById("myModal2");
			 if (event.target == modal) {
				 modal.style.display = "none";
			 }
		 };


		 // 이미지를 클릭하면 새 창에서 URL 열도록 JavaScript 코드
		 var imageElement = document.getElementById('mafia_image');
		 imageElement.addEventListener('click', function() {
			 var url = 'https://mafia42.com/#/';
			 window.open(url, '_blank'); // 이미지 클릭 시 URL을 새 창에서 열기
		 });

		 var imageElement = document.getElementById('war_image');
		 imageElement.addEventListener('click', function() {
			 var url = 'https://play.google.com/store/apps/details?id=jp.co.ponos.battlecatskr&hl=ko&gl=US';
			 window.open(url, '_blank');
		 })

		 var imageElement = document.getElementById('roblox_image');
		 imageElement.addEventListener('click', function() {
			 var url = 'https://www.roblox.com/';
			 window.open(url, '_blank');
		 })

		 var imageElement = document.getElementById('fifa_image');
		 imageElement.addEventListener('click', function() {
			 var url = 'https://fconline.nexon.com/main/index';
			 window.open(url, '_blank');
		 })

		 var imageElement = document.getElementById('among_image');
		 imageElement.addEventListener('click', function() {
			 var url = 'https://store.epicgames.com/ko/p/among-us';
			 window.open(url, '_blank');
		 })

		 var imageElement = document.getElementById('maple_image');
		 imageElement.addEventListener('click', function() {
			 var url = 'https://maplestory.nexon.com/Home/Main';
			 window.open(url, '_blank');
		 })

		 var imageElement = document.getElementById('aki');
		 imageElement.addEventListener('click', function() {
			 var url = 'https://game.naver.com/lounge/Archeage/home';
			 window.open(url, '_blank');
		 })

		 var imageElement = document.getElementById('item_mania');
		 imageElement.addEventListener('click', function() {
			 var url = 'http://www.itemmania.com/';
			 window.open(url, '_blank');
		 })

		 var imageElement = document.getElementById('item_bay');
		 imageElement.addEventListener('click', function() {
			 var url = 'https://www.itembay.com/?NaPm=ct%3Dlogy2uwa%7Cci%3Dcheckout%7Ctr%3Dds%7Ctrx%3Dnull%7Chk%3D9b0c5d6735a0d8ec7b908d6c4f23bccedc77d576';
			 window.open(url, '_blank');
		 })

		 var imageElement = document.getElementById('cart');
		 imageElement.addEventListener('click', function() {
			 var url = 'https://kartdrift.nexon.com/kartdrift/ko/event/20230914/intro';
			 window.open(url, '_blank');
		 })

		 var imageElement = document.getElementById('poe');
		 imageElement.addEventListener('click', function() {
			 var url = 'https://poe.game.daum.net/';
			 window.open(url, '_blank');
		 })

		 var imageElement = document.getElementById('world_of');
		 imageElement.addEventListener('click', function() {
			 var url = 'https://worldofwarships.asia/ko/?pub_id=worldofwarships&sid=SIDgTHN0GP1ic8l_V9eLxyDnMfWfgxGHB2l1pwnepxvzoIP7NfJOnxB80SdHsoLV8_EvceE1O9RNY5w2eaDY_D-tBDjrlblgAqpbraBANr4q_D2jo_yEid6psYPxo3kzZTogbv5sNPgjVSK&enctid=cwo75h2z9uz1&lpsn=WOWS+APAC+Portal&foris=1&teclient=1698915131924951153';
			 window.open(url, '_blank');
		 })

		 var imageElement = document.getElementById('netflix');
		 imageElement.addEventListener('click', function() {
			 var url = 'https://www.netflix.com/kr/';
			 window.open(url, '_blank');
		 })

		 // ====================================================================

		 //모달 열기
		 document.getElementById("my_info").addEventListener("click", function() {
			 var modal = document.getElementById("myModal");
			 modal.style.display = "block";
		 });

		 // 모달 닫기
		 document.getElementsByClassName("close")[0].addEventListener("click", function() {
			 var modal = document.getElementById("myModal");
			 modal.style.display = "none";
		 });

		 // 모달 외부 클릭 시 모달 닫기
		 window.addEventListener("click", function(event) {
			 var modal = document.getElementById("myModal");
			 if (event.target === modal) {
				 modal.style.display = "none";
			 }
		 });

		 const infoDiv = document.querySelector(".info");
		 const titleDiv = document.querySelector('.title');
		 const infoHeight = infoDiv.style.height;

		 const infoList = document.querySelectorAll('.info > div:not(.title)');
		 const hiddenBtn = document.getElementById('btn_hidden');
		 const modal = document.getElementById('main_chat_modal');

		 hiddenBtn.onclick = () => {
			 console.log('123');
			 infoList.forEach(div => {
				 console.log(div);
				 let cl = div.classList;
				 console.log(cl);
				 if(cl.contains('hidden')) {
					 div.classList.remove('hidden');
					 infoDiv.style.height = '700px';
				 } else {
					 div.classList.add('hidden');
					 infoDiv.style.height = '30px';
				 }
			 })
		 }

		 // 모달창 여는 함수
		 function openChatModal() {
			 console.log("123");
			 modal.style.display = 'inline-block';
		 }

		 function closeChatModal() {
			 modal.style.display = 'none';
		 }


		 /////////////////////////////////////////


	 </script>


<!-- javaScript -->
<script src="/js/script.js"></script>


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

	 <script>
		 window.addEventListener("DOMContentLoaded", function() {
			 const usingTimeElement = document.querySelector(".usage_time p:nth-child(2)");
			 const remainingTimeElement = document.querySelector(".remain_time p:nth-child(2)");

			 let usingTime = parseInt(usingTimeElement.textContent);
			 let remainingTime = parseInt(remainingTimeElement.textContent);

			 console.log(usingTimeElement);

			 setInterval(function() {
				 usingTime++;
				 remainingTime--;
				 usingTimeElement.textContent = formatTime(usingTime);
				 remainingTimeElement.textContent = formatTime(remainingTime);
			 }, 1000);

			 function formatTime(param) {
				 let hours = Math.floor(param / 3600);
				 let minutes = Math.floor((param % 3600) / 60);
				 let seconds = param % 60;

				 return hours + "시간 " + minutes + "분 " + seconds + "초";
			 }
		 });
	 </script>
	 <script>
		 const close_btn = document.getElementById('close_btn');
		 close_btn.addEventListener('click', function () {
			 if(confirm('정말 종료하시겠습니까?')) {
				 location.href='/auth/logout';
			 }
		 })
	 </script>



</body>
</html>