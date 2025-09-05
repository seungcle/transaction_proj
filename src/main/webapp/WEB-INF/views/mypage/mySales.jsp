<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매내역</title>
<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/watermelon_icon.ico">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage-components.css">
</head>
<body>
	<div class="offcanvas offcanvas-end" tabindex="-1"
		id="mySalesOffcanvas" aria-labelledby="mySalesOffcanvasLabel">
		<div class="offcanvas-header">

			<h5 class="offcanvas-title w-100 text-center" id="offcanvasLabel">판매
				내역</h5>
			<button type="button" class="btn-close" data-bs-dismiss="offcanvas"
				aria-label="Close"></button>
		</div>

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
</body>
</html>