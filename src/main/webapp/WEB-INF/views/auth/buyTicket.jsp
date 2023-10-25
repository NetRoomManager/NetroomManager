<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>이용권 구매</title>
    <link rel="stylesheet" type="text/css" href="../css/style.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
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
        <a class="navbar-brand" href="${cpath}/auth/login">NetRoom PC방</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mynavbar">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="d-flex text-light">
            <div>
                <h4>홍길동님</h4>
            </div>
        </div>
    </div>
</nav>

<div class="w-100 bg-light container mt-5">
    <h4 class="text-black pt-3">회원 검색하기</h4>
    <form action="#" class="pb-3">
        <div class="form-floating mb-3 mt-3">
            <input type="text" class="form-control" id="name" placeholder="Enter name" name="name" />
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
        <tr>
            <div class="form-group mb-2 d-flex" id="1">
                <td>
                    <input type="text" class="form-control " name="name" id="name_1" value="신짱구" readonly>
                </td>
                <td>
                    <input type="date" class="form-control " name="birth" id="birth_1" value="2003-03-04"
                           readonly>
                </td>
                <td>
                    <input type="email" class="form-control " name="users_email" id="email_1"
                           value="march03@naver.com" readonly>
                </td>

                <td>
                    <input type="button" class="btn btn-primary" value="선택하기" data-bs-toggle="offcanvas"
                           data-bs-target="#ticket">
                </td>
            </div>
            </td>
        </tr>
        <tr>
            <div class="form-group mb-2 d-flex">
                <td>
                    <input type="text" class="form-control " name="name" id="name_4" value="홍길동" readonly>
                </td>
                <td>
                    <input type="date" class="form-control " name="birth" id="birth_4" value="1999-04-12"
                           readonly>
                </td>
                <td>
                    <input type="email" class="form-control " name="users_email" id="email_4"
                           value="hong321@naver.com" readonly>
                </td>

                <td>
                    <input type="button" class="btn btn-primary" value="선택하기" readonly>
                </td>
            </div>
            </td>
        </tr>
        <tr>
            <div class="form-group mb-2 d-flex">
                <form>
                    <td>
                        <input type="text" class="form-control " id="name_31" value="김석국" readonly>
                    </td>
                    <td>
                        <input type="date" class="form-control " id="birth_31" value="2007-12-03" readonly>
                    </td>
                    <td>
                        <input type="email" class="form-control " id="email_31" value="phycho321@naver.com"
                               readonly>
                    </td>
                    <td>
                        <input type="button" class="btn btn-primary" value="선택하기" readonly
                               data-bs-toggle="modal" data-bs-target="#myModal">
                    </td>
                </form>
            </div>
            </td>
        </tr>
        </tbody>
    </table>
</div>

<div class="offcanvas offcanvas-end" id="demo">
    <div class="offcanvas-header">
        <h1 class="offcanvas-title">결제하기</h1>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
    </div>
    <div class="offcanvas-body d-flex flex-wrap">
        <button id="kakaoBtn" class="btn"><img class="img-fluid" src="/img/kakaopay.jpg" alt="New York" width="1100"
                                 height="500"></button>
        <button id="tossBtn" class="btn"><img class="img-fluid w-100" src="/img/tosspay.png" alt="New York"></button>
        <button id="inicisBtn" class="btn"><img class="img-fluid" src="/img/naverpay.png" alt="New York" width="1100"
                                 height="500"></button>
        <button class="btn btn-secondary " data-bs-dismiss="offcanvas" type="button">
            구매취소
        </button>
    </div>
</div>

<div class="w-100 bg-light container d-flex flex-wrap mt-3 mb-3 offcanvas offcanvas-bottom" id="ticket"
     style="overflow-x: auto;">
    <div class="text-lg-center mx-5" style="width: 300px;">
        <div class="card mt-3 mb-3 fw-bold border-black border-1" id="ticket_item"
             style="background-color: #ffbb3f">
            <div class="card-header text-dark">1시간 이용권</div>
            <div class="card-body text-danger">[1,000원]</div>
            <div class="card-footer">
                <button class="btn btn-primary" type="button" data-bs-toggle="offcanvas" data-bs-target="#demo">
                    구매하기
                </button>
            </div>
        </div>
    </div>
    <div class="text-lg-center mx-5 view overlay zoom" style="width: 300px">
        <div class="card mt-3 mb-3 fw-bold border-black border-1" style="background-color: #ffbb3f">
            <div class="card-header text-dark">2시간 이용권</div>
            <div class="card-body text-danger">[2,000원]</div>
            <div class="card-footer">
                <button class="btn btn-primary" type="button" data-bs-toggle="offcanvas" data-bs-target="#demo">
                    구매하기
                </button>
            </div>
        </div>
    </div>
    <div class="text-lg-center mx-5" style="width: 300px">
        <div class="card mt-3 mb-3 fw-bold border-black border-1" style="background-color: #ffbb3f">
            <div class="card-header text-dark">3시간 이용권</div>
            <div class="card-body text-danger">[3,000원]</div>
            <div class="card-footer">
                <button class="btn btn-primary" type="button" data-bs-toggle="offcanvas" data-bs-target="#demo">
                    구매하기
                </button>
            </div>
        </div>
    </div>
    <div class="text-lg-center mx-5" style="width: 300px">
        <div class="card mt-3 mb-3 fw-bold border-black border-1" style="background-color: #ffbb3f">
            <div class="card-header text-dark">5시간 이용권</div>
            <div class="card-body text-danger">[4,000원]</div>
            <div class="card-footer">
                <button class="btn btn-primary" type="button" data-bs-toggle="offcanvas" data-bs-target="#demo">
                    구매하기
                </button>
            </div>
        </div>
    </div>

    <div class="text-lg-center mx-5" style="width: 300px">
        <div class="card mt-3 mb-3 fw-bold border-black border-1" style="background-color: #ffbb3f">
            <div class="card-header text-dark">12시간이용권</div>
            <div class="card-body text-danger">[10,000원]</div>
            <div class="card-footer">
                <button class="btn btn-primary" type="button" data-bs-toggle="offcanvas" data-bs-target="#demo">
                    구매하기
                </button>
            </div>
        </div>
    </div>
    <div class="text-lg-center mx-5" style="width: 300px">
        <div class="card mt-3 mb-3 fw-bold border-black border-1" style="background-color: #ffbb3f">
            <div class="card-header text-dark">24시간이용권</div>
            <div class="card-body text-danger">[15,000원]</div>
            <div class="card-footer">
                <button class="btn btn-primary" type="button" data-bs-toggle="offcanvas" data-bs-target="#demo">
                    구매하기
                </button>
            </div>
        </div>
    </div>
</div>

<script>
    // 구매자 정보
    const user_email = '${login.email}'
    const username = '${login.username}'
</script>
<script src="/js/buyTicket.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<!-- 포트원 결제 -->
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<!-- 포트원 결제 -->

</body>

</html>