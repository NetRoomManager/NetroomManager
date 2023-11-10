<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<!-- 상품관리 페이지 -->

<style>
#menu_bar {
	background-color: #ffa500
}

#menu_bar>a {
	color: #ffffff;
}

#product_update table>tbody>tr>th {
	padding-top: 15px;
}
</style>

<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav me-auto mb-2 mb-lg-0 pt-1">
			<li class="nav-item"><a class="nav-link active navbar-brand"
				aria-current="page" href="${cpath}/">NetRoom</a></li>
		</ul>
		<ul class="navbar-nav">
			<li class="nav-item pe-2">
				<button type="button" class="btn btn-light" data-bs-container="body"
					data-bs-toggle="popover" data-bs-placement="bottom"
					data-bs-content="test"
					style="-bs-btn-padding-y: .25rem; - -bs-btn-padding-x: .75em; - -bs-btn-font-size: 1.15rem;">
					<svg width="20" height="20" viewBox="0 0 20 20" fill="none"
						xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 relative"
						preserveAspectRatio="none">
                            <path fill-rule="evenodd"
							clip-rule="evenodd"
							d="M5.46335 6.82247C5.17954 6.82247 4.95008 6.58557 4.98808 6.30431C5.28388 4.11461 6.91244 2.5 9.78004 2.5C12.5925 2.5 14.4888 4.20082 14.4888 6.51914C14.4888 8.19829 13.6579 9.37912 12.2516 10.2349C10.8773 11.0583 10.4832 11.6324 10.4832 12.7483V12.9091C10.4832 13.1852 10.2593 13.4091 9.98316 13.4091H8.7718C8.49805 13.4091 8.2752 13.189 8.27184 12.9152L8.26725 12.5424C8.21399 11.0149 8.86385 10.0399 10.3234 9.15162C11.6124 8.36079 12.0705 7.73246 12.0705 6.61664C12.0705 5.39248 11.1224 4.49332 9.66285 4.49332C8.35848 4.49332 7.46502 5.20111 7.21313 6.35946C7.15721 6.61661 6.94421 6.82247 6.68105 6.82247H5.46335ZM9.37002 17.5C10.1478 17.5 10.7388 16.908 10.7388 16.1364C10.7388 15.3647 10.1478 14.7727 9.37002 14.7727C8.61302 14.7727 8.01157 15.3647 8.01157 16.1364C8.01157 16.908 8.61302 17.5 9.37002 17.5Z"
							fill="black"></path>
                            </svg>
				</button>
			</li>
			<li class="nav-item pe-2">
				<button type="button" class="btn btn-light"
					style="-bs-btn-padding-y: .25rem; - -bs-btn-padding-x: .75rem; - -bs-btn-font-size: 1.15rem;">
					<svg width="20" height="20" viewBox="0 0 20 20" fill="none"
						xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 relative"
						preserveAspectRatio="none">
                                <path fill-rule="evenodd"
							clip-rule="evenodd"
							d="M10 3.74999C6.54822 3.74999 3.75 6.54821 3.75 9.99999C3.75 13.4518 6.54822 16.25 10 16.25C13.4518 16.25 16.25 13.4518 16.25 9.99999C16.25 9.0682 16.0465 8.18565 15.6821 7.39291C15.538 7.07928 15.6753 6.70817 15.989 6.564C16.3026 6.41984 16.6737 6.55723 16.8179 6.87086C17.256 7.82403 17.5 8.88437 17.5 9.99999C17.5 14.1421 14.1421 17.5 10 17.5C5.85786 17.5 2.5 14.1421 2.5 9.99999C2.5 5.85786 5.85786 2.49999 10 2.49999V3.74999Z"
							fill="black"></path>
                                <path
							d="M10 5.58279V0.667193C10 0.402244 10.309 0.257507 10.5126 0.427123L13.4619 2.88492C13.6118 3.00986 13.6118 3.24013 13.4619 3.36506L10.5126 5.82286C10.309 5.99248 10 5.84774 10 5.58279Z"
							fill="black"></path>
                              </svg>
				</button>
			</li>
		</ul>
	</div>

</nav>

<!-- 좌석 시간 추가, 상태  Modal -->
<div class="modal fade" id="seat_detail" aria-hidden="true"
	 data-bs-backdrop="static" data-bs-keyboard="false"
	 aria-labelledby="seat_detailLabel" tabindex="-1">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">좌석정보[<span id="modal_seat_id"></span>]</h4>
				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<form action="#add_update">
					<div class="input-group mb-3">
						<select class="form-select" id="can_use" name="seat_state" >
							<option selected value="0">----좌석상세----</option>
							<option value="1">사용가능</option>
							<option value="2">사용중</option>
							<option value="3">예약석</option>
							<option value="4">사용불가</option>
						</select>
					</div>
					<!-- 사용중인 좌석인 경우에는 -->
					<div class="input-group mb-3">
						<select class="form-select" id="add_hour" name="hour">
							<option selected value="0">----시간 추가하기----</option>
							<option value="1">1시간 추가</option>
							<option value="2">2시간 추가</option>
							<option value="3">3시간 추가</option>
							<option value="4">4시간 추가</option>
							<option value="5">5시간 추가</option>
							<option value="6">6시간 추가</option>
						</select>
					</div>
					<button class="btn btn-success" type="button" id="changeSeat"
							data-bs-id=""
					>수정하기</button>
				</form>
			</div>
			<!-- Modal footer -->
			<div class="modal-footer">
				<button class="btn btn-primary" data-bs-target="#seat_chat"
						data-bs-toggle="modal" data-bs-dismiss="modal">채팅창</button>
				<button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>



<%--채팅 모달--%>

<div class="modal fade" id="seat_chat" aria-hidden="true"
	 data-bs-backdrop="static" data-bs-keyboard="false"
	 aria-labelledby="seat_chatLabel2" tabindex="-1">
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
					<div id="chatBox"
						 style="height: 300px; border: 1px solid #ccc; padding: 10px; overflow: auto;">
						<!-- 채팅 메시지가 여기에 표시됩니다 -->
					</div>
					<div class="d-flex">
						<input class="input mt-1" type="text" id="chatInput"
							   placeholder="채팅 내용을 입력하세요" style="width: 80%">
						<button type="button" class="btn btn-primary mt-1 mx-3"
								style="width: 15%" onclick="sendMessage()">전송</button>
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

<script>

	var popoverTriggerList = [].slice.call(document
			.querySelectorAll('[data-bs-toggle="popover"]'))
	var popoverList = popoverTriggerList.map(function(popoverTriggerEl) {
		return new bootstrap.Popover(popoverTriggerEl)
	})

</script>




<%-- 좌석 --%>
<div class="container pt-4 d-flex" >
	<c:forEach var="i" begin="1" end="2">
		<div class="w-50  d-flex flex-wrap" >
			<c:forEach var="seat" items="${seatList}" begin="${(i-1)*12}" end="${i*12-1}">
				<c:choose>
					<c:when test="${seat.seatState == 1 }">
						<c:set var="bgColor" value="bg-primary"/>
						<c:set var="stateCmt" value="사용가능"/>
					</c:when>
					<c:when test="${seat.seatState == 2 }">
						<c:set var="bgColor" value="bg-secondary"/>
						<c:set var="stateCmt" value="사용중"/>
					</c:when>
					<c:when test="${seat.seatState == 3 }">
						<c:set var="bgColor" value="bg-warning"/>
						<c:set var="stateCmt" value="예약석"/>
					</c:when>
					<c:when test="${seat.seatState == 4 }">
						<c:set var="bgColor" value="bg-danger"/>
						<c:set var="stateCmt" value="사용불가"/>
					</c:when>
				</c:choose>
				<div class="card ${bgColor} text-white mx-3 mt-3"
					 style="width: 25%; height: 25%;" data-bs-toggle="modal"
					 data-bs-target="#seat_detail"
					 data-bs-id="${seat.seatId}"
					 data-bs-userid="${seat.user_id}"
					 onclick="setModalSeatId(this)">
					<div class="seat_id card-header">좌석번호[ ${seat.seatId} ]</div>
					<div class="seat_remain_time card-body">
						<pre>남은시간: </pre>
						<pre>${seat.remainingTime}</pre>
						<pre>${seat.username}</pre>
					</div>
					<div class="card-footer">
							${stateCmt}
					</div>
				</div>
			</c:forEach>

		</div>
	</c:forEach>

</div>
<script>
	let selectedSeat = null; // 선택한 카드 정보를 저장할 변수
	const canUseSelect = document.getElementById('can_use');
	const addHourSelect = document.getElementById('add_hour');


	function setModalSeatId(card) {
		if (card) {
			selectedSeat = {
				seatId: card.getAttribute('data-bs-id'),
				userId: card.getAttribute('data-bs-userid')
			};
			const modalSeatId = document.getElementById('modal_seat_id');
			modalSeatId.textContent = selectedSeat.seatId;
			console.log('seatId: ' + selectedSeat.seatId);

			// '수정하기' 버튼에 data-bs-id 속성 설정
			const changeSeatButton = document.getElementById('changeSeat');
			changeSeatButton.setAttribute('data-bs-id', selectedSeat.seatId);

			canUseSelect.disabled = false;
			addHourSelect.disabled = true;
			addHourSelect.value = '0';
			canUseSelect.value = '0';
			if (selectedSeat.userId) {
				// user_id가 있는 경우에는 canUseSelect 변경을 막음
				canUseSelect.disabled = true;
				canUseSelect.value = '2'; // 예를 들어, 사용중으로 설정
				addHourSelect.disabled = false;
			} else {
				// user_id가 없는 경우에는 canUseSelect 변경 가능
				canUseSelect.disabled = false;
				addHourSelect.value = '0'; // 시간 추가하기의 기본값 설정
			}
		}
	}

	const changeSeat = document.getElementById('changeSeat');
	changeSeat.addEventListener('click', changeSeatStatus);

	function changeSeatStatus(event) {
		if (selectedSeat === null) {
			return;
		}
		const seatId = event.target.getAttribute('data-bs-id')
		const canUse = canUseSelect.value;
		const addHour = addHourSelect.value;
		const changeSeat = document.getElementById('changeSeat');
		const changeSeatID = changeSeat.getAttribute('data-bs-id');
		console.log('changeSeatID : ' + changeSeatID);
		const seat = selectedSeat.seatId;
		const userId = selectedSeat.userId;
		console.log('userId: ' + userId);
		console.log('seat: ' + seat);
		console.log('seatId: ' + seatId);

		console.log('canUse' + canUse)
		console.log('addHour' + addHour)

		const cards = document.querySelectorAll('.card');
		let selectedCard = null; // 선택된 카드를 저장할 변수

		cards.forEach(card => {
			if (card.getAttribute('data-bs-id') === changeSeatID) {
				selectedCard = card; // 선택된 카드를 변수에 할당
			}
		});
		if (selectedCard) {
			console.log('card 있음' + selectedCard)
			switch (canUse) {
				case '1':
					console.log(seat)
					selectedCard.classList.remove('bg-secondary', 'bg-warning', 'bg-danger')
					selectedCard.classList.add('bg-primary')
					selectedCard.querySelector('.card-footer').textContent = '사용가능'
					break;
				case '2':
					console.log(seat)
					selectedCard.classList.remove('bg-primary', 'bg-waring', 'bg-danger')
					selectedCard.classList.add('bg-secondary')
					selectedCard.querySelector('.card-footer').textContent = '사용중'
					break;
				case '3':
					console.log(seat)
					selectedCard.classList.remove('bg-secondary', 'bg-primary', 'bg-danger')
					selectedCard.classList.add('bg-warning')
					selectedCard.querySelector('.card-footer').textContent = '예약석'
					break;
				case '4':
					console.log(seat)
					selectedCard.classList.remove('bg-secondary', 'bg-primary', 'bg-warning')
					selectedCard.classList.add('bg-danger')
					selectedCard.querySelector('.card-footer').textContent = '사용불가'
					break;
			}
			const formData = new FormData();


			formData.append('seat_state', canUse);
			formData.append('hour', addHour);
			formData.append('seatId', seatId);
			console.log('seat_state', canUse)

			console.log('hour', addHour)
			console.log('seatId', seatId)
			console.log('console')
			fetch('/admin/add_update', {
				method: 'POST',
				body: formData
			})
					.then(resp => {
						if (resp.ok) {
							console.log('폼 데이터 전송이 성공하였습니다.')
							location.reload();
						} else {
							console.error('폼 데이터 전송이 실패하였습니다.')
						}
					})
					.catch(error => {
						console.error('오류가 발생하였습니다', error)
					})

		}





	}


</script>

</body>
</html>