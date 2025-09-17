<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>유저 페이지</title>
<link rel="icon" type="image/png"
    href="/resources/images/watermelon_icon.ico">
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet">
<link rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link rel="stylesheet"
    href="/resources/css/userpage.css">
</head>
<body>
	<jsp:include page="../component/header.jsp" />

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card mb-4">
                <div class="card-body p-4">
                    <div class="d-flex align-items-center mb-3">
                        <img src="/images/default_avatar.png" class="rounded-circle me-3"
                            alt="avatar" width="80" height="80">
                        <div>
                            <h3 class="card-title mb-1">김정은</h3>
                            <p class="card-text text-muted mb-0">안녕하세요! 밥 주세요.</p>
                        </div>
                        <c:if test="${!isMyPage}">
                            <div class="ms-auto">
                                <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#chatModal" data-user-id="${user.id}">1:1 채팅하기</button>
                            </div>
                        </c:if>
                    </div>

                    <div class="d-flex align-items-center mb-3">
                        <div class="rating-stars me-2">
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-half"></i>
                        </div>
                        <span class="fs-4 fw-bold">4.5</span>
                        <span class="text-muted ms-2">/ 5.0</span>
                    </div>

                    <a href="#pills-reviews" class="text-decoration-none text-dark d-flex align-items-center justify-content-between">

                        <div class="d-flex align-items-center">
                            <span class="text-muted me-2">받은 후기 <span class="fw-bold">0</span>개</span>
                            <i class="bi bi-chevron-right"></i>
                        </div>
                    </a>
                </div>
            </div>

            <div class="card">
                <div class="card-body p-4">
                    <h4 class="mb-4">판매 상품</h4>
                    <ul class="nav nav-pills product-tabs mb-4" id="pills-tab" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active" id="pills-all-tab" data-bs-toggle="pill" data-bs-target="#pills-all" type="button" role="tab" aria-controls="pills-all" aria-selected="true">전체</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="pills-selling-tab" data-bs-toggle="pill" data-bs-target="#pills-selling" type="button" role="tab" aria-controls="pills-selling" aria-selected="false">판매중</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="pills-sold-tab" data-bs-toggle="pill" data-bs-target="#pills-sold" type="button" role="tab" aria-controls="pills-sold" aria-selected="false">판매완료</button>
                        </li>
                    </ul>
                    <div class="tab-content" id="pills-tabContent">
                        <div class="tab-pane fade show active" id="pills-all" role="tabpanel" aria-labelledby="pills-all-tab" tabindex="0">
                            <c:choose>
                                <c:when test="${empty allProducts}">
                                    <div class="d-flex flex-column align-items-center justify-content-center py-5">
                                        <h5 class="mb-3">등록된 상품이 없습니다.</h5>
                                        <img src="/images/404.png" class="img-fluid" style="max-width: 200px;">
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="product-list row">
                                        <c:forEach var="product" items="${allProducts}">
                                            <div class="col-6 col-md-4 mb-4">
                                                <a href="/product/${product.id}" class="product-link">
                                                    <img src="${product.imageUrl}" class="product-thumbnail" alt="${product.name}">
                                                    <h6 class="mt-2 text-truncate">${product.name}</h6>
                                                    <p class="fw-bold">${product.price}원</p>
                                                    <c:if test="${product.status eq 'sold'}">
                                                        <span class="badge bg-secondary">판매완료</span>
                                                    </c:if>
                                                </a>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="tab-pane fade" id="pills-selling" role="tabpanel" aria-labelledby="pills-selling-tab" tabindex="0">
                            <c:choose>
                                <c:when test="${empty sellingProducts}">
                                    <div class="d-flex flex-column align-items-center justify-content-center py-5">
                                        <h5 class="mb-3">판매중인 상품이 없습니다.</h5>
                                        <img src="/images/404.png" class="img-fluid" style="max-width: 200px;">
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="product-list row">
                                        <c:forEach var="product" items="${sellingProducts}">
                                            <div class="col-6 col-md-4 mb-4">
                                                <a href="/product/${product.id}" class="product-link">
                                                    <img src="${product.imageUrl}" class="product-thumbnail" alt="${product.name}">
                                                    <h6 class="mt-2 text-truncate">${product.name}</h6>
                                                    <p class="fw-bold">${product.price}원</p>
                                                </a>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="tab-pane fade" id="pills-sold" role="tabpanel" aria-labelledby="pills-sold-tab" tabindex="0">
                            <c:choose>
                                <c:when test="${empty soldProducts}">
                                    <div class="d-flex flex-column align-items-center justify-content-center py-5">
                                        <h5 class="mb-3">판매완료된 상품이 없습니다.</h5>
                                        <img src="/images/404.png" class="img-fluid" style="max-width: 200px;">
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="product-list row">
                                        <c:forEach var="product" items="${soldProducts}">
                                            <div class="col-6 col-md-4 mb-4">
                                                <a href="/product/${product.id}" class="product-link">
                                                    <img src="${product.imageUrl}" class="product-thumbnail" alt="${product.name}">
                                                    <h6 class="mt-2 text-truncate">${product.name}</h6>
                                                    <p class="fw-bold">${product.price}원</p>
                                                    <span class="badge bg-secondary">판매완료</span>
                                                </a>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card mt-4" id="pills-reviews">
                <div class="card-body p-4">
                    <h4 class="mb-4">거래 후기</h4>
                    <c:if test="${empty userReviews}">
                        <div class="d-flex flex-column align-items-center justify-content-center py-5">
                            <h5 class="mb-3">받은 후기가 없습니다.</h5>
                        </div>
                    </c:if>
                    <c:if test="${not empty userReviews}">
                        <div class="list-group">
                            <c:forEach var="review" items="${userReviews}">
                                <div class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                                    <div class="d-flex align-items-center">
                                        <i class="bi bi-person-circle fs-3 me-3"></i>
                                        <div>
                                            <h6 class="mb-1">${review.reviewerName}</h6>
                                            <small class="text-muted">${review.reviewText}</small>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="rating-stars me-2 d-flex gap-1">
                                            <c:forEach begin="1" end="5" varStatus="loop">
                                                <i class="bi ${loop.index <= review.rating ? 'bi-star-fill' : 'bi-star'} text-warning"></i>
                                            </c:forEach>
                                        </div>
                                        <div class="d-flex flex-wrap gap-1 mt-2">
                                            <c:forEach var="tag" items="${review.tags}">
                                                <span class="badge rounded-pill text-bg-info">${tag}</span>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../component/footer.jsp" />

<div class="modal fade" id="chatModal" tabindex="-1" aria-labelledby="chatModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="chatModalLabel">김정은님과의 채팅</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" style="min-height: 400px; max-height: 400px; overflow-y: auto; display: flex; flex-direction: column;">
                <div class="d-flex justify-content-start mb-2">
                    <div class="p-2 border rounded bg-light">
                        <small class="text-muted">안녕하세요. 상품 보고 연락드렸어요!</small>
                    </div>
                </div>
                <div class="d-flex justify-content-end mb-2">
                    <div class="p-2 border rounded bg-success text-white">
                        <small>네, 궁금한 점 있으세요?</small>
                    </div>
                </div>
                <div class="d-flex justify-content-start mb-2">
                    <div class="p-2 border rounded bg-light">
                        <small class="text-muted">혹시 가격 네고 가능한가요?</small>
                    </div>
                </div>
                <div class="d-flex justify-content-end mb-2">
                    <div class="p-2 border rounded bg-success text-white">
                        <small>어느 정도 생각하고 계세요?</small>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="메시지를 입력하세요...">
                    <button class="btn btn-outline-success" type="button">전송</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>