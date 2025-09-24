<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>수박나라 메인</title>

<!-- Bootstrap CSS 먼저 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet" />

<!-- 전역/페이지 전용 CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/global.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/maingrid.css">
</head>
<body>
	<div id="mainCarousel"
		class="carousel slide mb-5 rounded-4 overflow-hidden"
		data-bs-ride="carousel" data-bs-interval="8000" data-bs-pause="hover"
		aria-label="메인 프로모션 캐러셀">
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img src="${pageContext.request.contextPath}/resources/images/sell.png"
					class="d-block w-100" alt="판매 가이드">
			</div>
			<div class="carousel-item">
			 <a href="https://youtu.be/JEsha9JQ5J8?feature=shared" target="_blank">
				<img src="${pageContext.request.contextPath}/resources/images/sale.png"
					class="d-block w-100" alt="구매 가이드">
			</a>
			</div>
			<div class="carousel-item">
				<img src="${pageContext.request.contextPath}/resources/images/welcome.png"
					class="d-block w-100" alt="어서와 배너">
			</div>
		</div>

		<!-- 이전 버튼 -->
		<button class="carousel-control-prev" type="button"
			data-bs-target="#mainCarousel" data-bs-slide="prev"
			aria-label="이전 배너">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Previous</span>
		</button>

		<!-- 다음 버튼 -->
		<button class="carousel-control-next" type="button"
			data-bs-target="#mainCarousel" data-bs-slide="next"
			aria-label="다음 배너">
			<span class="carousel-control-next-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Next</span>
		</button>
	</div>

	<!-- Bootstrap JS는 body 끝에 -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
