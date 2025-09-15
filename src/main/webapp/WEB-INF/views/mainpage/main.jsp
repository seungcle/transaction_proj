<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="subag_errorPage.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
			<p class="section-subtitle">지금 바로 참여하고 특별한 상품을 만나보세요!</p>
		</div>

		<div class="row">
			<c:forEach var="item" items="${list}">
				<div class="col-lg-3 col-md-6 mb-4">
					<a href="/subak/item/${item.id}" class="text-decoration-none">
						<div class="card product-card h-100">
							<div class="card-img-container">
								<img src="${pageContext.request.contextPath}/${item.imageUrl}" class="card-img-top" alt="${item.title}">
								<span class="badge bg-success position-absolute top-0 start-0 m-3 status-badge">경매 진행중</span>
							</div>
							<div class="card-body d-flex flex-column">
								<h5 class="card-title mt-2">${item.title}</h5>
								<div class="mt-auto">
									<p class="price-label mb-1">현재 입찰가</p>
									<p class="price-text mb-0">${item.currentPrice}</p>
								</div>
							</div>
						</div>
					</a>
				</div>
			</c:forEach>
		</div>
	</div>

	<jsp:include page="../component/footer.jsp" />

</body>
</html>