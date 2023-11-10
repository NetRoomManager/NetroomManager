<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="header.jsp" %>
<!-- PC방 고객 메인 페이지 -->

<style>
    /* 모달 창의 기본 스타일 */
    .main_chat_modal {
        display: none;
        position: fixed;
        z-index: 10;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgba(0, 0, 0, 0.4);
    }

    /* 모달 컨텐츠의 스타일 */
    .main_chat_modal_content {
        background-color: #fefefe;
        margin: 15% 0% 15% 60%;
        padding: 20px;
        border: 1px solid #888;
        width: 25%;
    }

    /* 닫기 버튼의 스타일 */
    .chat_modal_close {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
    }

    .close:hover, .close:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
    }

    .image-container {
        position: relative;
        display: inline-block;
    }

    .image-container img {
        display: block;
        width: 100%;
        height: auto;
        transition: filter 0.3s ease;
    }

    .image-container:hover img {
        filter: brightness(50%);
    }

    .text-overlay {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        color: white;
        font-size: 24px;
        font-weight: bold;
        opacity: 0;
        transition: opacity 0.3s ease;
    }

    .image-container:hover .text-overlay {
        opacity: 1;
    }

    .image-container2 {
        position: relative;
        display: inline-block;
    }

    .image-container2 img {
        display: block;
        width: 100%;
        height: auto;
        transition: filter 0.3s ease;
    }

    .image-container2:hover img {
        filter: brightness(50%);
    }

    .text-overlay2 {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        color: white;
        font-size: 12px;
        font-weight: bold;
        opacity: 0;
        transition: opacity 0.3s ease;
    }

    .image-container2:hover .text-overlay2 {
        opacity: 1;
    }


    .chat_box {
        overflow-y: auto;
        height: 500px; /* 채팅창의 높이를 원하는 값으로 설정해주세요. */
    }

    .chat_message {
        margin: 10px;
    }

    .chat_message.from {
        text-align: right;
        background-color: #d2d2d2;
        border-radius: 10px;
        margin: 10px;
        padding: 10px;    }

    .chat_message.to {
        text-align: left;
        background-color: #eaeaea;
        border-radius: 10px;
        margin: 10px;
        padding: 10px;    }

    .game_modal {
        display: none; /* Hidden by default */
        position: fixed; /* Stay in place */
        z-index: 5; /* Sit on top */
        padding-top: 200px; /* Location of the box */
        left: 0;
        top: 0;
        width: 100%; /* Full width */
        height: 100%; /* Full height */
        overflow: auto; /* Enable scroll if needed */
        background-color: rgb(0, 0, 0); /* Fallback color */
        background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
    }

    .game_modal-content {
        background-color: #fefefe;
        margin: auto;
        padding: 20px;
        border: 1px solid #888;
        border-radius: 10px;
        width: 60%;
        height: 60%;
    }

    .game_close {
        color: #aaaaaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
    }

    .game_close:hover,
    .game_close:focus {
        color: #000;
        text-decoration: none;
        cursor: pointer;
    }

    .game-images {
        width: 100%;
        display: flex;
        flex-wrap: wrap;
        justify-content: start;
    }

    .game-images > a {
        width: 10%;
        height: auto;
        padding: 10px;
    }

    .game-image {
        width: 100%;
        height: auto;
        object-fit: cover;
    }


    /* 내 정보 modal 창 여닫기*/
    .mypage_modal {
        display: none;
        position: fixed;
        z-index: 1;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0,0,0,0.7);
    }

    .mypage_modal-content {
        background-color: #fefefe;
        margin: 10% auto;
        padding: 20px;
        border: 1px solid #888;
        width: 350px;
        height: 600px;
        max-width: 400px;
    }

    .mypage_close {
        color: #aaaaaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
        cursor: pointer;
    }

    /* 모달 창을 닫는 스타일 */
    .mypage_close:hover {
        color: #000;
    }
    /* 입력 필드 스타일 */
    input[type="text"],
    input[type="password"] {
        width: 100%;
        padding: 10px;
        margin: 5px 0;
    }
</style>


<header class="position-fixed w-100 mx-auto">
    <div class="header_box">
        <div class="charge_btn header_btn">
            <i class="fa-solid fa-hourglass-start"></i> &nbsp;&nbsp;&nbsp;
            <p>요금제 충전</p>
        </div>
        <div class="food_btn header_btn">
            <i class="fa-solid fa-burger"></i> &nbsp;&nbsp;&nbsp;
            <p>먹거리 주문</p>
        </div>
        <div class="header_btn">
            <i class="fa-solid fa-power-off"></i> &nbsp;&nbsp;&nbsp;
            <p id="main_close_btn"
               data-bs-target="#end_of_user">사용종료</p>
        </div>
    </div>
</header>

<!-- 시간정보 등등 -->
<div class="info" style="z-index: 3">
    <div class="title">
        <p class="p-0 mx-0 my-0">netroom ITBANK</p>
        <button id="btn_hidden">
            <i class="fa-solid fa-x" style="color: #ffffff; cursor: pointer;"></i>
        </button>
    </div>
    <div class="pc_number">
        <div class="seat_number">
            <p class="p-0 mx-0 my-0">
                no.<span>29</span>
            </p>
        </div>
        <a href="#">자리이동</a> <a href="#"> <i class="fa-solid fa-power-off"
                                             style="color: #ffffff;"></i> &nbsp;&nbsp;
        <p class="p-0 mx-0 my-0" id="close_btn">사용종료</p>
    </a>
    </div>

    <div class="username">
        <p class="p-0 mx-0 my-0">
            ID <span>${user.username}</span>
        </p>
        <p class="p-0 mx-0 my-0">회원정보</p>
    </div>
    <div class="time_wrap">
        <div class="start_date">
            <p class="p-0 mx-0 my-0">시작날짜</p>
            <p class="p-0 mx-0 my-0">${userLog.loginAt}</p>
        </div>
        <div class="usage_time">
            <p class="p-0 mx-0 my-0">사용시간</p>
            <p class="p-0 mx-0 my-0">${usingTime}</p>
        </div>
        <div class="remain_time">
            <p class="p-0 mx-0 my-0">남은시간</p>
            <p class="p-0 mx-0 my-0">${remainingTime}</p>
        </div>
    </div>
    <div class="consumption">
        <div class="food_order">
            <a href="/customer/order/1">먹거리 주문</a>
        </div>
        <div class="pc_ticket">
            <a href="/auth/buyTicket">PC방 이용권</a>
        </div>
        <div class="tire">
            <p class="p-0 mx-0 my-0">${user.tire}</p>
        </div>
        <div class="kakaopay">
            <a href="#"> <img src="/img/kakao-pay.png" alt="카카오페이">
            </a>
        </div>

    </div>
    <div class="service">
        <a href="#">호출</a> <a onclick="openChatModal(); getMessages(); msgDel();" style="color: #eee;">메시지</a>
        <a href="#">주문 목록</a> <a id="my_info" href="#">내 정보</a>
    </div>

    <!--  내 정보 모달  -->
    <div id="myModal" class="mypage_modal">
        <div class="mypage_modal-content mt-5 p-3">
            <div style="font-weight: bold;">
                <h4>내 정보 확인/비밀번호 수정</h4>
                <span class="mypage_close">&times;</span>
            </div>
            <input type="text" id="name" placeholder="이름" value="${principal.name }" readonly>
            <input type="text" id="username" placeholder="아이디" value="${username }" readonly>
                <label for="birthday" style="font-weight: bold; ">생년월일</label>
                <input type="date" id="birthday" name="birth" value="${principal.user.birth}" style="width: 200px; height: 35px;" readonly>
                <input type="text" id="email" placeholder="이메일" value="${principal.email}" name="email" readonly>
            <form action="#" method="POST">
                <input type="password" placeholder="기존 패스워드" name="password">
                <input type="password" placeholder="변경 할 패스워드" name="newPassword">
                <input type="submit" value="비밀번호 수정" class="btn btn-warning" disabled>
            </form>

        </div>
    </div>

    <!-- 게임메뉴 -->
    <div class="game_menu_wrap">
        <div class="game_menu">
            <div id="war_image">
                <img src="/img/game-menu01.ico" alt="냥코대전쟁">
                <p class="p-0 mx-0 my-0">냥코대전쟁</p>
            </div>
            <div id="roblox_image">
                <img src="/img/game-menu02.ico" alt="로블록스">
                <p class="p-0 mx-0 my-0">로블록스</p>
            </div>
            <div id="mafia_image">
                <img src="/img/game-menu03.ico" alt="마피아42">
                <p class="p-0 mx-0 my-0">마피아42</p>
            </div>
            <div id="fifa_image">
                <img src="/img/game-menu04.ico" alt="피파4M">
                <p class="p-0 mx-0 my-0">피파4M</p>
            </div>
            <div id="among_image">
                <img src="/img/game-menu05.ico" alt="어몽어스">
                <p class="p-0 mx-0 my-0">어몽어스</p>
            </div>
            <div id="maple_image">
                <img src="/img/game-menu06.ico" alt="메이플스토리">
                <p class="p-0 mx-0 my-0">메이플스토리</p>
            </div>
        </div>
        <div class="advertisement">
            <div class="main_advertisement">
                <div class="logoRight">
                    <!-- Carousel -->
                    <div id="main_ad" class="carousel slide" data-bs-ride="carousel">

                        <!-- Indicators/dots -->
                        <div class="carousel-indicators">
                            <button type="button" data-bs-target="#main_ad"
                                    data-bs-slide-to="0" class="active"></button>
                            <button type="button" data-bs-target="#main_ad"
                                    data-bs-slide-to="1"></button>
                            <button type="button" data-bs-target="#main_ad"
                                    data-bs-slide-to="2"></button>
                        </div>


                        <!-- The slideshow/carousel -->
                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <img src="/img/pc방 광고.jpg" alt="logo1" class="d-block"
                                     style="width: 345px; height: 315px;">
                            </div>
                            <div class="carousel-item">
                                <img src="/img/pc방 광고2.jpg" alt="logo2" class="d-block"
                                     style="width: 345px; height: 315px;">
                            </div>
                        </div>


                        <!-- Left and right controls/icons -->
                        <button class="carousel-control-prev" type="button"
                                data-bs-target="#main_ad" data-bs-slide="prev">
                            <span class="carousel-control-prev-icon"></span>
                        </button>
                        <button class="carousel-control-next" type="button"
                                data-bs-target="#main_ad" data-bs-slide="next">
                            <span class="carousel-control-next-icon"></span>
                        </button>
                    </div>
                </div>
            </div>
            <div class="sub_advertisement">
                <img src="/img/nuguri.webp" alt="너굴맨"> <img
                    src="/img/nuguri.webp" alt="너굴맨">
            </div>
        </div>
    </div>
    <div class="information">
        <a href="#">이용약관</a> <a href="#">개인정보처리방침</a> <a href="#">버전정보</a>
    </div>
</div>

<div class="position-fixed h-50 bg-secondary rounded"
     style="top: 40%; left: 10%; width: 60%">
    <div class="h-75">
        <div class="d-flex h-100">
            <div id="popular" onclick="openGameModal(this.id)"
                 class="col-sm  text-white p-3 rounded mx-1 my-1 bg-primary  image-container"
                 style="border: 1px solid black;">
                <img src="/img/lol.jpg" class="w-100"/>
                <div class="text-overlay">인기게임</div>
            </div>
            <div id="rpg" onclick="openGameModal(this.id)"
                 class="col-sm  text-white p-3 rounded mx-1 my-1 bg-warning image-container"
                 style="border: 1px solid black;">
                <img src="/img/rpg.jpg" class="w-100"/>
                <div class="text-overlay">RPG</div>
            </div>
            <div id="cd" onclick="openGameModal(this.id)"
                 class="col-sm  text-white p-3 rounded mx-1 my-1 bg-danger image-container"
                 style="border: 1px solid black;">
                <img src="/img/starcraft.jpg" class="w-100"/>
                <div class="text-overlay">CD게임</div>
            </div>
            <div id="fps" onclick="openGameModal(this.id)"
                 class="col-sm   text-white p-3 rounded mx-1 my-1 bg-info image-container"
                 style="border: 1px solid black;">
                <img src="/img/battleground.webp" class="w-100"/>
                <div class="text-overlay">FPS게임</div>
            </div>
        </div>
    </div>
    <div class="d-flex h-25">
        <div id="aki"
                class="col-sm bg-dark text-white p-3 rounded mx-1 my-1 image-container2">
            <img src="/img/archeage.jpg" class="w-100">
            <div class="text-overlay2">아키에이지</div>
        </div>
        <div id="item_mania"
                class="col-sm bg-dark text-white p-3 rounded mx-1 my-1 image-container2">
            <img src="/img/itemmania.png " class="w-100">
            <div class="text-overlay2">아이템매니아</div>
        </div>
        <div id="item_bay"
                class="col-sm bg-dark text-white p-3 rounded mx-1 my-1 image-container2">
            <img src="/img/itembay.jpg " class="w-100">
            <div class="text-overlay2">아이템베이</div>
        </div>
        <div id="cart"
                class="col-sm bg-dark text-white p-3 rounded mx-1 my-1 image-container2">
            <img src="/img/kartrider.jpg " class="w-100">
            <div class="text-overlay2">카트라이더</div>
        </div>
        <div id="poe"
                class="col-sm bg-dark text-white p-3 rounded mx-1 my-1 image-container2">
            <img src="/img/poe.png" class="w-100">
            <div class="text-overlay2">POE</div>
        </div>
        <div id="world_of"
                class="col-sm bg-dark text-white p-3 rounded mx-1 my-1 image-container2">
            <img src="/img/worldofwarship.jpg" class="w-100">
            <div class="text-overlay2">월오브워쉽</div>
        </div>
        <div id="netflix"
                class="col-sm bg-dark text-white p-3 rounded mx-1 my-1 image-container2">
            <img src="/img/netflix.jpg" class="w-100">
            <div class="text-overlay2">넷플릭스</div>
        </div>
    </div>
</div>

<div id="alert" style="display: none;">새로운 메시지가 도착했습니다!</div>

<!-- 모달 창 -->
<div id="main_chat_modal" class="main_chat_modal">
    <div class="main_chat_modal_content rounded">
        <span>관리자에게 보낼 메시지</span>
        <h1 class="main_chat_modal_close" id="main_chat_modal_close"
            style="text-align: end;" onclick="closeChatModal()">&times;</h1>

        <!-- 채팅 인터페이스 -->
        <div id="chat_box"
             style="height: 300px; border: 1px solid #ccc; padding: 10px; overflow: auto;">
            <!-- 채팅 메시지가 여기에 표시됩니다 -->
        </div>


        <div class="d-flex">
            <input type="hidden" value="admin" id="to">
            <input class="input mt-1" type="text" id="message"
                   placeholder="채팅 내용을 입력하세요" style="width: 80%">
            <button type="button" class="btn btn-primary mt-1 mx-3"
                    style="width: 15%" onclick="send()">전송
            </button>
        </div>
    </div>
</div>

<!-- 모달 창 -->
<div id="game_Modal" class="game_modal">
    <div class="game_modal-content">
        <span class="game_close">&times;</span>
        <div class="gameContent"></div>
    </div>
</div>

<script>
    const charge_btn = document.querySelector(".charge_btn");
    const food_btn = document.querySelector(".food_btn");

    // 요금제 충전 버튼 눌렀을 때, 페이지 이동
    charge_btn.addEventListener('click', function(){
        window.location.href="/auth/buyTicket";
    })

    // 먹거리 버튼 눌렀을 때, 페이지 이동
    food_btn.addEventListener('click', function() {
        window.location.href="/customer/order/1";
    })


    // 이미지를 클릭하면 새 창에서 URL 열도록 JavaScript 코드
    var imageElement = document.getElementById('mafia_image');
    imageElement.addEventListener('click', function() {
        var url = 'https://mafia42.com/#/';
        window.open(url, '_blank'); // 이미지 클릭 시 URL을 새 창에서 열기
    });

    var imageElement = document.getElementById('war_image');
    imageElement.addEventListener('click', function() {
        var url = 'https://play.google.com/store/apps/details?id=jp.co.ponos.battlecatskr&hl=ko&gl=US';
        window.open(url, '_blank');
    })

    var imageElement = document.getElementById('roblox_image');
    imageElement.addEventListener('click', function() {
        var url = 'https://www.roblox.com/';
        window.open(url, '_blank');
    })

    var imageElement = document.getElementById('fifa_image');
    imageElement.addEventListener('click', function() {
        var url = 'https://fconline.nexon.com/main/index';
        window.open(url, '_blank');
    })

    var imageElement = document.getElementById('among_image');
    imageElement.addEventListener('click', function() {
        var url = 'https://store.epicgames.com/ko/p/among-us';
        window.open(url, '_blank');
    })

    var imageElement = document.getElementById('maple_image');
    imageElement.addEventListener('click', function() {
        var url = 'https://maplestory.nexon.com/Home/Main';
        window.open(url, '_blank');
    })

    var imageElement = document.getElementById('aki');
    imageElement.addEventListener('click', function() {
        var url = 'https://game.naver.com/lounge/Archeage/home';
        window.open(url, '_blank');
    })

    var imageElement = document.getElementById('item_mania');
    imageElement.addEventListener('click', function() {
        var url = 'http://www.itemmania.com/';
        window.open(url, '_blank');
    })

    var imageElement = document.getElementById('item_bay');
    imageElement.addEventListener('click', function() {
        var url = 'https://www.itembay.com/?NaPm=ct%3Dlogy2uwa%7Cci%3Dcheckout%7Ctr%3Dds%7Ctrx%3Dnull%7Chk%3D9b0c5d6735a0d8ec7b908d6c4f23bccedc77d576';
        window.open(url, '_blank');
    })

    var imageElement = document.getElementById('cart');
    imageElement.addEventListener('click', function() {
        var url = 'https://kartdrift.nexon.com/kartdrift/ko/event/20230914/intro';
        window.open(url, '_blank');
    })

    var imageElement = document.getElementById('poe');
    imageElement.addEventListener('click', function() {
        var url = 'https://poe.game.daum.net/';
        window.open(url, '_blank');
    })

    var imageElement = document.getElementById('world_of');
    imageElement.addEventListener('click', function() {
        var url = 'https://worldofwarships.asia/ko/?pub_id=worldofwarships&sid=SIDgTHN0GP1ic8l_V9eLxyDnMfWfgxGHB2l1pwnepxvzoIP7NfJOnxB80SdHsoLV8_EvceE1O9RNY5w2eaDY_D-tBDjrlblgAqpbraBANr4q_D2jo_yEid6psYPxo3kzZTogbv5sNPgjVSK&enctid=cwo75h2z9uz1&lpsn=WOWS+APAC+Portal&foris=1&teclient=1698915131924951153';
        window.open(url, '_blank');
    })

    var imageElement = document.getElementById('netflix');
    imageElement.addEventListener('click', function() {
        var url = 'https://www.netflix.com/kr/';
        window.open(url, '_blank');
    })


    const game_modal = document.getElementById("game_Modal");

    // 모달 창을 띄우는 함수
    function openGameModal(id) {
        var gameContent = document.querySelector('.gameContent');

        switch (id) {
            case 'popular':
                gameContent.innerHTML = `
                <h3>인기 게임 목록</h3>
                <div class="game-images">
                    <a href="https://www.leagueoflegends.com/ko-kr/" target="_blank"><img src="https://i.namu.wiki/i/Q2yS7PKGww04abPtNFHLS8npW_L0evvVmQkxqB0iRWA934Ecsea8rZPVZwh0eKJhj_quAfgLTCusaHCa4XVU2w.webp" class="game-image" />
                       <span>리그오브레전드</span></a>
                    <a href="https://playvalorant.com/ko-kr/" target="_blank">
                        <img src="https://play-lh.googleusercontent.com/KV6LJhKnHyzT_Zlr76Qac4IG8PRqK9r-2-CCf-4zs1XDLfKSWUmkNbZlnL64IZVMzg=w240-h480-rw" class="game-image" />
                        <span>발로란트</span>
                    </a>
                    <a href="https://lostark.game.onstove.com/" target="_blank">
                        <img src="https://admin.youngjaecomputer.com/data/design2/CombiThumbnail_YC41" class="game-image" />
                        <span>로스트아크</span>
                    </a>
                    <a href="https://starcraft.blizzard.com/ko-kr/" target="_blank">
                        <img src="https://macin.files.wordpress.com/2010/07/starcraft-ii-icon.png" class="game-image" />
                        <span>스타크래프트</span>
                    </a>
                </div>
			`;
                break;
            case 'rpg':
                gameContent.innerHTML = `
                <h3>RPG 게임 목록</h3>
                <div class="game-images">
                    <a href="https://www.leagueoflegends.com/ko-kr/" target="_blank"><img src="https://i.namu.wiki/i/Q2yS7PKGww04abPtNFHLS8npW_L0evvVmQkxqB0iRWA934Ecsea8rZPVZwh0eKJhj_quAfgLTCusaHCa4XVU2w.webp" class="game-image" />
                       <span>리그오브레전드</span></a>
                    <a href="https://df.nexon.com/pg/duskyisland?intro=yes" target="_blank">
                        <img src="https://play-lh.googleusercontent.com/2_M3GXptvR4z83AuWce9xAKKKhCOEZLVOeediIMRSe5hcKApDmLVefT9q8xpZZrWTB0" class="game-image" />
                        <span>던전앤파이터</span>
                    </a>
                    <a href="https://lostark.game.onstove.com/" target="_blank">
                        <img src="https://admin.youngjaecomputer.com/data/design2/CombiThumbnail_YC41" class="game-image" />
                        <span>로스트아크</span>
                    </a>
                    <a href="https://aion.plaync.com/conts/2023/231024_update" target="_blank">
                        <img src="https://is1-ssl.mzstatic.com/image/thumb/Purple128/v4/e3/39/e0/e339e004-a03a-cbfc-7a35-f90c871bdd21/source/512x512bb.jpg" class="game-image" />
                        <span>아이온</span>
                    </a>
                </div>
			`;
                break;
            case 'fps':
                gameContent.innerHTML = `
                <h3>FPS 게임 목록</h3>
                <div class="game-images">
                    <a href="https://playvalorant.com/ko-kr/" target="_blank">
                        <img src="https://play-lh.googleusercontent.com/KV6LJhKnHyzT_Zlr76Qac4IG8PRqK9r-2-CCf-4zs1XDLfKSWUmkNbZlnL64IZVMzg=w240-h480-rw" class="game-image" />
                        <span>발로란트</span>
                    </a>
                    <a href="https://sa.nexon.com/" target="_blank">
                        <img src="https://img1.daumcdn.net/thumb/R800x0/?scode=mtistory2&fname=https%3A%2F%2Ft1.daumcdn.net%2Fcfile%2Ftistory%2F232C4D4255432FAE0E" class="game-image" />
                        <span>서든어택</span>
                    </a>
                    <a href="https://overwatch.blizzard.com/ko-kr/" target="_blank">
                        <img src="https://upload.wikimedia.org/wikipedia/commons/5/55/Overwatch_circle_logo.svg" class="game-image" />
                        <span>오버워치2</span>
                    </a>
                    <a href="https://pubg.game.daum.net/pubg/index.daum" target="_blank">
                        <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVIz5acMtpZp3LmVC-gylRRcNk0F83qRtp6Q&usqp=CAU" class="game-image" />
                        <span>배틀그라운드</span>
                    </a>
                </div>
			`;
                break;
            case 'cd':
                gameContent.innerHTML = `
                <h3>CD 게임 목록</h3>
                <div class="game-images">
                    <a href="https://www.rockstargames.com/kr/gta-v" target="_blank">
                       <img src="https://img.gta5-mods.com/q95/images/modded-cooler-gta-5-loading-screen-logo/3df0c9-2fe3a8abf83fdb39b09765ec00485e0c.png" class="game-image" />
                       <span>GTA</span>
                    </a>
                    <a href="https://store.epicgames.com/ko/p/among-us" target="_blank">
                        <img src="https://o.qoo-img.com/ggpht/8ddL1kuoNUB5vUvgDVjYY3_6HwQcrg1K2fd_R8soD-e2QYj8fT9cfhfh3G0hnSruLKec" class="game-image" />
                        <span>어몽어스</span>
                    </a>
                    <a href="https://pubg.game.daum.net/pubg/index.daum" target="_blank">
                        <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVIz5acMtpZp3LmVC-gylRRcNk0F83qRtp6Q&usqp=CAU" class="game-image" />
                        <span>배틀그라운드</span>
                    </a>
                    <a href="https://fallguys.com/ko?lang=ko" target="_blank">
                        <img src="https://cdn1.epicgames.com/offer/50118b7f954e450f8823df1614b24e80/EGS_FallGuys_Mediatonic_IC1_400x400-87f5f19c4955718799dd4f5724889c9d_400x400-87f5f19c4955718799dd4f5724889c9d?h=270&quality=medium&resize=1&w=480" class="game-image" />
                        <span>폴가이즈</span>
                    </a>
                    <!-- 추가 게임 이미지... -->
                </div>
			`;
                break;
            default:
                break;
        }

        game_modal.style.display = "block";
    }


    // 모달 창을 닫는 함수
    function closeModal() {
        game_modal.style.display = "none";
    }

    // x 버튼을 클릭하면 모달 창이 닫히도록 이벤트 리스너를 추가합니다.
    document.getElementsByClassName("game_close")[0].onclick = function () {
        closeModal();
    }

    // 사용자가 모달 창 외부를 클릭하면 모달 창이 닫히도록 이벤트 리스너를 추가합니다.
    window.onclick = function (event) {
        if (event.target == game_modal) {
            closeModal();
        }
    }


    //모달 열기
    document.getElementById("my_info").addEventListener("click", function() {
        var modal = document.getElementById("myModal");
        modal.style.display = "block";
    });

    // 모달 닫기
    document.getElementsByClassName("mypage_close")[0].addEventListener("click", function() {
        var modal = document.getElementById("myModal");
        modal.style.display = "none";
    });

    // 모달 외부 클릭 시 모달 닫기
    window.addEventListener("click", function(event) {
        var modal = document.getElementById("myModal");
        if (event.target === modal) {
            modal.style.display = "none";
        }
    });


    const infoDiv = document.querySelector(".info");
    const titleDiv = document.querySelector('.title');
    const infoHeight = infoDiv.style.height;

    const infoList = document.querySelectorAll('.info > div:not(.title)');
    const hiddenBtn = document.getElementById('btn_hidden');
    const modal = document.getElementById('main_chat_modal');

    const msgBtn = document.getElementById('msgBtn');

    hiddenBtn.onclick = () => {
        console.log('123');
        infoList.forEach(div => {
            console.log(div);
            let cl = div.classList;
            console.log(cl);
            if (cl.contains('hidden')) {
                div.classList.remove('hidden');
                infoDiv.style.height = '700px';
            } else {
                div.classList.add('hidden');
                infoDiv.style.height = '30px';
            }
        })
    }

    // 모달창 여는 함수
    function openChatModal() {
        console.log("123");
        modal.style.display = 'inline-block';
    }

    function closeChatModal() {
        modal.style.display = 'none';
    }


    // 자리이동 눌렸을 때, 알림창 만들기
    document.getElementById('').addEventListener('click', function () {
        alert('원하는 좌석에서 로그인하세요!')
    });

	document.getElementById('main_close_btn').addEventListener('click', function () {
		var countdownElement = document.getElementById('countdown');
		var countdownValue = 5; // 3초 카운트다운

		// 카운트다운 함수
		function startCountdown() {
			countdownElement.textContent = countdownValue;
			countdownValue--;

			if (countdownValue < -1) {
				// 시간이 다 되면 모달을 닫고 메시지 표시
				$('#end_of_user').modal('hide');
				alert('컴퓨터가 종료됩니다.');
			} else if (countdownValue === -1) {
				// 로그인폼으로
				location.href = "${cpath}/auth/loginForm.jsp";
			}
			else {
				setTimeout(startCountdown, 1000);
			}
		}

		startCountdown(); // 카운트다운 시작
	});
</script>
<!-- javaScript -->
<script src="/js/script.js"></script>




<script>
    window.addEventListener("DOMContentLoaded", function () {
        const usingTimeElement = document.querySelector(".usage_time p:nth-child(2)");
        const remainingTimeElement = document.querySelector(".remain_time p:nth-child(2)");

        let usingTime = parseInt(usingTimeElement.textContent);
        let remainingTime = parseInt(remainingTimeElement.textContent);

        console.log(usingTimeElement);

        setInterval(function () {
            usingTime++;
            remainingTime--;
            usingTimeElement.textContent = formatTime(usingTime);
            remainingTimeElement.textContent = formatTime(remainingTime);
        }, 1000);

			 function formatTime(param) {

				 // 3분남음
				 if (remainingTime===300) {
					const audio = new Audio('/audio/5.mp3');
					audio.play();
				 }
				 // 5분 남음
				 else if (remainingTime===180) {
					 const audio = new Audio('/audio/3.mp3');
					 audio.play();
				 }

				 let hours = Math.floor(param / 3600);
				 let minutes = Math.floor((param % 3600) / 60);
				 let seconds = param % 60;

            return hours + "시간 " + minutes + "분 " + seconds + "초";
        }
    });

    const close_btn = document.getElementById('close_btn');
    close_btn.addEventListener('click', function () {
        if (confirm('정말 종료하시겠습니까?')) {
            location.href = '/auth/logout';
        }
    })

    const close_btn2 = document.getElementById('main_close_btn');
    close_btn2.addEventListener('click', function () {
        if (confirm('정말 종료하시겠습니까?')) {
            location.href = '/auth/logout';
        }
    })
</script>



</body>
</html>