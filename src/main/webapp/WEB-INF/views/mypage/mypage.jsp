<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel="icon" type="image/png"
      href="${pageContext.request.contextPath}/resources/images/watermelon_icon.ico">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/mypage.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<body>
<jsp:include page="../component/header.jsp" />

<div class="container py-5">
    <div class="row">
        <!-- 사이드바 -->
        <aside class="col-md-3">
            <h4 class="mb-4 ps-2">마이페이지</h4>
            <div id="mypage-data" data-user-id="${user.id}"></div>
            <div class="sidebar">
                <div class="nav flex-column nav-pills">
                    <span class="text-muted ps-2 mb-2 fw-bold">거래 정보</span>
                    <a class="nav-link" href="#" data-bs-toggle="offcanvas"
                       data-bs-target="#mySalesOffcanvas" aria-controls="mySalesOffcanvas">
                        <i class="bi bi-receipt"></i>판매내역
                    </a>
                    <a class="nav-link" href="#" data-bs-toggle="offcanvas"
                       data-bs-target="#myPurchasesOffcanvas" aria-controls="myPurchasesOffcanvas">
                        <i class="bi bi-bag"></i>구매내역
                    </a>
                    <a class="nav-link" href="#" data-bs-toggle="offcanvas"
                       data-bs-target="#myInterestsOffcanvas" aria-controls="myInterestsOffcanvas">
                        <i class="bi bi-heart"></i>찜한 상품
                    </a>
                    <hr>
                    <span class="text-muted ps-2 mb-2 fw-bold">내 정보</span>
                    <a class="nav-link" href="#" data-bs-toggle="modal"
                       data-bs-target="#passwordConfirmModal" aria-controls="myInfoOffcanvas">
                        <i class="bi bi-person-gear"></i>개인정보 수정
                    </a>
                    <a class="nav-link" href="#" data-bs-toggle="offcanvas"
                       data-bs-target="#myAddressOffcanvas" aria-controls="myAddressOffcanvas">
                        <i class="bi bi-geo-alt"></i>배송지 관리
                    </a>
                    <a class="nav-link" href="#" data-bs-toggle="offcanvas"
                       data-bs-target="#myReviewOffcanvas" aria-controls="myReviewOffcanvas">
                        <i class="bi bi-star"></i>거래 후기
                    </a>
                    <a class="nav-link text-danger" href="#" data-bs-toggle="offcanvas"
                       data-bs-target="#withdrawOffcanvas" aria-controls="withdrawOffcanvas">
                        <i class="bi bi-box-arrow-right"></i>탈퇴하기
                    </a>
                </div>
            </div>
        </aside>

        <!-- 메인 -->
        <main class="col-md-9">
            <div class="card mb-4">
                <div class="card-body p-4">
                    <div class="d-flex align-items-center mb-4">
                        <img src="${user.imageUrl}" class="rounded-circle me-3"
                             alt="avatar" width="80" height="80">
                        <div>
                            <h3 class="card-title mb-0">${user.nickname}</h3>
                            <p class="card-text text-muted">${user.bio}</p>
                        </div>
                    </div>

                    <div class="d-flex align-items-center">
                        <div class="rating-stars me-2">
                            <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-half"></i>
                        </div>
                        <span class="fs-4 fw-bold">4.5</span>
                        <span class="text-muted ms-2">/ 5.0</span>
                    </div>
                </div>
            </div>

            <!-- 내 상품 -->
            <div class="card">
                <div class="card-body p-4">
                    <h4 class="mb-4">내 상품</h4>

                    <ul class="nav nav-pills product-tabs mb-4" id="pills-tab" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active" id="pills-all-tab"
                                    data-bs-toggle="pill" data-bs-target="#pills-all"
                                    type="button" role="tab" aria-controls="pills-all"
                                    aria-selected="true">전체</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="pills-selling-tab"
                                    data-bs-toggle="pill" data-bs-target="#pills-selling"
                                    type="button" role="tab" aria-controls="pills-selling"
                                    aria-selected="false">판매중</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="pills-reserved-tab"
                                    data-bs-toggle="pill" data-bs-target="#pills-reserved"
                                    type="button" role="tab" aria-controls="pills-reserved"
                                    aria-selected="false">입찰중</button>
                        </li>
                    </ul>

                    <div class="tab-content" id="pills-tabContent">
                        <!-- 전체 탭 -->
                        <div class="tab-pane fade show active" id="pills-all"
                             role="tabpanel" aria-labelledby="pills-all-tab" tabindex="0">

                            <!-- AJAX 결과가 들어올 영역 -->
                            <div id="all-items" class="row g-3"></div>

                            <div class="text-center mt-4">
                                <button id="loadMoreBtn" class="btn btn-outline-primary">더보기</button>
                            </div>
                        </div>

                        <!-- 판매중 탭 -->
                        <div class="tab-pane fade" id="pills-selling"
                             role="tabpanel" aria-labelledby="pills-selling-tab" tabindex="0">
                            <div class="d-flex flex-column align-items-center justify-content-center py-5">
                                <h5 class="mb-3">판매중인 상품이 없습니다.</h5>
                                <img src="${pageContext.request.contextPath}/resources/images/404.png"
                                     class="img-fluid" style="max-width: 200px;">
                            </div>
                        </div>

                        <!-- 입찰중 탭 -->
                        <div class="tab-pane fade" id="pills-reserved"
                             role="tabpanel" aria-labelledby="pills-reserved-tab" tabindex="0">
                            <div class="d-flex flex-column align-items-center justify-content-center py-5">
                                <h5 class="mb-3">입찰중인 상품이 없습니다.</h5>
                                <img src="${pageContext.request.contextPath}/resources/images/404.png"
                                     class="img-fluid" style="max-width: 200px;">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<!-- 모달들 (비밀번호 확인, 후기 작성/보기 등) -->
<jsp:include page="mySales.jsp" />
<jsp:include page="myPurchases.jsp" />
<jsp:include page="myInterests.jsp" />
<jsp:include page="myAddress.jsp" />
<jsp:include page="myReview.jsp" />
<jsp:include page="withdraw.jsp" />
<jsp:include page="myInfo.jsp" />

<!-- 전체 상품 불러오기 스크립트 -->
<script>
$(document).ready(function() {
    let currentPage = 1;
    const pageSize = 20;
    const userId = $('#mypage-data').data('userId');
    const $allItems = $("#all-items");
    const $loadMoreBtn = $("#loadMoreBtn");

    function loadItems(page) {
        $.ajax({
            url: `${pageContext.request.contextPath}/item/\${userId}/all`,
            type: "GET",
            data: { page: page },
            success: function(data) {
                if (data && data.length > 0) {
                    data.forEach(item => {
                    	const cardHtml = `
                    	    <div class="col-md-3">
                    	        <div class="card h-100 shadow-sm">
                    	            <img src="${pageContext.request.contextPath}/\${item.imageUrl}" class="card-img-top">
                    	            <div class="card-body">
                    	                <h6 class="card-title text-truncate">\${item.title}</h6>
                    	                <p class="card-text fw-bold text-success">\${item.currentPrice}</p>
                    	            </div>
                    	        </div>
                    	    </div>
                    	`;
                        $allItems.append(cardHtml);
                    });
                } else {
                    $loadMoreBtn.hide();
                    if(page === 1) {
                        $allItems.html(`<p class="text-muted">등록된 상품이 없습니다.</p>`);
                    }
                }
            },
            error: function(xhr, status, error) {
                console.error("상품 불러오기 실패:", error);
            }
        });
    }

    // 첫 로드
    loadItems(currentPage);

    // 더보기 버튼 클릭
    $loadMoreBtn.on("click", function() {
        currentPage++;
        loadItems(currentPage);
    });
});
</script>

</body>
</html>
