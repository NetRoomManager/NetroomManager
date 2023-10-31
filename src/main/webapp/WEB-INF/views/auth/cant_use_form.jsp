<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cpath" value="${pageContext.request.contextPath }" />
<!--로그인/회원가입 폼 페이지 -->
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/style.css" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<title>사용불가 좌석</title>
</head>
<!-- 바디에 다크모드 -->
<body data-bs-theme="dark">
	<nav class="navbar navbar-expand-sm bg-info navbar-dark">
		<div class="container-fluid">
			<ul class="navbar-nav">
				<li class="nav-item"><a class="nav-link active"
					href="${cpath }/">Home</a></li>
				<li class="nav-item"><a class="nav-link"
					href="${cpath }/admin/seat_manage.jsp">Admin</a></li>
				<li class="nav-item"><a class="nav-link"
					href="${cpath }/auth/login_form.jsp">Auth</a></li>
				<li class="nav-item"><a class="nav-link"
					href="${cpath }/customer/customer_main.jsp">customer</a></li>
			</ul>
		</div>
	</nav>
	<div class="container">
		<div
			class="d-flex justify-content-center align-items-center w-100 h-100">
			<div class="text-white pt-5">
				<h1>사용불가</h1>
			</div>
		</div>
	</div>
</body>
</html>
