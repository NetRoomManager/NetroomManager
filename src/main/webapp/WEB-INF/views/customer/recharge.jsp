<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<!-- 고객 이용권 시간 충전 페이지 -->
<!-- 로그인 후 사용중인 고객이 시간을 추가로 충전하기 위한 페이지 입니다. -->

<div class="container bg-white w-100 h-50 mt-5 rounded">
	<div class="container pt-3">
		<h3>이용권 충전</h3>
	</div>
	<div class="container d-flex flex-wrap mx-auto">
		<div class="text-lg-center mx-5" style="width: 25%;">
			<div class="card mt-3 mb-3 fw-bold border-black border-1 ticket_item"
				style="background-color: #ffbb3f">
				<div class="card-header text-dark">회원 1시간 이용권</div>
				<div class="card-body text-danger">[1,000원]</div>
				<div class="card-footer">
					<button class="btn btn-primary" type="button"
						data-bs-toggle="offcanvas" data-bs-target="#demo">구매하기</button>
				</div>
			</div>
		</div>
		
		<div class="text-lg-center mx-5" style="width: 25%;">
			<div class="card mt-3 mb-3 fw-bold border-black border-1 ticket_item"
				style="background-color: #ffbb3f">
				<div class="card-header text-dark">회원 2시간 이용권</div>
				<div class="card-body text-danger">[2,000원]</div>
				<div class="card-footer">
					<button class="btn btn-primary" type="button"
						data-bs-toggle="offcanvas" data-bs-target="#demo">구매하기</button>
				</div>
			</div>
		</div>
		<div class="text-lg-center mx-5" style="width: 25%;">
			<div class="card mt-3 mb-3 fw-bold border-black border-1 ticket_item"
				style="background-color: #ffbb3f">
				<div class="card-header text-dark">회원 3시간 이용권</div>
				<div class="card-body text-danger">[3,000원]</div>
				<div class="card-footer">
					<button class="btn btn-primary" type="button"
						data-bs-toggle="offcanvas" data-bs-target="#demo">구매하기</button>
				</div>
			</div>
		</div>
		<div class="text-lg-center mx-5" style="width: 25%;">
			<div class="card mt-3 mb-3 fw-bold border-black border-1 ticket_item"
				style="background-color: #ffbb3f">
				<div class="card-header text-dark">회원 5시간 이용권</div>
				<div class="card-body text-danger">[5,000원]</div>
				<div class="card-footer">
					<button class="btn btn-primary" type="button"
						data-bs-toggle="offcanvas" data-bs-target="#demo">구매하기</button>
				</div>
			</div>
		</div>
		<div class="text-lg-center mx-5" style="width: 25%;">
			<div class="card mt-3 mb-3 fw-bold border-black border-1 ticket_item"
				style="background-color: #ffbb3f">
				<div class="card-header text-dark">회원 10시간+1시간 이용권</div>
				<div class="card-body text-danger">[10,000원]</div>
				<div class="card-footer">
					<button class="btn btn-primary" type="button"
						data-bs-toggle="offcanvas" data-bs-target="#demo">구매하기</button>
				</div>
			</div>
		</div>
		<div class="text-lg-center mx-5" style="width: 25%;">
			<div class="card mt-3 mb-3 fw-bold border-black border-1 ticket_item"
				style="background-color: #ffbb3f">
				<div class="card-header text-dark">회원 20시간+3시간 이용권</div>
				<div class="card-body text-danger">[20,000원]</div>
				<div class="card-footer">
					<button class="btn btn-primary" type="button"
						data-bs-toggle="offcanvas" data-bs-target="#demo">구매하기</button>
				</div>
			</div>
		</div>	
		
		
		<div class="text-lg-center mx-5" style="width: 25%;">
			<div class="card mt-3 mb-3 fw-bold border-black border-1 ticket_item"
				style="background-color: #ffbb3f">
				<div class="card-header text-dark">회원 50시간 + 10시간 이용권</div>
				<div class="card-body text-danger">[50,000원]</div>
				<div class="card-footer">
					<button class="btn btn-primary" type="button"
						data-bs-toggle="offcanvas" data-bs-target="#demo">구매하기</button>
				</div>
			</div>
		</div>	
	</div>
</div>

<div class="offcanvas offcanvas-end" id="demo">
		<div class="offcanvas-header">
			<h1 class="offcanvas-title">결제하기</h1>
			<button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
		</div>
		<div class="offcanvas-body d-flex flex-wrap">
			<button class="btn">
				<img class="img-fluid" src="../img/kakaopay.jpg" alt="New York"
					width="1100" height="500">
			</button>
			<button class="btn">
				<img class="img-fluid w-100" src="../img/tosspay.png" alt="New York">
			</button>
			<button class="btn">
				<img class="img-fluid" src="../img/naverpay.png" alt="New York"
					width="1100" height="500">
			</button>
			<button class="btn btn-secondary " data-bs-dismiss="offcanvas"
				type="button">구매취소</button>
		</div>
	</div>
</body>
</html>
