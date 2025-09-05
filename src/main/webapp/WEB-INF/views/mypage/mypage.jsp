<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/watermelon_icon.ico">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css">

</head>
<body>
	<jsp:include page="../component/header.jsp" />

	<div class="container py-5">
		<div class="row">
			<aside class="col-md-3">
				<h4 class="mb-4 ps-2">마이페이지</h4>
				<div class="sidebar">
					<div class="nav flex-column nav-pills">
						<span class="text-muted ps-2 mb-2 fw-bold">거래 정보</span> <a
							class="nav-link" href="#" data-bs-toggle="offcanvas"
							data-bs-target="#mySalesOffcanvas"
							aria-controls="mySalesOffcanvas"><i class="bi bi-receipt"></i>판매내역</a>
						<a class="nav-link" href="#" data-bs-toggle="offcanvas"
							data-bs-target="#myPurchasesOffcanvas"
							aria-controls="myPurchasesOffcanvas"><i class="bi bi-bag"></i>구매내역</a>
						<a class="nav-link" href="#" data-bs-toggle="offcanvas"
							data-bs-target="#myInterestsOffcanvas"
							aria-controls="myInterestsOffcanvas"><i class="bi bi-heart"></i>찜한
							상품</a>
						<hr>
						<span class="text-muted ps-2 mb-2 fw-bold">내 정보</span> <a
							class="nav-link" href="#" data-bs-toggle="offcanvas"
							data-bs-target="#myAddressOffcanvas"
							aria-controls="myAddressOffcanvas"><i class="bi bi-geo-alt"></i>배송지
							관리</a> <a class="nav-link" href="#" data-bs-toggle="offcanvas"
							data-bs-target="#myReviewOffcanvas"
							aria-controls="myReviewOffcanvas"><i class="bi bi-star"></i>거래
							후기</a> <a class="nav-link text-danger" href="#"
							data-bs-toggle="offcanvas" data-bs-target="#withdrawOffcanvas"
							aria-controls="withdrawOffcanvas"><i
							class="bi bi-box-arrow-right"></i>탈퇴하기</a>
					</div>
				</div>
			</aside>

			<main class="col-md-9">
				<div class="card mb-4">
					<div class="card-body p-4">
						<div class="d-flex align-items-center mb-4">
							<img src="https://i.pravatar.cc/100?u=a042581f4e29026704d"
								class="rounded-circle me-3" alt="avatar" width="80" height="80">
							<div>
								<h3 class="card-title mb-0">자상한새벽스피넬</h3>
								<p class="card-text text-muted">친절하고 안전한 거래를 약속합니다.</p>
							</div>
						</div>

						<div class="d-flex align-items-center">
							<div class="rating-stars me-2">
								<i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i> <i
									class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i> <i
									class="bi bi-star-half"></i>
							</div>
							<span class="fs-4 fw-bold">4.5</span> <span
								class="text-muted ms-2">/ 5.0</span>
						</div>
					</div>
				</div>

				<div class="card">
					<div class="card-body p-4">
						<h4 class="mb-4">내 상품</h4>

						<ul class="nav nav-pills product-tabs mb-4">
							<li class="nav-item"><a class="nav-link" href="#">전체</a></li>
							<li class="nav-item"><a class="nav-link" href="#">판매중</a></li>
							<li class="nav-item"><a class="nav-link" href="#">예약중</a></li>
							<li class="nav-item"><a class="nav-link active"
								aria-current="page" href="#">판매완료</a></li>
						</ul>

						<div class="empty-content">
							<i class="bi bi-box2-heart mb-3"></i>
							<h5>아직 판매완료된 상품이 없어요.</h5>
							<p class="text-muted">당신의 멋진 상품들이 주인을 기다리고 있어요!</p>
						</div>
					</div>
				</div>
			</main>
		</div>
	</div>

	<jsp:include page="mySales.jsp" />
	<jsp:include page="myPurchases.jsp" />
	<jsp:include page="myInterests.jsp" />
	<jsp:include page="myAddress.jsp" />
	<jsp:include page="myReview.jsp" />
	<jsp:include page="withdraw.jsp" />

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
