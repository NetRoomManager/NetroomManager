<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link rel="stylesheet" type="text/css" href="/css/style.css"/>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
            rel="stylesheet"
    />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <title>로그인</title>
    <style type="text/css">
        html {
            font-family: "AppleSDGothicNeoR00", "Noto Sans KR", "맑은 고딕";
        }

        .hidden {
            display: none;
        }

        @charset "utf-8";
        /* ---- reset ---- */
        body {
            margin: 0;
            font: normal 75% Arial, Helvetica, sans-serif;
        }

        canvas {
            display: block;
            vertical-align: bottom;
        }

        /* ---- particles.js container ---- */
        #particles-js {
            position: absolute;
            width: 100%;
            height: 100%;
            background-color: #28455f;
            background-image: url("");
            background-repeat: no-repeat;
            background-size: cover;
            background-position: 50% 50%;
        }

        /* ---- stats.js ---- */
        .count-particles {
            background: #000022;
            position: absolute;
            top: 48px;
            left: 0;
            width: 80px;
            color: #13E8E9;
            font-size: .8em;
            text-align: left;
            text-indent: 4px;
            line-height: 14px;
            padding-bottom: 2px;
            font-family: Helvetica, Arial, sans-serif;
            font-weight: bold;
        }

        .js-count-particles {
            font-size: 1.1em;
        }

        #stats, .count-particles {
            -webkit-user-select: none;
            margin-top: 5px;
            margin-left: 5px;
        }

        #stats {
            border-radius: 3px 3px 0 0;
            overflow: hidden;
        }

        .count-particles {
            border-radius: 0 0 3px 3px;
        }
    </style>
</head>
<!-- 바디에 다크모드 -->
<body data-bs-theme="dark">
<div id="particles-js" style="z-index: -1"></div>
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
                <%--@declare id="username"--%><input
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
                        name="password"
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
                        <form action="/auth/join" method="post" id="joinForm">
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
                                        placeholder="Enter email"
                                        name="email"
                                        required
                                />
                                <label for="email">이메일</label>
                            </div>
                            <div class="form-floating mt-3 mb-3">
                                <input
                                        type="text"
                                        class="form-control"
                                        id="authNumber"
                                        placeholder="인증번호 입력"
                                        name="authNumber"
                                        required
                                />
                                <label for="authNumber">인증번호 입력</label>
                            </div>

                            <div class="form-floating mt-3 mb-3">
                                <input
                                        type="button"
                                        class="form-control"
                                        id="sendAuthNumber"
                                        value="인증번호 발송"
                                        name="sendAuthNumber"
                                />
                                <input
                                        type="button"
                                        class="form-control"
                                        id="authNumberCheck"
                                        value="인증번호 확인"
                                        name="authNumberCheck"
                                />
                                <span id="check_authNumber"></span>
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

                            <div class="form-floating mb-3 mt-3">
                                <input type="text" class="form-control" id="lol_nick"
                                       placeholder="리그오브레전드 닉네임" name="lol_nick"/> <label
                                    for="lol_nick">리그오브레전드 닉네임(선택)</label>
                            </div>

                            <button
                                    type="submit"
                                    class="btn btn-primary"
                                    id="joinSubmit"
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

    document.getElementById('join_username').addEventListener('keyup', function () {
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
                    document.getElementById('check_msg').classList.add("text-danger")
                    document.getElementById('check_msg').innerText = "중복된 아이디입니다.";
                }
            })
            .catch((error) => {
                console.error('Error:', error);
            });
    });
</script>

<script>
    /* 이메일 보내기 */
    const sendAuthNumber = document.getElementById('sendAuthNumber')
    sendAuthNumber.onclick = function (event){
        const url = '${cpath}/auth/sendAuthNumber'
        const email = document.getElementById('email')

        if(email.value === ''){
            alert('인증번호를 받을 이메일을 입력해주세요')
            email.focus()
            return
        }
        fetch(url + '?email=' + email.value)
            .then(resp => resp.text())
            .then(text => {
                alert(text)
            })
    }

    // 인증번호 확인
    document.getElementById('authNumberCheck').addEventListener('click',function(){
        const authNumber = document.getElementById('authNumber').value//입력받은 인증번호
        const joinSubmit = document.getElementById('joinSubmit')//입력받은 인증번호
        if(authNumber === ''){
            document.getElementById('check_authNumber').classList.remove("text-primary")
            document.getElementById('check_authNumber').classList.add("text-danger")
            document.getElementById('check_authNumber').innerText = "인증번호를 입력하세요";
            joinSubmit.disabled = true;
            alert('인증번호를 입력하세요')
        }


        fetch('/auth/checkAuthNumber',{
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({authNumber: parseInt(authNumber)})
        })
            .then(resp => resp.json())
            .then(data => {
                console.log(data)
                if(data.emailCheck) {
                    document.getElementById('check_authNumber').classList.add("text-primary")
                    document.getElementById('check_authNumber').classList.remove("text-danger")
                    document.getElementById('check_authNumber').innerText = "인증번호 확인";
                    joinSubmit.disabled = false;
                }else{
                    document.getElementById('check_authNumber').classList.remove("text-primary")
                    document.getElementById('check_authNumber').classList.add("text-danger")
                    document.getElementById('check_authNumber').innerText = "인증번호 오류";
                    joinSubmit.disabled = true;
                    alert('인증번호를 다시 입력해주세요')
                }

            })
            .catch((error) => {
                console.error('Error : ',error)
            })
    })

    document.getElementById('joinSubmit').addEventListener('click', function(event) {
        const check_authNumberText = document.getElementById('check_authNumber').innerText
        if(check_authNumberText !== '인증번호 확인'){
            event.preventDefault();
            alert('인증번호 확인을 해주세요.')
        }
        if(check_authNumberText === ''){
            event.preventDefault();
            alert('인증번호 확인을 해주세요.')
        }
    })

</script>
</body>
</html>
