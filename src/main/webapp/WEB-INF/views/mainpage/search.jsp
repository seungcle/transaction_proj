<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>검색 결과 페이지</title>
<link rel="icon" type="image/png" href="../images/watermelon_icon.ico">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/global.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/search.css">

</head>
<body>
	<jsp:include page="../component/header.jsp" />
	<div class="container mt-4 mb-5">
		<h2 class="mb-3">검색 결과</h2>
		<hr>

		<div class="filter-section p-3 mb-4">
			<div class="row align-items-center g-3">
				<div class="col-md-auto fw-bold">카테고리</div>
				<div class="col-md-auto">
					<button class="btn btn-dark btn-sm">
						<c:if test="${!empty category}">
							${category}
						</c:if>
						<c:if test="${empty category}">
							전체
						</c:if>
					</button>
				</div>
			</div>
			<hr class="my-2">
			<div class="row align-items-center g-3">
			<form action="${pageContext.request.contextPath}/item/search/price" method="get" id="priceFilterForm">
				<input type="hidden" name="title" value="${param.title}">
				<div class="col-md-auto fw-bold">가격</div>
				<div class="col-md-7 col-lg-5">
					<div class="input-group input-group-sm">
						<input type="text" class="form-control priceInput" name="minPrice"
							placeholder="최소 가격"> <span class="input-group-text">~</span>
						<input type="text" class="form-control priceInput" name="maxPrice"
							placeholder="최대 가격">
						<button class="btn btn-dark">적용</button>
						
					</div>
				</div>
			</form>
			</div>
		</div>

		<div class="d-flex justify-content-end align-items-center mb-3">
			<a href="#" class="text-decoration-none text-dark fw-bold small me-3">추천순</a>
			<a href="#" class="text-decoration-none text-muted small me-3">최신순</a>
			<a href="#" class="text-decoration-none text-muted small me-3">낮은가격순</a>
			<a href="#" class="text-decoration-none text-muted small">높은가격순</a>
		</div>

		<div class="row row-cols-2 row-cols-md-3 row-cols-lg-5 g-4">

			<div class="col">
				<c:forEach var="item" items="${list}">
					<a href="${pageContext.request.contextPath}/item/${item.id}" class="text-decoration-none">
						<div class="product-card">
							<div class="card-img-container">
								<img
									src="${pageContext.request.contextPath}/${item.imageUrl}"
									class="card-img-top" alt="상품 이미지">
								<button class="wish-btn">
									<i class="bi bi-heart"></i>
								</button>
							</div>
							<div class="card-body">
								<p class="card-title mb-1">${item.title}</p>
								<p class="card-price mb-1">${item.currentPrice}</p>
								<div class="card-meta d-flex justify-content-between">
									<span>다사읍 | 10분 전</span> <span>찜 4 · 채팅 0</span>
								</div>
							</div>
						</div>
					</a>
				</c:forEach>
			</div>
		</div>
	</div>
	<jsp:include page="../component/footer.jsp" />
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>
		// 원 단위 ',' 설정
		const inputs = document.getElementsByClassName('priceInput');
		
		Array.from(inputs).forEach(input => {
		  input.addEventListener('input', () => {
		    let value = input.value.replace(/[^\d]/g, '');
		    input.value = value ? Number(value).toLocaleString() : '';
		  });
		});
		
		const priceForm = document.getElementById('priceFilterForm');
		priceForm.addEventListener('submit', function(event) {
		  const priceInputs = priceForm.getElementsByClassName('priceInput');
		  Array.from(priceInputs).forEach(input => {
		    input.value = input.value.replace(/,/g, '');
		  });
		});

	</script>
</body>
</html>