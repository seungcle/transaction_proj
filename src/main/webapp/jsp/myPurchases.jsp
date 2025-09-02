<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매 내역</title>
<link rel="icon" type="image/png" href="../images/watermelon_icon.ico">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/mypage-components.css">
</head>
<body>
	<div class="offcanvas offcanvas-end" tabindex="-1"
		id="myPurchasesOffcanvas" aria-labelledby="myPurchasesOffcanvasLabel">
		<div class="offcanvas-header">
			<h5 class="offcanvas-title w-100 text-center" id="offcanvasLabel">구매
				내역</h5>
			<button type="button" class="btn-close" data-bs-dismiss="offcanvas"
				aria-label="Close"></button>
		</div>

		<div class="p-3">
			<div class="product-item position-relative">
				<img
					src="https://blog.kakaocdn.net/dna/d2WW4V/btsLZ6ySsiz/AAAAAAAAAAAAAAAAAAAAALSlWwMMFuhq9Sfamu_s3SzNNR6MdIfY9XZYVPlTPA1c/img.jpg?credential=yqXZFxpELC7KVnFOS48ylbz2pIh7yKj8&expires=1756652399&allow_ip=&allow_referer=&signature=mC%2Fp%2F0zCUUSOVJ6ITyLKiid2psI%3D"
					alt="상품 이미지">
				<div class="product-item-info">
					<h6 class="text-dark">갤럭시 s25</h6>
					<p class="price text-dark">850,000원</p>
					<p class="time">입찰완료</p>
				</div>
				<a href="#" class="stretched-link"></a>
			</div>

			<div class="product-item position-relative">
				<img
					src="https://cafe24.poxo.com/ec01/theninemall/aTohBGrn9Loen/ATLMSSDa19TYtqDoJlxGpDd4ctnX+wHagy9XERpkORaxbV5kFTnSa4QE1GmsszIX6vsZ4Vhg==/_/web/product/big/202401/d568381e91ef389b823b6dbb1affd892.jpg"
					alt="상품 이미지">
				<div class="product-item-info">
					<h6 class="text-dark">텀블러</h6>
					<p class="price text-dark">20,000원</p>
					<p class="time">입찰완료</p>
				</div>
				<a href="#" class="stretched-link"></a>
			</div>

			<div class="product-item position-relative">
				<img
					src="https://digiters.co.kr/wp-content/uploads/20220226075816-609x350.png"
					alt="상품 이미지">
				<div class="product-item-info">
					<h6 class="text-dark">무접점 키보드</h6>
					<p class="price text-dark">75,000원</p>
					<p class="time">입찰완료</p>
				</div>
				<a href="#" class="stretched-link"></a>
			</div>
		</div>

	</div>
</body>
</html>