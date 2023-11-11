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
                     data-bs-target="#seat_select_modal"
                     data-bs-id="${seat.seatId}"
                     data-bs-userid="${seat.user_id}"
                     data-bs-state="${seat.seatState}">

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
    document.addEventListener('DOMContentLoaded', function() {
        const cards = document.querySelectorAll('.card.bg-primary.text-white.mx-3.mt-3');
        const modal = document.getElementById('seat_select_modal');
        const yesButton = document.getElementById('seat_select_yes');

        for(let i = 0; i < cards.length; i++) {
            cards[i].addEventListener('click', function() {
                // 좌석의 ID를 data 속성을 통해 가져와 모달의 data 속성에 저장
                const seatId = this.getAttribute('data-bs-id');
                const state = this.getAttribute('data-bs-state');
                modal.setAttribute('data-selectedSeatId', seatId);
                modal.setAttribute('data-bs-state', state);

                // 모달 표시
                const bootstrapModal = new bootstrap.Modal(modal);
                bootstrapModal.show();
            });
        }

        yesButton.addEventListener('click', function() {
            const state = modal.getAttribute('data-bs-state');
            if(state!=1) {
                alert('사용불가한 좌석입니다.');
                return;
            }
            else {
                // 모달의 data 속성에서 선택된 좌석 ID를 가져와 콘솔에 출력
                const selectedSeatId = modal.getAttribute('data-selectedSeatId');

                location.href='/customer/seatSelector?seatId=' + selectedSeatId;

                console.log('선택된 좌석 ID: ' + selectedSeatId);
            }

            // 모달 숨김
            const bootstrapModal = bootstrap.Modal.getInstance(modal);
            bootstrapModal.hide();
        });
    });

</script>

</body>
</html>