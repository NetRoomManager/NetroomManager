<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
	<title>Home</title>
</head>
<body>

<!-- 포트원 결제 -->
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<!-- 포트원 결제 -->

<c:if test="${not empty login}">
	<h1>${login.name}님 ㅎㅇ</h1>
</c:if>

<ul>
	<c:if test="${empty login}">
		<li><a href="/auth/login">로그인</a></li>
	</c:if>
	<c:if test="${not empty login}">
		<li><a href="/auth/logout">로그아웃</a></li>
	</c:if>
</ul>

<a href="/auth/buyTicket">이용권 구매</a>

</body>
</html>
