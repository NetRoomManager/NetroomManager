<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cpath" value="${pageContext.request.contextPath }" />
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
}

.hidden {
	display: none;
}
</style>
<body>
	<nav class="navbar navbar-expand-sm bg-info navbar-dark">
		<div class="container-fluid">
			<ul class="navbar-nav">
				<li class="nav-item"><a class="nav-link active"
					href="${cpath }/">Home</a></li>
				<li class="nav-item"><a class="nav-link"
					href="${cpath }/admin/seat_manage.jsp">좌석관리</a></li>
				<li class="nav-item"><a class="nav-link"
					href="${cpath }/admin/product_manage.jsp">상품관리</a></li>
				<li class="nav-item"><a class="nav-link"
					href="${cpath }/admin/sales_manage.jsp">매출관리</a></li>
				<li class="nav-item"><a class="nav-link"
					href="${cpath }/admin/ticket_manage.jsp">이용권관리</a></li>
				<li class="nav-item"><a class="nav-link"
					href="${cpath }/admin/user_manage.jsp">회원관리</a></li>
				<li class="nav-item"><a class="nav-link"
					href="${cpath }/admin/order_manage.jsp">주문관리</a></li>
			</ul>
		</div>
	</nav>