<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="header.jsp" %>
<!-- 상품관리 페이지 -->

<style>
    #menu_bar {
        background-color: #ffa500
    }

    #menu_bar > a {
        color: #ffffff;
    }

    #product_update table > tbody > tr > th {
        padding-top: 15px;
    }
</style>

<div id="headerContent"></div>
<%-- 상단 nav --%>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0 pt-1">
            <li class="nav-item">
                <a class="nav-link active navbar-brand"
                   aria-current="page" href="${cpath}/">NetRoom</a>
            </li>
            <li class="nav-item pe-3 hover_element"><a class="nav-link"
                                         data-bs-toggle="modal" data-bs-target="#ticketCreate">이용권등록</a>
            </li>
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
                <button type="button" class="btn btn-light" onclick="location.reload();"
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

    <%--이용권등록 모달                       --%>
    <div class="modal fade" id="ticketCreate" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
         aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <form action="/admin/ticketRegister" method="POST">
                    <div class="modal-header">
                        <h3 class="modal-title">이용권등록</h3>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body container">
                        <table class="table table-borderless">
                            <tbody>
                            <tr>
                                <th>이용권이름</th>
                                <td>
                                    <input type="hidden" name="id">
                                    <input class="form-control" type="text" name="name"
                                           placeholder="이용권 이름 등록" required aria-label="default input example">
                                </td>
                            </tr>
                            <tr>
                                <th>이용권시간</th>
                                <td>
                                    <input class="form-control" type="number" name="time"
                                           placeholder="초" required aria-label="default input example">
                                </td>
                            </tr>
                            <tr>
                                <th>이용권가격</th>
                                <td>
                                    <input class="form-control" type="number" name="price"
                                           placeholder="금액입력" required aria-label="default input example">
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                        <button type="submit" class="btn btn-primary editModalBtn">등록</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <%--이용권등록 모달                       --%>
    <div class="modal fade" id="ticketUpdate" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
         aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <form action="/admin/ticketRegister" method="POST">
                    <div class="modal-header">
                        <h3 class="modal-title">이용수정</h3>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body container">
                        <table class="table table-borderless">
                            <tbody>
                            <tr>
                                <th>이용권이름</th>
                                <td>
                                    <input type="hidden" id="editTicketId" name="id">
                                    <input class="form-control" type="text" id="editTicketName" name="name"
                                           placeholder="이용권 이름 등록" required aria-label="default input example">
                                </td>
                            </tr>
                            <tr>
                                <th>이용권시간</th>
                                <td>
                                    <input class="form-control" type="number" id="editTicketTime" name="time"
                                           placeholder="초" required aria-label="default input example">
                                </td>
                            </tr>
                            <tr>
                                <th>이용권가격</th>
                                <td>
                                    <input class="form-control" type="number" id="editTicketPrice" name="price"
                                           placeholder="금액입력" required aria-label="default input example">
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                        <button type="submit" class="btn btn-primary editModalBtn">수정</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</nav>

<%--이용권 목록                      --%>
<div class="container mt-5">
    <table class="table table-hover">
        <thead>
        <tr class="table-dark text-center">
            <th scope="col">이용권번호</th>
            <th scope="col">이용권이름</th>
            <th scope="col">가격</th>
            <th scope="col">시간</th>
            <th scope="col">수정</th>
            <th scope="col">삭제</th>
        </tr>
        </thead>
        <script>
            let tickets = [];
        </script>
        <tbody>
        <c:forEach var="ticket" items="${ticketList}">
            <tr class="text-center">
                <td class="pt-3">${ticket.id}</td>
                <td class="pt-3">${ticket.name}</td>
                <td class="pt-3">${ticket.price}</td>
                <td class="pt-3">${ticket.time}</td>
                <td>
                    <button type="button" class="editBtn btn btn-outline-warning"
                            data-bs-toggle="modal" data-bs-target="#ticketUpdate"
                            data-ticket-id="${ticket.id}" data-ticket-name="${ticket.name}"
                            data-ticket-price="${ticket.price}" data-ticket-time="${ticket.time}"
                    >수정
                    </button>
                </td>
                <td>
                    <button type="button" id="deleteTicketBtn" class="btn btn-outline-danger"
                            data-ticket-id="${ticket.id}"
                    >삭제
                    </button>
                </td>
            </tr>
            <script>
                tickets.push(${ticket.id});
            </script>
        </c:forEach>
        </tbody>
    </table>

</div>


<script>
    <%-- Bootstrap Popover는 사용자가 요소를 호버하거나 클릭했을 때 콘텐츠를 팝업 형태로 보여주는 기능을 제공 --%>
    var popoverTriggerList = [].slice.call(document
        .querySelectorAll('[data-bs-toggle="popover"]'))
    var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
        return new bootstrap.Popover(popoverTriggerEl)
    })

    <%-- 이용권 수정 --%>
    tickets.forEach((ticket, index) => {
        const editBtns = document.getElementsByClassName('editBtn')
        for(let i=0; i<editBtns.length; i++) {
            editBtns[i].onclick = function updateTicketInfo(event) {
                var ticketId = event.target.getAttribute('data-ticket-id')
                var ticketName = event.target.getAttribute('data-ticket-name')
                var ticketPrice = event.target.getAttribute('data-ticket-price')
                var ticketTime = event.target.getAttribute('data-ticket-time')
                document.getElementById('editTicketId').value = ticketId
                document.getElementById('editTicketName').value = ticketName
                document.getElementById('editTicketPrice').value = ticketPrice
                document.getElementById('editTicketTime').value = ticketTime
            }
        }
    });

    /*이용권 등록 모달 내용 리셋 */
    // const ticketModalLink = document.querySelector('[data-bs-toggle=modal][data-bs-target="#ticketUpdate"]')
    // ticketModalLink.onclick = function showModal() {
    //     document.getElementById('editTicketId').value = ""
    //     document.getElementById('editTicketName').value = ""
    //     document.getElementById('editTicketPrice').value = ""
    //     document.getElementById('editTicketTime').value = ""
    // }

    const deleteTicketBtn = document.querySelectorAll('#deleteTicketBtn');
    deleteTicketBtn.forEach(function (btn) {
        btn.addEventListener('click', deleteTicket)
    })

    function deleteTicket(event) {
        var ticketId = event.target.getAttribute('data-ticket-id')
        console.log(ticketId + "번 이용권 삭제")
        if (ticketId == null) {
            alert('이용권 정보가 존재하지 않습니다')
            return;
        }
        var cfm = window.confirm('정말 삭제하시겠습니까?')
        if (ticketId > 0 && cfm) {
            location.href = '/admin/deleteTicket/' + ticketId
        }

        if (!cfm) {
            alert('삭제를 취소하셨습니다')
        }
    }

</script>
</body>
</html>