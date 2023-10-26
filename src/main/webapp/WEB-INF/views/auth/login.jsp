<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" type="text/css" href="/css/style.css" />
    <link
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
            rel="stylesheet"
    />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <title>로그인</title>
</head>
<!-- 바디에 다크모드 -->
<body data-bs-theme="dark">
<!-- 좌석이미지 -->
<div
        class="container"
        style="
                background-image: url('/img/1422005677144.png');
                background-size: 100%;
                background-repeat: no-repeat;
                background-position: center;
                width: auto;
                height: 550px;
            "
></div>
<!-- 컨테이너 -->
<div class="container p-0">
    <div class="d-flex w-100 mt-3" style="height: 350px">
        <!-- 로그인 폼 -->
        <form method="POST" class="w-25">
            <div class="form-floating mb-3 mt-3">
                <input
                        type="text"
                        class="form-control"
                        id="login_username"
                        placeholder="Enter username"
                        name="username"
                        required
                />
                <label for="username">유저아이디</label>
            </div>
            <div class="form-floating mt-3 mb-3">
                <input
                        type="password"
                        class="form-control"
                        id="users_password"
                        placeholder="Enter password"
                        name="users_password"
                        required
                />
                <label for="users_password">Password</label>
            </div>
            <button
                    type="submit"
                    class="btn btn-success w-100 p-3 mt-3"
            >
                로그인
            </button>
            <button
                    type="button"
                    class="btn btn-warning w-100 p-3 mt-3"
                    data-bs-toggle="modal"
                    data-bs-target="#myModal"
            >
                회원 가입
            </button>
        </form>
        <div class="mx-5 mt-3 mb-3 d-inline-block w-50">
            <h3>소셜로그인</h3>
            <img
                    onclick="javascript:naverLogin()"
                    class="rounded img-fluid mt-5 mb-5"
                    style="height: 20%"
                    src="/img/naver_circle.png"
            />
            <img
                    onclick="javascript:kakaoLogin()"
                    class="rounded img-fluid mt-5 mb-5 mx-5"
                    style="height: 20%"
                    src="/img/kakao.webp"
            />
            <img
                    onclick="javascript:googleLogin()"
                    class="rounded img-fluid mt-5 mb-5"
                    style="height: 20%"
                    src="/img/google.png"
            />
        </div>
        <div class="mt-3 mb-3">
            <h3>이용권 구매</h3>
            <a href="buyTicket">
                <button
                        type="button"
                        class="btn btn-primary w-100 p-3 mt-3"
                >
                    이용권 구매
                </button>
            </a>
        </div>
    </div>
    <div class="modal" id="myModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">회원가입</h4>
                    <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                    ></button>
                </div>

                <!-- Modal body -->
                <div class="modal-body">
                    <div class="container mt-3">
                        <p>회원가입 페이지 입니다.</p>
                        <!-- 액션   -->
                        <form action="/auth/join" method="post">
                            <div class="form-floating mt-3 mb-3">
                                <input
                                        type="text"
                                        class="form-control"
                                        id="name"
                                        placeholder="Enter name"
                                        name="name"
                                        required
                                />
                                <label for="name">이름</label>
                            </div>

                            <div class="form-floating mt-3 mb-3">
                                <input
                                        type="text"
                                        class="form-control"
                                        id="join_username"
                                        placeholder="Enter username"
                                        name="username"
                                        required
                                />
                                <label for="username">아이디</label>

                                <span id="check_msg"></span>
                            </div>

                            <div class="form-floating mt-3 mb-3">
                                <input
                                        type="password"
                                        class="form-control"
                                        id="password"
                                        placeholder="Enter password"
                                        name="password"
                                        required
                                />
                                <label for="password">패스워드</label>
                            </div>

                            <div class="form-floating mt-3 mb-3">
                                <input
                                        type="date"
                                        class="form-control"
                                        id="birth"
                                        placeholder="Enter birth"
                                        name="birth"
                                        required
                                />
                                <label for="birth">생년월일</label>
                            </div>

                            <div class="form-floating mt-3 mb-3">
                                <input
                                        type="email"
                                        class="form-control"
                                        id="email"
                                        placeholder="Enter username"
                                        name="email"
                                        required
                                />
                                <label for="email">이메일</label>
                            </div>

                            <div class="form-floating mb-3 mt-3">
                                <input
                                        type="text"
                                        class="form-control"
                                        id="mobile"
                                        placeholder="Enter mobile"
                                        value="010"
                                        name="mobile"
                                        required
                                        oninput="oninputPhone(this)"
                                />
                                <label for="mobile">전화번호</label>
                            </div>

                            <button
                                    type="submit"
                                    class="btn btn-primary"
                            >
                                회원가입
                            </button>
                        </form>
                    </div>
                </div>

                <!-- Modal footer -->
                <div class="modal-footer">
                    <button
                            type="button"
                            class="btn btn-danger"
                            data-bs-dismiss="modal"
                    >
                        닫기
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function naverLogin() {
        const url =
            "/oauth2/authorization/naver";
        window.open(
            url,
            "네이버 로그인",
            "width=800,height=650,left=500,top=200"
        );
    }
    function kakaoLogin() {
        const url =
            "/oauth2/authorization/kakao";
        window.open(
            url,
            "카카오 로그인",
            "width=800,height=650,left=500,top=200"
        );
    }

    function googleLogin() {
        const url =
            "/oauth2/authorization/google";
        window.open(
            url,
            "구글 로그인",
            "width=800,height=650,left=500,top=200"
        );
    }

    function oninputPhone(target) {
        target.value = target.value
            .replace(/[^0-9]/g, '')
            .replace(/(^02.{0}|^01.{1}|[0-9]{3,4})([0-9]{3,4})([0-9]{4})/g, "$1-$2-$3");
    }

    document.getElementById('join_username').addEventListener('keyup', function() {
        const username = document.getElementById('join_username').value;

        fetch('/auth/checkId', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({username: username}),
        })
            .then(response => response.json())
            .then(data => {
                if (data.duplicate) {
                    document.getElementById('check_msg').classList.add("text-primary")
                    document.getElementById('check_msg').classList.remove("text-danger")
                    document.getElementById('check_msg').innerText = "유효한 아이디 입니다";
                } else {
                    document.getElementById('check_msg').classList.remove("text-primary")
                    document.getElementById('check_msg').classList.add("text-dangerz")
                    document.getElementById('check_msg').innerText = "중복된 아이디입니다.";
                }
            })
            .catch((error) => {
                console.error('Error:', error);
            });
    });
</script>
</body>
</html>
