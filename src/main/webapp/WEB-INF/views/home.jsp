<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 세션에서 SecurityContext를 가져옵니다. -->
<c:set var="securityContext" value="${sessionScope.SPRING_SECURITY_CONTEXT}" />

<!-- SecurityContext에서 Authentication 객체를 가져옵니다. -->
<c:set var="authentication" value="${securityContext.authentication}" />

<!-- Authentication 객체에서 Principal(사용자) 정보를 가져옵니다. -->
<c:set var="principal" value="${authentication.principal}" />

<!-- Principal에서 사용자의 이름을 가져옵니다. -->
<c:set var="username" value="${principal.username}" />

<!-- username을 출력합니다. -->
<p>사용자 : ${principal}</p>


<html>
<head>
	<title>Home</title>
</head>
<body>

<h1>${version}</h1>


<ul>
	<li><a href="/auth/login">로그인</a></li>
	<li><a href="/auth/logout">로그아웃</a></li>
	<li><a href="/auth/buyTicket">티켓구매</a></li>
	<li><a href="/auth/create_admin">관리자 생성하기</a></li>
	<li><a href="/admin/product">관리자 상품 관리</a></li>
	<li><a href="/admin/seat">좌석 생성</a></li>
	<li><a href="/admin/seat_manage">관리자 페이지</a></li>
</ul>

</body>
</html>
