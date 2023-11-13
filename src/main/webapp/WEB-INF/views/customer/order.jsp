<%--
  Created by IntelliJ IDEA.
  User: kgitbank07
  Date: 2023-10-27
  Time: 오후 5:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 세션에서 SecurityContext를 가져옵니다. -->
<c:set var="securityContext" value="${sessionScope.SPRING_SECURITY_CONTEXT}"/>

<!-- SecurityContext에서 Authentication 객체를 가져옵니다. -->
<c:set var="authentication" value="${securityContext.authentication}"/>

<!-- Authentication 객체에서 Principal(사용자) 정보를 가져옵니다. -->
<c:set var="principal" value="${authentication.principal}"/>

<!-- Principal에서 사용자의 이름을 가져옵니다. -->
<c:set var="username" value="${principal.username}"/>

<!-- Principal에서 사용자의 이름을 가져옵니다. -->
<c:set var="useremail" value="${principal.email}"/>


<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/css/style.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <!-- jQuery -->
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <!-- iamport.payment.js -->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
    <title>order</title>
</head>

<body class="text-bg-dark">

<div id="top" class="container text-decoration-none w-70">

    <!-- Carousel -->
    <div id="demo" class="carousel slide" data-bs-ride="carousel">


        <!-- The slideshow/carousel -->
        <div class="carousel-inner bg-dark" style="text-align: center;">
            <div class="carousel-item active">
                <ul class="list-unstyled">
                    <li class="text-primary">
                        <p>계좌이체하시고 카운터 메세지로 문의 부탁드려요</p>
                    </li>
                </ul>
            </div>

            <div class="carousel-item">
                <ul class="list-unstyled">
                    <li class="text-primary">
                        <p>12:00 ~ 13:00시 까지는 음식 주문 안됩니다</p>
                    </li>
                </ul>
            </div>


        </div>

        <!-- Left and right controls/icons -->
        <button class="carousel-control-prev" type="button" data-bs-target="#demo" data-bs-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#demo" data-bs-slide="next">
            <span class="carousel-control-next-icon"></span>
        </button>
    </div>
</div>

<div id="selectMenu">


    <!-- 음식 종류 선택 + 검색 버튼 -->
    <div class="container-fluid d-flex text-bg-light rounded-pill" data-bs-touch="false" style="margin-left: 0;">
        <div class="inner h-25">
            <div class="list-unstyled d-flex px-5">
                <c:forEach var="dto" items="${productcategory_list}">
                    <li class="px-5 ms-5 mx-5  text-muted" style="margin-left: 300px;">
                        <a href="/customer/order/${dto.id}">
                            <button
                                    class="btn btn-primary">${dto.name}
                            </button>
                        </a>
                    </li>
                </c:forEach>
                <div id="search">
                    <input class="form-control border border-success" list="datalistOptions" id="exampleDataList"
                           placeholder="검색어를 입력하세요 🔍">
                    <datalist id="datalistOptions">
                        <option value="리얼짜장덮밥">
                        <option value="스팸마요덮밥">
                        <option value="한품 고기짬뽕">
                        <option value="낙지볶음밥...">
                        <option value="해물짬뽕">
                    </datalist>
                </div>
            </div>
        </div>
    </div>
</div>


<!-- 메뉴선택 + 주문 담기 창 -->
<div id="order" class="d-flex">
    <div id="detail_menu" class="container mt-3 d-flex flex-wrap me-0 ms-0 fw-bold">
        <c:forEach var="dto" items="${product_list}">
            <div class="w-25">
                <div class="mt-3 px-2 text-bg-light border border-info" style="width: 200px; height: 250px;">
                    <img src="/upload/${dto.img}" class="w-100 h-50">
                    <ul class="list-unstyled pt-1">
                        <li class="p_id" style="display: none">
                            ${dto.id}
                        </li>
                        <li class="pb-4 name">${dto.name}</li>
                        <li class="price">
                            <fmt:formatNumber pattern="#,###" value="${dto.price}"/>원
                        </li>

                        <li>
                            <button class="btn btn-warning w-100">담기</button>
                        </li>
                    </ul>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- 오른쪽 메뉴 장바구니 -->
    <div id="cart_btn" class="w-50 border border-primary" style="background-color: purple; height: 800px;">
        <div id="rightTop justify-content-end" style="height: 70px;">
            <ul class="d-flex list-unstyled justify-content-between mb-0">
                <!-- pc 좌석 번호 -->
                <li class="text-bg-primary" style="border-radius: 10%;">
                    <h4>PC No.71</h4>
                </li>
                <li class="list-group-item p-0 text-bg-light" style="width: 35px; border-radius: 20%;">
                    <button id="hiddenBtn" class="btn-close" aria-label="Close"
                            style="z-index: 1; width: 25px; height: 25px;"></button>
            </ul>
            <ul class="d-flex list-unstyled justify-content-between mb-0">
                <li>
                    <h4>회원</h4>
                </li>
                <li>
                    <button class="text-bg-dark">🛒주문내역 보기</button>
                </li>
            </ul>
        </div>

        <div class="middle border text-bg-light w-100">
            <!-- 주문버튼 눌렀을 때, 옮겨질 내용들 담는 곳-->
            <div id="menuSelector1" class="w-100 h-25">
                <div id="movingMenu" class="w-100 overflow-scroll" style="height: 360px;">
                </div>
            </div>
        </div>
        <!-- 총 주문 금액 옆에 금액 나오기-->
        <div id="totalPrice" class="d-flex text-bg-primary justify-content-between fs-4 fw-bold list-unstyled"
             style="height: 60px;">
            <label>총 주문 금액</label>
            <label class="d-flex"><span class="total_price">0원</span></label>
        </div>

        <!-- 결제 방식 -->
        <div id="pmBtn" class="text-bg-dark w-100" style="height: 330px;">

            <!-- 현금, kakaoPay, tossPay, KG 이니시스  -->
            <div id="chBtn" class="d-flex list-unstyled w-100">
                <ul class="d-flex list-unstyled justify-content-between mb-0">
                    <li class="ps-4 mt-3">
                        <button id="cash_btn" class=" btn btn-secondary btn-lg">현금</button>
                    </li>
                    <li class="ps-5 mt-3">
                        <button id="kakao_btn" class=" btn btn-secondary btn-lg">kakaoPay</button>
                    </li>
                    <li class="ps-5 mt-3">
                        <button id="toss_btn" class=" btn btn-secondary btn-lg">tossPay</button>
                    </li>
                    <li class="ps-5 mt-3">
                        <button id="kg_btn" class=" btn btn-secondary btn-lg">KG이니시스</button>
                    </li>
                </ul>
            </div>

            <!-- radio button 으로 선택해주기-->
            <div id="choiceBtn2" class="border border-info w-100 h-25 d-flex flex-wrap mt-3">
                <div class="form-check ms-5" style="margin-right: 100px;">
                    <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault1">
                    <label id="cell_btn1" class="form-check-label" for="flexRadioDefault1">
                        <h4>5만원</h4>
                    </label>
                </div>
                <div class="form-check" style="margin-right: 100px;">
                    <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault2"
                           checked>
                    <label id="cell_btn2" class="form-check-label" for="flexRadioDefault2">
                        <h4>1만원</h4>
                    </label>
                </div>
                <div class="form-check" style="margin-right: 100px;">
                    <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault3"
                           checked>
                    <label id="cell_btn3" class="form-check-label" for="flexRadioDefault2">
                        <h4>5천원</h4>
                    </label>
                </div>
                <div class="form-check ms-5" style="margin-right: 70px;">
                    <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault4"
                           checked>
                    <label id="cell_btn4" class="form-check-label" for="flexRadioDefault2">
                        <h4>1천원</h4>
                    </label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault5"
                           checked>
                    <label id="sell_btn5" class="form-check-label d-flex" for="flexRadioDefault2">
                        <h4 class="me-3">금액에 맞게</h4>
                        <input type="number" name="money" placeholder="0원" autofocus style="background-color: white;"
                               step="1000" min="0">
                        <input class="btn btn-primary" type="submit" value="확인">
                    </label>
                </div>
            </div>

            <!-- 요청사항 -->
            <div id="request" class="w-100 mt-2">
                <div class="input-group">
                    <input type="text" name="memo" id="memo" placeholder="요청사항은 50자 내외로 입력하세요" class="form-control"
                           style="height: 65px;">
                    <button type="button" class="btn btn-primary">확인</button>
                </div>
            </div>

            <!-- 제출 버튼 -->
            <div id="submit" class="w-100 mt-1" style="height: 60px;">
                <button type="button" class="w-100 h-100 btn btn-primary fw-bold fs-4">주문하기</button>
            </div>
        </div>
    </div>
</div>


<script>
    var IMP = window.IMP;

    document.addEventListener("DOMContentLoaded", function () {
        // 버튼과 텍스트 입력 요소 참조
        var sellBtn = document.getElementById("sell_btn5");
        var submitBtn = sellBtn.querySelector("input[type='submit']");
        var textInput = sellBtn.querySelector("input[name='money']");

        // 초기에 버튼 비활성화
        submitBtn.disabled = true;

        // #sell_btn 클릭 이벤트 처리
        sellBtn.addEventListener("click", function () {
            // 버튼을 클릭하면 입력 필드에 값이 있는 경우에만 버튼 활성화
            if (textInput.value.trim() !== "") {
                submitBtn.disabled = false;
            } else {
                submitBtn.disabled = true;
            }
        });

        // 입력 필드에 텍스트를 입력할 때 이벤트 처리
        textInput.addEventListener("input", function () {
            // 입력 필드에 값이 있는 경우에만 버튼 활성화
            if (textInput.value.trim() !== "") {
                submitBtn.disabled = false;
            } else {
                submitBtn.disabled = true;
            }
        });
    });



    pgList = ['kakaopay.TC0ONETIME', 'tosspay.tosstest', 'html5_inicis']


    const kakaoButton = document.getElementById('kakao_btn')
    const tossButton = document.getElementById('toss_btn')
    const kgButton = document.getElementById('kg_btn');

    const email = "${useremail}";
    const name = "${username}";

    console.log(email);
    console.log(name);

    // 구매자 정보
    kakaoButton.setAttribute('onclick', `pay('${email}', '${name}', 0)`)
    tossButton.setAttribute('onclick', `pay('${email}', '${name}', 1)`)
    kgButton.setAttribute('onclick', `pay('${email}', '${name}', 2)`)


    // 결제하기
    function pay(useremail, username, payId) {

        // if (confirm("구매 하시겠습니까?")) { // 구매 클릭시 한번 더 확인하기
        // if (localStorage.getItem("access")) { // 회원만 결제 가능
        // const emoticonName = document.getElementById('title').innerText

        // 랜덤문자열 대신 millisecound로 대체
        var today = new Date();
        var hours = today.getHours(); // 시
        var minutes = today.getMinutes();  // 분
        var seconds = today.getSeconds();  // 초
        var milliseconds = today.getMilliseconds();

        var makeMerchantUid = hours.toString() + minutes.toString() + seconds.toString() + milliseconds.toString();

        console.log("결제 고유번호: " + makeMerchantUid);

        IMP.init("imp64247670"); // 가맹점 식별코드

        // 요소 선택
        const element = document.querySelector(".total_price");
        // 요소의 텍스트 가져오기
        const text = element.textContent || element.innerText;  // 브라우저 호환성을 위해 두 가지 방법 사용
        const number = text.replace(/[^0-9]/g, '');  // 정규표현식을 사용해 숫자가 아닌 모든 문자를 제거
        const total = parseInt(number);

        async function paymentCallback(rsp, successCallback) { // callback
            if (rsp.success) { // 결제 성공시
                console.log(rsp);
                // 결제 성공시 프로젝트 DB저장 요청
                try {
                    await fetch("/customer/buyProduct", {
                        method: "POST",
                        headers: {
                            "Content-Type": "application/json;charset=utf-8",
                        },
                        body: JSON.stringify(rsp),
                    })
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                alert('결제 완료!');
                                while(movingMenu.firstChild) {
                                    movingMenu.removeChild(movingMenu.firstChild);
                                }
                                menuList = [];
                                updateTotalPrice();
                                successCallback(data); // data.success 값을 콜백으로 전달
                                console.log(menuList);
                                location.reload();
                            } else {
                                alert(`error:[${data.status}]결제요청이 승인된 경우 관리자에게 문의바랍니다.`);
                            }
                        })
                } catch (error) {
                    console.error("DB 저장 요청 중 오류가 발생했습니다:", error);
                }
            } else { // 결제 실패시 (아임포트에서 받는 메시지)
                alert(rsp.error_msg)
            }
        }

        IMP.request_pay({
            pg: pgList[payId], // PG사 코드표에서 선택
            pay_method: 'card', // 결제 방식
            merchant_uid: "IMP" + makeMerchantUid, // 결제 고유 번호
            name: 'NetRoom 주문 결제', // 제품명
            amount: total, // 가격
            //구매자 정보 ↓
            buyer_email: `${useremail}`,
            buyer_name: `${username}`,
            // buyer_tel : '010-1234-5678',
            // buyer_addr : '서울특별시 강남구 삼성동',
            // buyer_postcode : '123-456'
        },  res => {
            console.log('res: ' + res);
            paymentCallback(res, success => {
                // success 값을 이용하여 원하는 작업 수행
                console.log('콜백함수에 들어옴: ' + success);

                if(success.success) {
                    console.log('order_detail 추가');

                    const url = '/customer/order/addDetail';

                    fetch(url, {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json;charset=utf-8'
                        },
                        body: JSON.stringify({
                            menuList:menuList,
                            pay_method:success.pay_method,
                        }),
                    })
                        .then(res => res.text())
                        .then(data => console.log('Controller에서 받은 데이터: ' + data));

                }
            });
        });
    }

</script>


<script>

    let menuList = [];

    const menuBtn = document.querySelectorAll('#detail_menu button');
    const movingMenu = document.getElementById('movingMenu');
    const total_price = document.querySelector('.total_price');

    function updateTotalPrice() {
        const priceInputs = document.querySelectorAll('#movingMenu input[name="sell_price"]');
        const amountInputs = document.querySelectorAll('#movingMenu input[name="amount"]');
        const sumInputs = document.querySelectorAll('#movingMenu input[name="sum"]');


        let totalPrice = 0;
        for (let i = 0; i < priceInputs.length; i++) {
            const price = parseInt(priceInputs[i].value);
            const amount = parseInt(amountInputs[i].value);
            const sum = price * amount;

            sumInputs[i].value = sum; // 각 메뉴의 가격 업데이트
            totalPrice += sum; // 총 가격 계산
        }

        total_price.innerText = totalPrice + '원'; // 총 가격 업데이트

        return totalPrice;
    }

    menuBtn.forEach(e => {
        e.addEventListener('click', () => {
            let grandparent = e.parentElement.parentElement; // 부모의 부모 요소
            const name = grandparent.querySelector('.name').innerText;
            const price = grandparent.querySelector('.price').innerText;
            const p_id = grandparent.querySelector('.p_id').innerText;
            const priceValue = Number(price.replace(/[^0-9]/g, '')); // 숫자 부분만 추출

            // Check if the menu is already in the cart
            const existingMenu = menuList.find(menu => menu.name === name);

            console.log(menuList);

            if (existingMenu) {
                // If the menu is already in the cart, just increase the quantity
                existingMenu.amount += 1;
                // Update the quantity input in the cart
                const quantityInput = movingMenu.querySelector(`input[name="amount"][data-name="` + name + `"]`);

                quantityInput.value = existingMenu.amount;
            } else {
                const cart_in_menu = document.createElement('div');
                cart_in_menu.classList.add('cart_in_menu');

                const name_div = document.createElement('div');
                name_div.classList.add('d-flex', 'mt-1');

                const ul = document.createElement('ul');
                ul.classList.add('w-100', 'd-flex', 'list-unstyled', 'justify-content-between');

                const name_li = document.createElement('li');
                name_li.classList.add('fs-4', 'fw-bold', 'menu_name');
                name_li.innerText = name;

                const price_li = document.createElement('li');
                price_li.classList.add('list-group-item', 'p-0', 'text-bg-light');
                price_li.style.width = '35px';
                price_li.style.borderRadius = '20%';

                const delBtn = document.createElement('button');
                delBtn.classList.add('btn-close', 'btn-outline-dark', 'btn');
                delBtn.style.zIndex = '1';
                delBtn.style.width = '25px';
                delBtn.style.height = '25px';
                delBtn.addEventListener('click', function () {
                    cart_in_menu.remove(); // 항목 제거
                    updateTotalPrice(); // 총 가격 업데이트
                    // Remove the menu from the menuList
                    menuList = menuList.filter(menu => menu.name !== name);
                });

                price_li.appendChild(delBtn);

                ul.appendChild(name_li);
                ul.appendChild(price_li);

                name_div.appendChild(ul);

                cart_in_menu.appendChild(name_div);

                const cntController = document.createElement('div');
                cntController.classList.add('cntController', 'd-flex', 'justify-content-between');

                const clickUpDown = document.createElement('div');
                clickUpDown.id = 'clickUpDown';
                clickUpDown.classList.add('upDown');

                const sellPriceInput = document.createElement('input');
                sellPriceInput.type = 'hidden';
                sellPriceInput.name = 'sell_price';
                sellPriceInput.value = priceValue; // 가격 정보 설정

                const addButton = document.createElement('input');
                addButton.id = 'up';
                addButton.classList.add('btn', 'btn-primary', 'rounded-pill');
                addButton.type = 'button';
                addButton.value = '+';
                addButton.name = 'add';
                addButton.addEventListener('click', function () {
                    const amount = this.parentElement.querySelector('input[name="amount"]');
                    console.log('addBtn: ' + amount.value);
                    amount.value = +amount.value + 1;

                    // 메뉴의 가격 업데이트
                    const sumInput = this.parentElement.parentElement.querySelector('input[name="sum"]');
                    const sellPriceInput = this.parentElement.querySelector('input[name="sell_price"]');
                    const priceValue = parseInt(sellPriceInput.value);
                    sumInput.value = priceValue * +amount.value;

                    // 총 가격 업데이트
                    updateTotalPrice();
                    // Update the quantity in the menuList

                    let menu = menuList.find(menu => menu.name === name);
                    menu.amount = +amount.value;

                    console.log(menuList);
                });

                const amountInput = document.createElement('input');
                amountInput.type = 'text';
                amountInput.name = 'amount';
                amountInput.value = '1';
                amountInput.size = '3';
                amountInput.readOnly=true;
                amountInput.setAttribute('data-name', name); // Store the menu name as data attribute

                const minusButton = document.createElement('input');
                minusButton.id = 'down';
                minusButton.classList.add('btn', 'btn-primary', 'rounded-pill');
                minusButton.type = 'button';
                minusButton.value = '-';
                minusButton.name = 'minus';
                minusButton.addEventListener('click', function () {
                    const amount = this.parentElement.querySelector('input[name="amount"]');
                    if(amount.value <= 1) {
                        return;
                    }
                    console.log('addBtn: ' + amount.value);
                    amount.value = +amount.value - 1;

                    // 메뉴의 가격 업데이트
                    const sumInput = this.parentElement.parentElement.querySelector('input[name="sum"]');
                    const sellPriceInput = this.parentElement.querySelector('input[name="sell_price"]');
                    const priceValue = parseInt(sellPriceInput.value);
                    sumInput.value = priceValue * +amount.value;

                    // 총 가격 업데이트
                    updateTotalPrice();
                    // Update the quantity in the menuList

                    let menu = menuList.find(menu => menu.name === name);
                    menu.amount = +amount.value;

                    console.log(menuList);
                });

                clickUpDown.appendChild(sellPriceInput);
                clickUpDown.appendChild(addButton);
                clickUpDown.appendChild(amountInput);
                clickUpDown.appendChild(minusButton);

                const showTotalPrice = document.createElement('div');
                showTotalPrice.id = 'showTotalPrice';

                const sumInput = document.createElement('input');
                sumInput.type = 'text';
                sumInput.name = 'sum';
                sumInput.size = '11';
                sumInput.readOnly = true;
                sumInput.value = priceValue;

                showTotalPrice.appendChild(sumInput);

                cntController.appendChild(clickUpDown);
                cntController.appendChild(showTotalPrice);

                cart_in_menu.appendChild(cntController);
                movingMenu.appendChild(cart_in_menu);

                let menu = {
                    memo: document.getElementById('memo').value,
                    p_id: +p_id,
                    name: name,
                    priceValue: priceValue,
                    amount: 1
                };

                menuList.push(menu);

                // 메뉴를 추가한 후 총 가격 업데이트
                updateTotalPrice();

                console.log(menuList);

            }
        });
    });


</script>
<script src="/js/script.js"></script>
</body>

</html>