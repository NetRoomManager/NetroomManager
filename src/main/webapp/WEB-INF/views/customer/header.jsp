<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cpath" value="${pageContext.request.contextPath }" />
<!-- 고객 헤더 -->
<!DOCTYPE html>
<html lang="ko">
<head>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="../css/main.css" rel="stylesheet">


<meta charset="UTF-8">
<title>관리자화면</title>
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
} /* ---- particles.js container ---- */
#particles-js {
	position: absolute;
	width: 100%;
	height: 100%;
	background-color: #28455f;
	background-image: url("");
	background-repeat: no-repeat;
	background-size: cover;
	background-position: 50% 50%;
} /* ---- stats.js ---- */
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
<body style="height: 90%; overflow: hidden;">
	<div id="particles-js" style="z-index: -1"></div>
	<nav class="navbar navbar-expand-sm bg-info navbar-dark">
		<div class="container-fluid">
			<ul class="navbar-nav">
				<li class="nav-item"><a class="nav-link active"
					href="${cpath }/">Home</a></li>
				<li class="nav-item"><a class="nav-link"
					href="${cpath }/customer/customer_main.jsp">유저 메인페이지</a></li>
				<li class="nav-item"><a class="nav-link"
					href="${cpath }/customer/customer_order.jsp">유저 주문 페이지</a></li>
				<li class="nav-item"><a class="nav-link"
					href="${cpath }/customer/error.jsp">에러페이지</a></li>
			</ul>
		</div>
	</nav>

	<!-- particles.js / 배경 -->
	<script
		src="http://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js"></script>
	<script>
		particlesJS("particles-js", {
			"particles" : {
				"number" : {
					"value" : 400,
					"density" : {
						"enable" : true,
						"value_area" : 800
					}
				},
				"color" : {
					"value" : "#ffffff"
				},
				"shape" : {
					"type" : "polygon",
					"stroke" : {
						"width" : 0,
						"color" : "#000000"
					},
					"polygon" : {
						"nb_sides" : 5
					},
					"image" : {
						"src" : "img/github.svg",
						"width" : 100,
						"height" : 100
					}
				},
				"opacity" : {
					"value" : 0.5,
					"random" : true,
					"anim" : {
						"enable" : false,
						"speed" : 1,
						"opacity_min" : 0.1,
						"sync" : false
					}
				},
				"size" : {
					"value" : 10,
					"random" : true,
					"anim" : {
						"enable" : false,
						"speed" : 40,
						"size_min" : 0.1,
						"sync" : false
					}
				},
				"line_linked" : {
					"enable" : false,
					"distance" : 500,
					"color" : "#ffffff",
					"opacity" : 0.4,
					"width" : 2
				},
				"move" : {
					"enable" : true,
					"speed" : 6,
					"direction" : "bottom",
					"random" : false,
					"straight" : false,
					"out_mode" : "out",
					"bounce" : false,
					"attract" : {
						"enable" : false,
						"rotateX" : 600,
						"rotateY" : 1200
					}
				}
			},
			"interactivity" : {
				"detect_on" : "canvas",
				"events" : {
					"onhover" : {
						"enable" : true,
						"mode" : "repulse"
					},
					"onclick" : {
						"enable" : true,
						"mode" : "repulse"
					},
					"resize" : true
				},
				"modes" : {
					"grab" : {
						"distance" : 400,
						"line_linked" : {
							"opacity" : 0.5
						}
					},
					"bubble" : {
						"distance" : 407.5924075924076,
						"size" : 11.988011988011989,
						"duration" : 0.3,
						"opacity" : 1,
						"speed" : 3
					},
					"repulse" : {
						"distance" : 200,
						"duration" : 0.4
					},
					"push" : {
						"particles_nb" : 4
					},
					"remove" : {
						"particles_nb" : 2
					}
				}
			},
			"retina_detect" : true
		});
		let count_particles, stats, update;
		stats = new Stats;
		stats.setMode(0);
		stats.domElement.style.position = 'absolute';
		stats.domElement.style.left = '0px';
		stats.domElement.style.top = '0px';
		document.body.appendChild(stats.domElement);
		count_particles = document.querySelector('.js-count-particles');
		update = function() {
			stats.begin();
			stats.end();
			if (window.pJSDom[0].pJS.particles
					&& window.pJSDom[0].pJS.particles.array) {
				count_particles.innerText = window.pJSDom[0].pJS.particles.array.length;
			}
			requestAnimationFrame(update);
		};
		requestAnimationFrame(update);
		;
		document.getElementById('close_btn').addEventListener(
				'click',
				function() {
					const countdownElement = document
							.getElementById('countdown');
					let countdownValue = 5; // 5초 카운트다운

					// 카운트다운 함수
					function startCountdown() {
						countdownElement.textContent = countdownValue;
						countdownValue--;

						if (countdownValue < -1) {
							// 시간이 다 되면 모달을 닫고 메시지 표시
							$('#quit_modal').modal('hide');
							alert('컴퓨터가 종료됩니다.');
						} else if (countdownValue === -1) {
							location.href = "${cpath}/auth/login_form.jsp";
						} else {
							setTimeout(startCountdown, 1000);
						}
					}

					startCountdown(); // 카운트다운 시작
				});
	</script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- 폰트어썸 -->
	<script src="https://kit.fontawesome.com/a68b6c4b30.js"
		crossorigin="anonymous"></script>

	<!-- Swiper JS / 이미지 넘기기-->
	<script
		src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

	<!-- particles.js / 배경 -->
	<script
		src="http://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js"></script>