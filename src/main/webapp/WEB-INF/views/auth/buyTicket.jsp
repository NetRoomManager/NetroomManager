<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
<!-- 세션에서 SecurityContext를 가져옵니다. -->
<c:set var="securityContext" value="${sessionScope.SPRING_SECURITY_CONTEXT}"/>

<!-- SecurityContext에서 Authentication 객체를 가져옵니다. -->
<c:set var="authentication" value="${securityContext.authentication}"/>

<!-- Authentication 객체에서 Principal(사용자) 정보를 가져옵니다. -->
<c:set var="principal" value="${authentication.principal}"/>

<!-- Principal에서 사용자의 이름을 가져옵니다. -->
<c:set var="username" value="${principal.username}"/>

<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>이용권 구매</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <!-- 포트원 결제 -->
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    <!-- jQuery -->
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <!-- iamport.payment.js -->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
    <!-- 포트원 결제 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        #ticket_item:hover {
            padding: 10px;
            transition: 0.5s;
        }
    </style>
</head>

<body>
<nav class="navbar navbar-expand-sm navbar-dark bg-dark p-3">
    <div class="container-fluid d-flex">
        <c:if test="${not empty principal}">
            <a class="navbar-brand" href="/customer/main">NetRoom PC방</a>
        </c:if>
        <c:if test="${empty principal}">
            <a class="navbar-brand" href="/auth/login">NetRoom PC방</a>
        </c:if>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mynavbar">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="d-flex text-light">
            <div>
                <!-- username을 출력합니다. -->
                <c:if test="${not empty principal}">
                    <h4>${principal.username}</h4>
                </c:if>
            </div>
        </div>
    </div>
</nav>

<div class="w-100 bg-light container mt-5">
    <h4 class="text-black pt-3">회원 검색하기</h4>
    <form action="#" class="pb-3">
        <div class="form-floating mb-3 mt-3">
            <input type="text" class="form-control" id="name" placeholder="Enter name" name="name"/>
            <label for="name">이름으로 검색하기</label>
        </div>
    </form>
</div>
<div class="container mt-3">
    <table class="table table-striped">
        <thead>
        <tr>
            <th>이름</th>
            <th>생년월일</th>
            <th>이메일</th>
            <th>선택</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="user" items="${list}" varStatus="status">
            <tr>
                <div class="form-group mb-2 d-flex">
                    <td>
                        <input type="text" class="form-control " name="name" value="${user.name}" readonly>
                    </td>
                    <td>
                        <input type="date" class="form-control " name="birth" value="${user.birth}"
                               readonly>
                    </td>
                    <td>
                        <input type="email" class="form-control " name="email"
                               value="${user.email}" readonly>
                    </td>

                    <td>
                        <input id="${status.index}" name="userSelector" type="button" class="btn btn-primary" value="선택하기"
                               data-bs-toggle="offcanvas"
                               data-bs-target="#ticket">
                    </td>
                </div>
            </tr>
        </c:forEach>
        <c:if test="${empty list}">
            <tr>
                <td><h3>유저가 존재하지 않습니다</h3></td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>

<div class="offcanvas offcanvas-end" id="payments">
    <div class="offcanvas-header">
        <h1 class="offcanvas-title">결제하기</h1>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
    </div>
    <div class="offcanvas-body d-flex flex-wrap">
        <button id="kakaoBtn" class="btn"><img class="img-fluid" src="/img/kakaopay.jpg" alt="New York" width="1100"
                                               height="500"></button>
        <button id="tossBtn" class="btn"><img class="img-fluid w-100" src="/img/tosspay.png" alt="New York"></button>
        <button id="inicisBtn" class="btn"><img class="img-fluid" src="/img/KG_pay_button.png   " alt="New York"
                                                width="1100"
                                                height="500"></button>
        <button class="btn btn-secondary " data-bs-dismiss="offcanvas" type="button">
            구매취소
        </button>
    </div>
</div>

<div
        class="w-100 bg-light container d-flex flex-wrap mt-3 mb-3 h-50 offcanvas offcanvas-bottom"
        id="ticket" style="overflow-x: auto; margin: auto">
    <c:forEach var="ticket" items="${ticketList}">
        <div class="ticket_item text-lg-center mx-5" style="width: 20%;">
            <div class="card mt-3 mb-3 fw-bold border-black border-1 ticket_item"
                 style="background-color: #ffbb3f">
                <div class="ticket-name card-header text-dark">${ticket.name}</div>
                <div class="ticket-price card-body text-danger">
                    <fmt:formatNumber type="number" value="${ticket.price}" pattern="[#,###원]"/>
                </div>
                <div class="card-footer">
                    <button class="btn btn-primary" type="button"
                            data-bs-toggle="offcanvas" data-bs-target="#payments" onclick="selectTicket('${ticket.name}', '${ticket.price}')">구매하기
                    </button>
                </div>
            </div>
        </div>
    </c:forEach>


</div>

<script src="/js/payment.js"></script>

</body>

</html>