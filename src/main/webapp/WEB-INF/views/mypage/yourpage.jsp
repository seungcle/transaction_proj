<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>유저 페이지</title>
<link rel="icon" type="image/png"
    href="${pageContext.request.contextPath}/resources/images/watermelon_icon.ico">
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet">
<link rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link rel="stylesheet"
    href="${pageContext.request.contextPath}/resources/css/userpage.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<style>
    /* 별점 */
    .rating-stars {
        font-size: 1.5rem; /* 기존 크기보다 약간 조정 */
        display: flex;
        align-items: center;
        gap: 4px;
    }
    
    /* 별 아이콘 스타일 */
    .rating-stars i, .review-stars i {
        color: #ffc107;
    }
    .item-image-wrapper {
        position: relative;
    }
    .item-overlay {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.6);
        display: flex;
        justify-content: center;
        align-items: center;
        color: white;
        font-size: 1.2rem;
        font-weight: bold;
        text-align: center;
    }
    /* 후기 탭 관련 스타일 */
    .nav-tabs .nav-link.active {
        background-color: #fff;
        border-color: #dee2e6 #dee2e6 #fff;
        color: var(--bs-success); /* primary에서 success로 변경하여 통일성 유지 */
    }
    .review-item .badge {
        background-color: #e9ecef;
        color: #495057;
    }
    .empty-placeholder {
        text-align: center;
        padding: 40px 0;
        color: #6c757d;
    }
    .empty-placeholder .icon i {
        font-size: 3rem;
        color: #ced4da;
    }
</style>
</head>
<body>
    <jsp:include page="../component/header.jsp" />

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div id="userpage-data" data-user-id="${user.id}"></div>

            <div class="card mb-4">
                <div class="card-body p-4">
                    <div class="d-flex align-items-center mb-3">
                        <img src="${pageContext.request.contextPath}/${user.imageUrl}" class="rounded-circle me-3"
                            alt="avatar" width="80" height="80">
                        <div>
                            <h3 class="card-title mb-1">${user.nickname}</h3>
                            <p class="card-text text-muted mb-0">${user.bio}</p>
                        </div>
                    </div>

                    <div class="d-flex align-items-center mb-3">
                        <div id="user-rating-stars" class="rating-stars me-2">
                            <%-- JavaScript가 별 아이콘을 동적으로 채웁니다. --%>
                        </div>
                        <span id="rating-score" class="fs-4 fw-bold"></span>
                        <span class="text-muted ms-2">/ 5.0</span>
                    </div>

                    <a href="#reviews-section" id="review-link" class="text-decoration-none text-dark d-flex align-items-center justify-content-between">
                        <div class="d-flex align-items-center">
                            <span class="text-muted me-2">받은 후기 <span id="review-count" class="fw-bold">0</span>개</span>
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
                    </ul>
                    <div class="tab-content" id="pills-tabContent">
                        <div class="tab-pane fade show active" id="pills-all" role="tabpanel" aria-labelledby="pills-all-tab" tabindex="0">
                            <div id="all-items" class="row g-3"></div>
                            <div class="text-center mt-4">
                                <button id="loadMoreBtn" class="btn btn-outline-primary">더보기</button>
                            </div>
                        </div>

                        <div class="tab-pane fade" id="pills-selling" role="tabpanel" aria-labelledby="pills-selling-tab" tabindex="0">
                            <div id="sale-items" class="row g-3"></div>
                            <div class="text-center mt-4">
                                <button id="loadMoreSaleBtn" class="btn btn-outline-primary">더보기</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card mt-4" id="reviews-section">
                <div class="card-body p-4">
                    <h4 class="mb-4">거래 후기</h4>
                    <ul class="nav nav-tabs" id="reviewTabs" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active text-success" id="received-tab" data-bs-toggle="tab" data-bs-target="#received-reviews" type="button" role="tab" aria-controls="received-reviews" aria-selected="true">받은 후기</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link text-success" id="written-tab" data-bs-toggle="tab" data-bs-target="#written-reviews" type="button" role="tab" aria-controls="written-reviews" aria-selected="false">작성한 후기</button>
                        </li>
                    </ul>
                    <div class="tab-content pt-3" id="reviewTabsContent">
                        <div class="tab-pane fade show active" id="received-reviews" role="tabpanel" aria-labelledby="received-tab">
                            </div>
                        <div class="tab-pane fade" id="written-reviews" role="tabpanel" aria-labelledby="written-tab">
                            </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../component/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
$(document).ready(function() {
    // ==========================================================
    // 기본 정보 및 변수 설정
    // ==========================================================
    const userId = $('#userpage-data').data('userId');
    let currentPageAll = 1;
    let currentPageSale = 1;

    // ==========================================================
    // 사용자 평점 및 별점 표시
    // ==========================================================
    function renderStarsForRating(rating) {
        let starsHtml = '';
        const fullStars = Math.floor(rating);
        const hasHalfStar = rating % 1 >= 0.5;
        
        for (let i = 1; i <= 5; i++) {
            if (i <= fullStars) {
                starsHtml += '<i class="bi bi-star-fill"></i>';
            } else if (i === fullStars + 1 && hasHalfStar) {
                starsHtml += '<i class="bi bi-star-half"></i>';
            } else {
                starsHtml += '<i class="bi bi-star"></i>';
            }
        }
        return starsHtml;
    }

    function loadUserRating() {
        $.ajax({
            url: `${pageContext.request.contextPath}/review/rating/average/\${userId}`,
            type: "GET",
            success: function(rating) {
                if (rating && rating > 0) {
                    $('#rating-score').text(rating.toFixed(1));
                    $('#user-rating-stars').html(renderStarsForRating(rating));
                } else {
                    $('#rating-score').text('0.0');
                    $('#user-rating-stars').html(renderStarsForRating(0));
                }
            },
            error: function() {
                $('#rating-score').text('0.0');
                $('#user-rating-stars').html(renderStarsForRating(0));
            }
        });
    }

    // ==========================================================
    // 판매 상품 목록 표시
    // ==========================================================
    const $allItems = $("#all-items");
    const $saleItems = $("#sale-items");
    const $loadMoreBtn = $("#loadMoreBtn");
    const $loadMoreSaleBtn = $("#loadMoreSaleBtn");
    
    function createItemCard(item) {
        const isSoldOut = item.status !== 'OPEN';
        const overlayHtml = isSoldOut ? `<div class="item-overlay"><span>경매종료</span></div>` : '';
        return `
            <div class="col-6 col-md-4 mb-4">
                <a href="${pageContext.request.contextPath}/item/\${item.id}" class="card-link" style="text-decoration: none; color: inherit;">
                    <div class="card h-100 shadow-sm">
                        <div class="item-image-wrapper">
                            <img src="${pageContext.request.contextPath}/\${item.imageUrl}" class="card-img-top" style="height: 150px; object-fit: cover;">
                            \${overlayHtml}
                        </div>
                        <div class="card-body">
                            <h6 class="card-title text-truncate">\${item.title}</h6>
                            <p class="card-text fw-bold text-success">\${item.currentPrice.toLocaleString()}</p>
                        </div>
                    </div>
                </a>
            </div>`;
    }
    
    function loadAllItems(page) {
        $.ajax({
            url: `${pageContext.request.contextPath}/item/\${userId}/all`,
            type: "GET", data: { page: page },
            success: function(data) {
                if (data && data.length > 0) {
                    data.forEach(item => $allItems.append(createItemCard(item)));
                } else {
                    $loadMoreBtn.hide();
                    if(page === 1) $allItems.parent().html(`<p class="text-center text-muted col-12 my-5">등록된 상품이 없습니다.</p>`);
                }
            }
        });
    }

    function loadSaleItems(page) {
        $.ajax({
            url: `${pageContext.request.contextPath}/item/\${userId}/sale`,
            type: "GET", data: { page: page },
            success: function(data) {
                if (data && data.length > 0) {
                    data.forEach(item => $saleItems.append(createItemCard(item)));
                } else {
                    $loadMoreSaleBtn.hide();
                    if(page === 1) $saleItems.parent().html(`<p class="text-center text-muted col-12 my-5">판매중인 상품이 없습니다.</p>`);
                }
            }
        });
    }

    // ==========================================================
    // 거래 후기 관련 로직 (신규 추가)
    // ==========================================================
    const receivedReviewsContainer = $('#received-reviews');
    const writtenReviewsContainer = $('#written-reviews');
    let receivedReviewsLoaded = false;
    let writtenReviewsLoaded = false;

    function loadReceivedReviews() {
        if (receivedReviewsLoaded) return;
        receivedReviewsContainer.html('<p class="text-center p-5">후기를 불러오는 중...</p>');

        $.ajax({
            url : '${pageContext.request.contextPath}/review/receive/' + userId,
            type : 'GET', dataType : 'json',
            success : function(reviews) {
                receivedReviewsContainer.empty();
                if (reviews && reviews.length > 0) {
                    $('#review-count').text(reviews.length); // 후기 개수 업데이트
                    $.each(reviews, (index, review) => receivedReviewsContainer.append(createReceivedReviewHtml(review)));
                } else {
                    receivedReviewsContainer.html(createEmptyPlaceholder('받은 후기가 없습니다.', 'chat-quote'));
                }
                receivedReviewsLoaded = true;
            },
            error : function() {
                receivedReviewsContainer.html(createEmptyPlaceholder('후기를 불러오는 중 오류가 발생했습니다.', 'chat-quote'));
            }
        });
    }

    function createReceivedReviewHtml(review) {
        const reviewComment = review.reviewComment || '';
        return `
            <div class="review-item mb-4 pb-3 border-bottom">
                <div class="d-flex justify-content-between align-items-center mb-2">
                    <h6 class="mb-0 fw-bold">\${review.nickname}</h6>
                    <small class="text-muted">\${review.createdAt}</small>
                </div>
                <small class="d-block text-muted mb-2">상품: \${review.title}</small>
                <div class="review-stars mb-2">\${renderStarsForReview(review.rating)}</div>
                <div class="d-flex flex-wrap gap-2 mb-2">\${renderTags(review.label)}</div>
                <p class="text-muted">\${reviewComment}</p>
            </div>`;
    }

    function loadWrittenReviews() {
        if (writtenReviewsLoaded) return;
        writtenReviewsContainer.html('<p class="text-center p-5">후기를 불러오는 중...</p>');

        $.ajax({
            url : '${pageContext.request.contextPath}/review/write/' + userId,
            type : 'GET', dataType : 'json',
            success : function(reviews) {
                writtenReviewsContainer.empty();
                if (reviews && reviews.length > 0) {
                    $.each(reviews, (index, review) => writtenReviewsContainer.append(createWrittenReviewHtml(review)));
                } else {
                    writtenReviewsContainer.html(createEmptyPlaceholder('작성한 후기가 없습니다.', 'pencil-square'));
                }
                writtenReviewsLoaded = true;
            },
            error : function() {
                writtenReviewsContainer.html(createEmptyPlaceholder('후기를 불러오는 중 오류가 발생했습니다.', 'pencil-square'));
            }
        });
    }
    
    function createWrittenReviewHtml(review) {
        const reviewComment = review.reviewComment || '';
        return `
            <div class="review-item mb-4 pb-3 border-bottom">
                <div class="d-flex justify-content-between align-items-center mb-2">
                    <h6 class="mb-0 fw-bold">\${review.nickname}님에게 남긴 후기</h6>
                    <small class="text-muted">\${review.createdAt}</small>
                </div>
                <small class="d-block text-muted mb-2">상품: \${review.title}</small>
                <div class="review-stars mb-2">\${renderStarsForReview(review.rating)}</div>
                <div class="d-flex flex-wrap gap-2 mb-2">\${renderTags(review.label)}</div>
                <p class="text-muted">\${reviewComment}</p>
            </div>`;
    }

    function createEmptyPlaceholder(message, icon) {
        return `
            <div class="empty-placeholder">
                <div class="icon"><i class="bi bi-\${icon}"></i></div>
                <p class="mt-3">\${message}</p>
            </div>`;
    }

    function renderStarsForReview(rating) {
        let stars = '';
        for (let i = 1; i <= 5; i++) {
            if (i <= rating) stars += '<i class="bi bi-star-fill"></i>';
            else if (i - 0.5 <= rating) stars += '<i class="bi bi-star-half"></i>';
            else stars += '<i class="bi bi-star"></i>';
        }
        return stars;
    }

    function renderTags(tags) {
        if (!tags || tags.length === 0) return '';
        return tags.map(tag => `<span class="badge rounded-pill text-bg-secondary">#\${tag}</span>`).join(' ');
    }
    
    // ==========================================================
    // 초기화 및 이벤트 바인딩
    // ==========================================================
    
    // 페이지 로드 시 초기 데이터 로드
    loadUserRating();
    loadAllItems(currentPageAll);
    loadReceivedReviews(); // 받은 후기 목록을 기본으로 로드

    // 이벤트 핸들러
    $loadMoreBtn.on("click", () => {
        currentPageAll++;
        loadAllItems(currentPageAll);
    });
    $('#pills-selling-tab').on('shown.bs.tab', () => {
        if (currentPageSale === 1 && $saleItems.children().length === 0) {
            loadSaleItems(currentPageSale);
        }
    });
    $loadMoreSaleBtn.on("click", () => {
        currentPageSale++;
        loadSaleItems(currentPageSale);
    });

    // 후기 탭 클릭 이벤트
    $('#received-tab').on('click', loadReceivedReviews);
    $('#written-tab').on('click', loadWrittenReviews);

    // 프로필 카드 후기 링크 클릭 시 스크롤
    $('#review-link').on('click', function(e) {
        e.preventDefault();
        $('html, body').animate({
            scrollTop: $('#reviews-section').offset().top
        }, 500);
    });
});
</script>
</body>
</html>