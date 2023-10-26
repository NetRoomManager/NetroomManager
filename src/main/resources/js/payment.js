// 아임포트 모듈 불러오기
var IMP = window.IMP;

// 랜덤문자열 대신 millisecound로 대체
const today = new Date();
const hours = today.getHours(); // 시
const minutes = today.getMinutes();  // 분
const seconds = today.getSeconds();  // 초
const milliseconds = today.getMilliseconds();
const makeMerchantUid = `${hours}` + `${minutes}` + `${seconds}` + `${milliseconds}`;

// 버튼 불러오기
const kakaoButton = document.getElementById('kakaoBtn')
const tossButton = document.getElementById('tossBtn')
const inicisButton = document.getElementById(('inicisBtn'))

// 서비스 목록
pgList = ['kakaopay.TC0ONETIME', 'tosspay.tosstest', 'html5_inicis']

// 결제하기
function pay(useremail, username, payId) {
    // if (confirm("구매 하시겠습니까?")) { // 구매 클릭시 한번 더 확인하기
    // if (localStorage.getItem("access")) { // 회원만 결제 가능
    // const emoticonName = document.getElementById('title').innerText

    IMP.init("imp64247670"); // 가맹점 식별코드
    IMP.request_pay({
        pg: pgList[payId], // PG사 코드표에서 선택
        pay_method: 'card', // 결제 방식
        merchant_uid: "IMP" + makeMerchantUid, // 결제 고유 번호
        name: '너구리', // 제품명
        amount: 100, // 가격
        //구매자 정보 ↓
        buyer_email: `${useremail}`,
        buyer_name: `${username}`,
        // buyer_tel : '010-1234-5678',
        // buyer_addr : '서울특별시 강남구 삼성동',
        // buyer_postcode : '123-456'
    }, async function (rsp) { // callback
        if (rsp.success) { // 결제 성공시
            console.log(rsp);
            // 결제 성공시 프로젝트 DB저장 요청

            try {
                await fetch("/auth/buyTicket", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json",
                    },
                    body: JSON.stringify(rsp),
                })
                    .then(response => response.json())
                    .then(data => {
                        if(data.success) {
                            alert('결제 완료!');
                            window.location.reload();
                        }
                        else {
                            alert(`error:[${data.status}]결제요청이 승인된 경우 관리자에게 문의바랍니다.`);
                        }
                    })
            } catch (error) {
                console.error("DB 저장 요청 중 오류가 발생했습니다:", error);
            }
        } else { // 결제 실패시 (아임포트에서 받는 메시지)
            alert(rsp.error_msg)
        }
    });
}

const selectorList = document.querySelectorAll('input[name="userSelector"]');
selectorList.forEach(btn => btn.onclick = () => { userSelect(btn.id) });

function userSelect(id) {
    const row = document.getElementById(id).parentNode.parentNode;  // 부모의 부모 불러오기
    const tdList = row.querySelectorAll('td')
    let name;
    let birth;
    let email;
    for(let i = 0; i < tdList.length; i++){
        const value = tdList[i].querySelector('input').value;
        switch (i){
            case 0:
                name = value;
                break;
            case 1:
                birth = value;
                break;
            case 2:
                email = value;
                break;
        }
    }

    // 구매자 정보
    kakaoButton.setAttribute('onclick', `pay('${email}', '${name}', 0)`)
    tossButton.setAttribute('onclick', `pay('${email}', '${name}', 1)`)
    inicisButton.setAttribute('onclick', `pay('${email}', '${name}', 2)`)
}

// 검색 이벤트 리스너
window.addEventListener("DOMContentLoaded", function () {
    const searchInput = document.getElementById("name");
    searchInput.addEventListener("keyup", function () {
        const searchText = searchInput.value.toLowerCase();
        filterTable(searchText);
    });

    function filterTable(searchText) {
        const table = document.querySelector(".table");
        const rows = table.getElementsByTagName("tr");

        for (let i = 1; i < rows.length; i++) { // 첫 번째 행은 헤더이므로 i를 1부터 시작합니다.
            const row = rows[i];
            const nameCell = row.querySelector("td:first-child");
            const name = nameCell.querySelector("input").value
                .toLowerCase();

            if (name.indexOf(searchText) === -1) {
                row.style.display = "none";
            } else {
                row.style.display = "";
            }
        }
    }
});
