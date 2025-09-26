<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/global.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/search.css">

<style>
	.card-img-container {
		position: relative;
	}
	.auction-ended-overlay {
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		background-color: rgba(0, 0, 0, 0.6);
		color: white;
		display: flex;
		justify-content: center;
		align-items: center;
		font-size: 1.2rem;
		font-weight: bold;
		z-index: 2;
		border-radius: var(--bs-card-inner-border-radius);
	}
	.time-overlay {
		position: absolute;
		top: 8px;
		left: 8px;
		background-color: rgba(0, 0, 0, 0.7);
		color: white;
		padding: 3px 8px;
		border-radius: 4px;
		font-size: 0.8rem;
		font-weight: bold;
		z-index: 1;
	}
</style>
</head>
<body>
	<jsp:include page="../component/header.jsp" />
	<%
		String category;
		String category1 = (String)request.getAttribute("category");
		String category2 = request.getParameter("category");
		if(category1 != null || category2 != null){
			if(category1 != null)
				category = category1;
			else
				category = category2;
		}
		else
			category = "전체";
	%>
	<div class="container mt-4 mb-5">
		<h2 class="mb-3">${param.title} 검색 결과</h2>
		<hr>

		<div class="filter-section p-3 mb-4">
			<div class="row align-items-center g-3">
				<div class="col-md-auto fw-bold">카테고리</div>
				<div class="col-md-auto">
					<button class="btn btn-dark btn-sm" disabled>
						<%= category %>
					</button>
				</div>
			</div>
			<hr class="my-2">

			<form action="${pageContext.request.contextPath}/item/search/price" method="get" id="priceFilterForm">
				<input type="hidden" name="title" value="${param.title}">
				<% if (!"전체".equals(category) && category != null) { %>
					<input type="hidden" name="category" value="<%= category %>">
				<% } %>

				<div class="row align-items-center g-3">
					<div class="col-md-auto fw-bold">가격</div>
					<div class="col-md-7 col-lg-5">
						<div class="input-group input-group-sm">
							<input type="text" class="form-control priceInput"
								name="minPrice" placeholder="최소 가격" value="${param.minPrice}"> <span
								class="input-group-text">~</span> <input type="text"
								class="form-control priceInput" name="maxPrice"
								placeholder="최대 가격" value="${param.maxPrice}">
						</div>
					</div>
				</div>

				<div class="row align-items-center g-3 mt-2">
					<div class="col-md-auto fw-bold">옵션</div>
					<div class="col-md-auto">
						<div class="form-check">
							<input class="form-check-input" type="checkbox" name="excludeEnded" value="true" id="excludeEndedCheckbox"
								<c:if test="${param.excludeEnded == 'true'}">checked</c:if>>
							<label class="form-check-label small" for="excludeEndedCheckbox">
								경매종료된 상품 제외하고 보기
							</label>
						</div>
					</div>
				</div>

				<div class="d-flex justify-content-end mt-3">
					<button class="btn btn-dark">필터 적용</button>
				</div>
			</form>
		</div>

		<div class="d-flex justify-content-end align-items-center mb-3">
			<a href="${pageContext.request.contextPath}/item/search/latest?title=${param.title}<% if (!"전체".equals(category) && category != null) { out.print("&category=" + category); } %>&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}<c:if test="${param.excludeEnded == 'true'}">&excludeEnded=true</c:if>" class="text-decoration-none text-dark fw-bold small me-3">최신순</a>
			<a href="${pageContext.request.contextPath}/item/search/favorite?title=${param.title}<% if (!"전체".equals(category) && category != null) { out.print("&category=" + category); } %>&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}<c:if test="${param.excludeEnded == 'true'}">&excludeEnded=true</c:if>" class="text-decoration-none text-dark fw-bold small me-3">추천순</a>
			<a href="${pageContext.request.contextPath}/item/search/low?title=${param.title}<% if (!"전체".equals(category) && category != null) { out.print("&category=" + category); } %>&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}<c:if test="${param.excludeEnded == 'true'}">&excludeEnded=true</c:if>" class="text-decoration-none text-dark fw-bold small me-3">낮은가격순</a>
			<a href="${pageContext.request.contextPath}/item/search/high?title=${param.title}<% if (!"전체".equals(category) && category != null) { out.print("&category=" + category); } %>&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}<c:if test="${param.excludeEnded == 'true'}">&excludeEnded=true</c:if>" class="text-decoration-none text-dark fw-bold small me-3">높은가격순</a>
		</div>

		<div class="row row-cols-2 row-cols-md-3 row-cols-lg-5 g-4">
			<c:forEach var="item" items="${list}">
				<div class="col">
					<a href="${pageContext.request.contextPath}/item/${item.id}"
						class="text-decoration-none">
						<div class="product-card">
							<div class="card-img-container">
								<img src="${pageContext.request.contextPath}/${item.imageUrl}"
									class="card-img-top" alt="상품 이미지">
								<span class="remaining-time time-overlay" data-end-time="${item.endTime}"></span>
								<c:if test="${item.status != 'OPEN'}">
									<div class="auction-ended-overlay">
										<span>경매종료</span>
									</div>
								</c:if>
							</div>
							<div class="card-body">
								<p class="card-title mb-1">${item.title}</p>
								<p class="card-price mb-1">${item.currentPrice}</p>
							</div>
						</div>
					</a>
				</div>
			</c:forEach>
		</div>
	</div>
	<jsp:include page="../component/footer.jsp" />

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	
	<script>
		$(document).ready(function() {
			
			$('.priceInput').on('input', function() {
				let value = $(this).val().replace(/[^\d]/g, '');
				$(this).val(value ? Number(value).toLocaleString() : '');
			});
			
			$('#priceFilterForm').on('submit', function() {
				$('.priceInput').each(function() {
					$(this).val($(this).val().replace(/,/g, ''));
				});
			});

			function updateRemainingTime() {
				$('.remaining-time').each(function() {
					const $this = $(this);
					const endTime = new Date($this.data('end-time')).getTime();
					const now = new Date().getTime();
					const distance = endTime - now;

					if (distance < 0) {
						// 이미 종료되었으면 더 이상 업데이트하지 않도록 data 속성을 제거
						$this.removeAttr('data-end-time');
						return;
					}
					
					// 시간 계산 로직
					const days = Math.floor(distance / (1000 * 60 * 60 * 24));
					const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
					const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
					const seconds = Math.floor((distance % (1000 * 60)) / 1000);
					
					// 시간 포맷팅 로직
					let timeLeft = '';
					const hh = String(hours).padStart(2, '0');
					const mm = String(minutes).padStart(2, '0');
					const ss = String(seconds).padStart(2, '0');
					
					if (days > 0) {
						timeLeft = `\${days}일 \${hh}:\${mm}:\${ss}`;
					} else {
						timeLeft = `\${hh}:\${mm}:\${ss}`;
					}
					
					$this.text(timeLeft);
				});
			}

			setInterval(updateRemainingTime, 1000);
			updateRemainingTime(); // 페이지 로드 시 즉시 실행
		});
	</script>
</body>
</html>