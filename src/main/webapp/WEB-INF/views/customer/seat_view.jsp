<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="cpath" value="${pageContext.request.contextPath }" />


<!-- 세션에서 SecurityContext를 가져옵니다. -->
<c:set var="securityContext" value="${sessionScope.SPRING_SECURITY_CONTEXT}" />

<!-- SecurityContext에서 Authentication 객체를 가져옵니다. -->
<c:set var="authentication" value="${securityContext.authentication}" />

<!-- Authentication 객체에서 Principal(사용자) 정보를 가져옵니다. -->
<c:set var="principal" value="${authentication.principal}" />

<!-- Principal에서 사용자의 이름을 가져옵니다. -->
<c:set var="username" value="${principal.username}" />

<link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
        rel="stylesheet">
<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- 상품관리 페이지 -->

<style>
    #product_update table>tbody>tr>th {
        padding-top: 15px;
    }


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


<!-- 좌석 선택 모달 -->
<div class="modal fade" id="seat_select_modal" aria-hidden="true"
     data-bs-backdrop="static" data-bs-keyboard="false"
     aria-labelledby="seat_select_modalLabel" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">좌석 선택</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">
                <p>좌석을 선택하시겠습니까?</p>
            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
                <button class="btn btn-primary" id="seat_select_yes">Yes</button>
                <button class="btn btn-secondary" data-bs-dismiss="modal">No</button>
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

    $(document).ready(function() {
        $.ajax({
            url : "header.html",
            dataType : "html",
            success : function(response) {
                $("#headerContent").html(response);
            },
        });
    });

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
                        <pre>이름: </pre>
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
    // 좌석 선택 모달 표시
    $(document).ready(function() {
        $('.card.bg-primary.text-white.mx-3.mt-3').click(function() {
            $('#seat_select_modal').modal('show');
        });
    });

    // No 버튼 클릭 시 좌석 보여주기
    $('#seat_select_modal').on('hidden.bs.modal', function (e) {
        // 좌석을 보여주는 로직 추가
    });

    // Yes 버튼 클릭 시 메시지 표시
    $('#seat_select_yes').click(function() {
        alert('좌석이 선택되었습니다.');
        $('#seat_select_modal').modal('hide');
        // window.location.href = "http://localhost:8080/auth/login";
    });
</script>

</body>
</html>