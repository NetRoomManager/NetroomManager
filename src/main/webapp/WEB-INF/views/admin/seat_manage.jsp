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
	<div class="modal fade" id="productUpdate" data-bs-backdrop="static"
		 data-bs-keyboard="false" tabindex="-1"
		 aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<form action="">
					<div class="modal-header">
						<h3 class="modal-title">상품등록</h3>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
					</div>
					<div class="modal-body container">
						<div class="row justify-content-center align-items-center mb-3">
							<div class="col-6 text-center">
								<img id="preview" class="img-thumbnail mb-2"
									 src="../img/1422005677144.png" alt="예시 이미지"
									 style="max-width: 200px; max-height: 200px;"> <input
									class="form-control form-control-sm" id="image" name="image"
									accept="image/*" type="file">
							</div>
						</div>
						<table class="table table-borderless">
							<tbody>
							<tr>
								<th>제품/이용권</th>
								<td><select class="form-select"
											aria-label="Default select example">
									<option selected>이용권 선택 시 시간 필수</option>
									<option value="1">제품</option>
									<option value="2">이용권</option>
								</select></td>
								<th>사용시간</th>
								<td><input class="form-control" type="text"
										   placeholder="Default input" aria-label="default input example">
								</td>
							</tr>
							<tr>
								<th>상품분류</th>
								<td><input class="form-control" type="text"
										   placeholder="Default input" aria-label="default input example">
								</td>
								<th colspan="2">상품설명</th>
							</tr>
							<tr>
								<th>상품명</th>
								<td><input class="form-control" type="text"
										   placeholder="Default input" aria-label="default input example">
								</td>
								<td colspan="2" rowspan="2" class="form-floating"><textarea
										class="form-control" placeholder="Leave a comment here"
										id="floatingTextarea" style="height: 90px;"></textarea> <label
										for="floatingTextarea">Comments</label></td>
							</tr>
							<tr>
								<th>가격</th>
								<td><input class="form-control" type="text"
										   placeholder="Default input" aria-label="default input example">
								</td>
							</tr>
							</tbody>
						</table>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">취소</button>
						<button type="button" class="btn btn-primary">등록</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</nav>
<nav id="menu_bar" class="nav nav-pills flex-column py-3 text-center"
	 style="position: absolute; height: 100%;">
	<a class="nav-link py-3" href="${cpath }/admin/order">주문</a>
	<a class="nav-link py-3" href="${cpath }/admin/product">재고</a>
	<a class="nav-link py-3" aria-current="page"
	   href="${cpath }/admin/productsales">매출</a> <a
		class="nav-link py-3" href="${cpath }/admin/user">회원</a> <a
		class="nav-link py-3 active" href="${cpath }/admin/seat"
		style="background-color: #FF8339;">좌석</a> <a class="nav-link py-3"
													 href="${cpath }/admin/ticket">이용권</a>
</nav>

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
					<button class="btn btn-success" type="submit" onclick="changeSeatStatus()">수정하기</button>
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




<!-- 좌석 시간 추가, 상태  Modal -->
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

<%--채팅 모달--%>
<script>

	var popoverTriggerList = [].slice.call(document
			.querySelectorAll('[data-bs-toggle="popover"]'))
	var popoverList = popoverTriggerList.map(function(popoverTriggerEl) {
		return new bootstrap.Popover(popoverTriggerEl)
	})

	$(document).ready(function() {
		$.ajax({
			url : "header.html",
			dataType : "html",
			success : function(response) {
				$("#headerContent").html(response);
			},
		});
	});
	var imageInput = document.getElementById('image');
	imageInput.addEventListener('change', previewImage);

	function previewImage(event) {
		var input = event.target;
		var preview = document.getElementById('preview');

		if (input.files && input.files[0]) {
			var reader = new FileReader();

			reader.onload = function() {
				preview.src = reader.result;
			};

			reader.readAsDataURL(input.files[0]);
		}
	}
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
					 onclick="setModalSeatId(this)">
					<div class="seat_id card-header">좌석번호[ ${seat.seatId} ]</div>
					<div class="seat_remain_time card-body">
						<pre>남은시간:</pre>
						<pre>01:35</pre>
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
	let seatId;
	function setModalSeatId(card) {
		seatId = card.getAttribute('data-bs-id')
		const modalSeatId = document.getElementById('modal_seat_id')
		modalSeatId.textContent = seatId;
	}

	function changeSeatStatus(){
		const selectElement = document.getElementById('can_use')
		const selectOption = selectElement.options[selectElement.selectedIndex]
		const seat = document.querySelector(`[data-bs-id="${seatId}"]`)

		switch (selectOption.value){
			case 1:
				seat.classList.remove('bg-secondary','bg-warning','bg-danger')
				seat.classList.add('bg-primary')
				seat.querySelector('.card-footer').textContent = '사용가능'
				break;
			case 2:
				seat.classList.remove('bg-primary', 'bg-waring', 'bg-danger')
				seat.classList.add('bg-secondary')
				seat.querySelector('.card-footer').textContent = '사용중'
				break;
			case 3:
				seat.classList.remove('bg-secondary','bg-primary','bg-danger')
				seat.classList.add('bg-warning')
				seat.querySelector('.card-footer').textContent = '예약석'
				break;
			case 4:
				seat.classList.remove('bg-secondary','bg-primary','bg-warning')
				seat.classList.add('bg-danger')
				seat.querySelector('.card-footer').textContent = '사용불가'
				break;
		}
	}

</script>

</body>
</html>