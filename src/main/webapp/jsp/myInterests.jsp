<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../style/offcanvas.css">
</head>
<body>
	<div class="offcanvas offcanvas-end" tabindex="-1"
		id="myInterestsOffcanvas" aria-labelledby="myInterestsOffcanvasLabel">
		<div class="offcanvas-header">
			<button type="button" class="btn btn-link text-dark"
				data-bs-dismiss="offcanvas" aria-label="Close">
				<i class="bi bi-arrow-left fs-4"></i>
			</button>
			<h5 class="offcanvas-title w-100 text-center" id="offcanvasLabel">내 관심</h5>
		</div>

		<div class="offcanvas-body p-0">
			<ul class="nav nav-tabs px-3 custom-tabs">
				<li class="nav-item title"><img class="icon" src="../images/heart.png"> 찜한 상품</li>
			</ul>

			<div class="p-3">
				<div class="product-item position-relative">
					<img
						src="https://img.khan.co.kr/news/2020/11/24/2020112501002740800239391.jpg"
						alt="상품 이미지">
					<div class="product-item-info">
						<h6 class="text-dark">아이폰12 미니 팔아요</h6>
						<p class="price text-dark">50,000원</p>
						<p class="time">입찰중</p>
					</div>
					<a href="#" class="stretched-link"></a>
				</div>

				<div class="product-item position-relative">
					<img
						src="https://thumbnail7.coupangcdn.com/thumbnails/remote/492x492ex/image/vendor_inventory/e191/98384687d5d12e3ea89d40aa5e2dbde706966b7e813caccd8e7d58a0f310.jpg"
						alt="상품 이미지">
					<div class="product-item-info">
						<h6 class="text-dark">에어팟 프로 팝니다</h6>
						<p class="price text-dark">120,000원</p>
						<p class="time">입찰중</p>
					</div>
					<a href="#" class="stretched-link"></a>
				</div>

				<div class="product-item position-relative">
					<img
						src="http://gd3.alicdn.com/imgextra/i3/54410696/TB2vkTrbrMlyKJjSZFlXXbMoFXa_!!54410696.jpg_640x640.jpg"
						alt="상품 이미지">
					<div class="product-item-info">
						<h6 class="text-dark">고급스러운 빈티지 기계식 키보드</h6>
						<p class="price text-dark">75,000원</p>
						<p class="time">입찰중</p>
					</div>
					<a href="#" class="stretched-link"></a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>