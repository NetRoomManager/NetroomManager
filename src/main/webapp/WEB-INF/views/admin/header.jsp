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