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

			<%-- ▼▼▼ [수정된 부분] Form이 필터 전체를 감싸도록 변경 ▼▼▼ --%>
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
			<%-- ▲▲▲ [수정 완료] ▲▲▲ --%>
		</div>

		<div class="d-flex justify-content-end align-items-center mb-3">
			<%-- ▼▼▼ [수정된 부분] 정렬 링크에 excludeEnded 파라미터 추가 ▼▼▼ --%>
			<a href="${pageContext.request.contextPath}/item/search/latest?title=${param.title}<% if (!"전체".equals(category) && category != null) { out.print("&category=" + category); } %>&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}<c:if test="${param.excludeEnded == 'true'}">&excludeEnded=true</c:if>" class="text-decoration-none text-dark fw-bold small me-3">최신순</a>
			<a href="${pageContext.request.contextPath}/item/search/favorite?title=${param.title}<% if (!"전체".equals(category) && category != null) { out.print("&category=" + category); } %>&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}<c:if test="${param.excludeEnded == 'true'}">&excludeEnded=true</c:if>" class="text-decoration-none text-dark fw-bold small me-3">추천순</a>
			<a href="${pageContext.request.contextPath}/item/search/low?title=${param.title}<% if (!"전체".equals(category) && category != null) { out.print("&category=" + category); } %>&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}<c:if test="${param.excludeEnded == 'true'}">&excludeEnded=true</c:if>" class="text-decoration-none text-dark fw-bold small me-3">낮은가격순</a>
			<a href="${pageContext.request.contextPath}/item/search/high?title=${param.title}<% if (!"전체".equals(category) && category != null) { out.print("&category=" + category); } %>&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}<c:if test="${param.excludeEnded == 'true'}">&excludeEnded=true</c:if>" class="text-decoration-none text-dark fw-bold small me-3">높은가격순</a>
			<%-- ▲▲▲ [수정 완료] ▲▲▲ --%>
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
								<c:if test="${item.status != 'OPEN'}">
									<div class="auction-ended-overlay">
										<span>경매종료</span>
									</div>
								</c:if>
								<button class="wish-btn">	
									<i class="bi bi-heart"></i>
								</button>
							</div>
							<div class="card-body">
								<p class="card-title mb-1">${item.title}</p>
								<p class="card-price mb-1">${item.currentPrice}</p>
								<div class="card-meta d-flex justify-content-between"></div>
							</div>
						</div>
					</a>
				</div>
			</c:forEach>
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
		
		// 버튼 색 변환
		document.addEventListener('DOMContentLoaded', function() {
		    const wishBtns = document.querySelectorAll('.wish-btn');
		    wishBtns.forEach(wishBtn => {
		        const heartIcon = wishBtn.querySelector('i');
		        wishBtn.addEventListener('click', function(event) {
		            event.stopPropagation();
		            event.preventDefault();
		            heartIcon.classList.toggle('bi-heart');
		            heartIcon.classList.toggle('bi-heart-fill');
		        });
		    });
		});
	</script>
</body>
</html>