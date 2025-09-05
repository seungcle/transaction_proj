<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="subag_errorPage.jsp"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>수박처럼 시원한 중고 가격</title>
<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/watermelon_icon.ico">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap"
	rel="stylesheet">

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/global.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">

</head>
<body>
	<jsp:include page="../component/header.jsp" />

	<jsp:include page="../component/maingrid.jsp" />

	<div class="container my-5">
		<div class="text-center mb-5">
			<h2 class="section-title">
				<i class="bi bi-fire text-danger"></i> 실시간 인기 경매
			</h2>
			<p>${list}</p>
			<p class="section-subtitle">지금 바로 참여하고 특별한 상품을 만나보세요!</p>
		</div>

		<div class="row">
			<div class="col-lg-3 col-md-6 mb-4">
				<a href="../jsp/item.jsp?itemId=101" class="text-decoration-none">
					<div class="card product-card h-100">
						<div class="card-img-container">
							<img
								src="http://gd3.alicdn.com/imgextra/i3/54410696/TB2vkTrbrMlyKJjSZFlXXbMoFXa_!!54410696.jpg_640x640.jpg"
								class="card-img-top" alt="빈티지 키보드"> <span
								class="badge bg-success position-absolute top-0 start-0 m-3 status-badge">경매
								진행중</span>
						</div>
						<div class="card-body d-flex flex-column">
							<h5 class="card-title mt-2">빈티지 기계식 키보드</h5>
							<div class="mt-auto">
								<p class="price-label mb-1">현재 입찰가</p>
								<p class="price-text mb-0">75,000원</p>
							</div>
						</div>
					</div>
				</a>
			</div>

			<div class="col-lg-3 col-md-6 mb-4">
				<a href="../jsp/item.jsp?itemId=102" class="text-decoration-none">
					<div class="card product-card h-100">
						<div class="card-img-container">
							<img
								src="https://image.ohousecdn.com/i/bucketplace-v2-development/uploads/productions/163773272252100026.jpg?w=360"
								class="card-img-top" alt="캠핑 랜턴"> <span
								class="badge bg-success position-absolute top-0 start-0 m-3 status-badge">경매
								진행중</span>
						</div>
						<div class="card-body d-flex flex-column">
							<h5 class="card-title mt-2">빈티지 캠핑용 랜턴</h5>
							<div class="mt-auto">
								<p class="price-label mb-1">현재 입찰가</p>
								<p class="price-text mb-0">32,000원</p>
							</div>
						</div>
					</div>
				</a>
			</div>

			<div class="col-lg-3 col-md-6 mb-4">
				<a href="../jsp/item.jsp?itemId=103" class="text-decoration-none">
					<div class="card product-card h-100">
						<div class="card-img-container">
							<img
								src="https://img.gqkorea.co.kr/gq/2024/07/style_66823d69d3b4d.jpg"
								class="card-img-top" alt="클래식 시계"> <span
								class="badge bg-success position-absolute top-0 start-0 m-3 status-badge">경매
								진행중</span>
						</div>
						<div class="card-body d-flex flex-column">
							<h5 class="card-title mt-2">클래식 손목 시계</h5>
							<div class="mt-auto">
								<p class="price-label mb-1">현재 입찰가</p>
								<p class="price-text mb-0">4,380,000,000원</p>
							</div>
						</div>
					</div>
				</a>
			</div>

			<div class="col-lg-3 col-md-6 mb-4">
				<a href="../jsp/item.jsp?itemId=104" class="text-decoration-none">
					<div class="card product-card h-100">
						<div class="card-img-container">
							<img
								src="https://img.danawa.com/prod_img/500000/664/660/img/2660664_1.jpg?_v=20170216113504&shrink=360:360"
								class="card-img-top" alt="필름 카메라"> <span
								class="badge bg-warning text-dark position-absolute top-0 start-0 m-3 status-badge">마감
								임박</span>
						</div>
						<div class="card-body d-flex flex-column">
							<h5 class="card-title mt-2">라이카 M6 필름 카메라</h5>
							<div class="mt-auto">
								<p class="price-label mb-1">현재 입찰가</p>
								<p class="price-text mb-0">2,150,000원</p>
							</div>
						</div>
					</div>
				</a>
			</div>

			<div class="col-lg-3 col-md-6 mb-4">
				<a href="../jsp/item.jsp?itemId=105" class="text-decoration-none">
					<div class="card product-card h-100">
						<div class="card-img-container">
							<img
								src="https://thumbnail.10x10.co.kr/webimage/image/basic600/366/B003662863.jpg?cmd=thumb&w=400&h=400&fit=true&ws=false"
								class="card-img-top" alt="턴테이블"> <span
								class="badge bg-success position-absolute top-0 start-0 m-3 status-badge">경매
								진행중</span>
						</div>
						<div class="card-body d-flex flex-column">
							<h5 class="card-title mt-2">LP 레코드판 턴테이블</h5>
							<div class="mt-auto">
								<p class="price-label mb-1">현재 입찰가</p>
								<p class="price-text mb-0">180,000원</p>
							</div>
						</div>
					</div>
				</a>
			</div>

			<div class="col-lg-3 col-md-6 mb-4">
				<a href="../jsp/item.jsp?itemId=106" class="text-decoration-none">
					<div class="card product-card h-100">
						<div class="card-img-container">
							<img
								src="https://media.bunjang.co.kr/product/288273745_2_1725711558_w360.jpg"
								class="card-img-top" alt="라디오"> <span
								class="badge bg-danger position-absolute top-0 start-0 m-3 status-badge">경매
								종료</span>
						</div>
						<div class="card-body d-flex flex-column">
							<h5 class="card-title mt-2">앤티크 진공관 라디오</h5>
							<div class="mt-auto">
								<p class="price-label mb-1">낙찰가</p>
								<p class="price-text mb-0 text-secondary">98,000원</p>
							</div>
						</div>
					</div>
				</a>
			</div>

		</div>
	</div>

	<jsp:include page="../component/footer.jsp" />

</body>
</html>