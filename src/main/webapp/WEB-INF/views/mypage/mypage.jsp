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

<style>
    .item-image-wrapper {
        position: relative;
    }
    .item-overlay {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.6); /* 검은색 반투명 오버레이 */
        display: flex;
        justify-content: center;
        align-items: center;
        color: white; /* 텍스트 색상 */
        font-size: 1.2rem;
        font-weight: bold;
        text-align: center;
    }
</style>
</head>

<body>
<jsp:include page="../component/header.jsp" />

<div class="container py-5">
    <div class="row">
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
                    <a class="nav-link" href="#" data-bs-toggle="offcanvas"
                        data-bs-target="#myChatOffcanvas" aria-controls="myChatOffcanvas">
                        <i class="bi bi-chat-dots"></i>채팅
                    </a>
                    <hr>
                    <span class="text-muted ps-2 mb-2 fw-bold">내 정보</span>
                    <a class="nav-link" href="#" data-bs-toggle="offcanvas"
                        data-bs-target="#myInfoOffcanvas" aria-controls="myInfoOffcanvas">
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

        <main class="col-md-9">
            <div class="card mb-4">
                <div class="card-body p-4">
                    <div class="d-flex align-items-center mb-4">
                        <img src="<%=request.getContextPath()%>/${user.imageUrl}" id="mypageProfileImage" class="rounded-circle me-3" alt="Profile Image Preview" width="80" height="80">
                        <div>
                            <h3 class="card-title mb-0">${user.nickname}</h3>
                            <p class="card-text text-muted">${user.bio}</p>
                        </div>
                    </div>

                    <%-- Ajax로 평점과 별점을 표시할 영역 --%>
                    <div class="d-flex align-items-center">
                        <div id="user-rating-stars" class="rating-stars me-2">
                            <%-- JavaScript가 별 아이콘을 동적으로 채웁니다. --%>
                        </div>
                        <span id="rating-score" class="fs-4 fw-bold"></span>
                        <span class="text-muted ms-2">/ 5.0</span>
                    </div>
                </div>
            </div>

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
                        <div class="tab-pane fade show active" id="pills-all"
                            role="tabpanel" aria-labelledby="pills-all-tab" tabindex="0">

                            <div id="all-items" class="row g-3"></div>

                            <div class="text-center mt-4">
                                <button id="loadMoreBtn" class="btn btn-outline-primary">더보기</button>
                            </div>
                        </div>

                        <div class="tab-pane fade" id="pills-selling"
                           role="tabpanel" aria-labelledby="pills-selling-tab" tabindex="0">
                        
                            <div id="sale-items" class="row g-3"></div>
                        
                            <div class="text-center mt-4">
                                <button id="loadMoreSaleBtn" class="btn btn-outline-primary">더보기</button>
                            </div>
                        </div>

                        <div class="tab-pane fade" id="pills-reserved"
                            role="tabpanel" aria-labelledby="pills-reserved-tab" tabindex="0">

                            <div id="bid-items" class="row g-3"></div>

                            <div class="text-center mt-4">
                                <button id="loadMoreBidBtn" class="btn btn-outline-primary">더보기</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<jsp:include page="mySales.jsp" />
<jsp:include page="myPurchases.jsp" />
<jsp:include page="myInterests.jsp" />
<jsp:include page="myChat.jsp" />
<jsp:include page="myAddress.jsp" />
<jsp:include page="myReview.jsp" />
<jsp:include page="withdraw.jsp" />
<jsp:include page="myInfo.jsp" />

<script>
$(document).ready(function() {
    // 페이지 번호 상태 관리
    let currentPageAll = 1;
    let currentPageSale = 1;
    let currentPageBid = 1;
    
    const userId = $('#mypage-data').data('userId');

    /**
     * ==========================================================
     * 사용자 평점 및 별점 표시를 위한 Ajax 코드
     * ==========================================================
     */
    
    // 별점 HTML을 생성하는 함수
    function renderStars(rating) {
        let starsHtml = '';
        const fullStars = Math.floor(rating); // 채워진 별 개수
        const hasHalfStar = rating % 1 >= 0.5; // 반쪽 별 여부
        
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

    // 사용자 평점 불러오기 함수
    function loadUserRating() {
        $.ajax({
            url: `${pageContext.request.contextPath}/review/rating/average/\${userId}`,
            type: "GET",
            success: function(rating) {
                if (rating && rating > 0) {
                    $('#rating-score').text(rating.toFixed(1));
                    $('#user-rating-stars').html(renderStars(rating));
                } else {
                    $('#rating-score').text('0.0');
                    $('#user-rating-stars').html(renderStars(0));
                }
            },
            error: function(xhr, status, error) {
                console.error("평점 정보를 불러오는 데 실패했습니다:", error);
                $('#rating-score').text('0.0');
                $('#user-rating-stars').html(renderStars(0));
            }
        });
    }

    // 페이지 로드 시 평점 정보 불러오기 실행
    loadUserRating();

    // 각 탭의 콘텐츠 영역
    const $allItems = $("#all-items");
    const $saleItems = $("#sale-items");
    const $bidItems = $("#bid-items");

    // 각 탭의 '더보기' 버튼
    const $loadMoreBtn = $("#loadMoreBtn");
    const $loadMoreSaleBtn = $("#loadMoreSaleBtn");
    const $loadMoreBidBtn = $("#loadMoreBidBtn");
    
    // URL 파라미터 체크 (채팅창 바로 열기)
    const params = new URLSearchParams(window.location.search);
    if (params.get("openChat") === "true") {
        const offcanvas = new bootstrap.Offcanvas(document.getElementById("myChatOffcanvas"));
        offcanvas.show();
    }

    // 👇 item 카드 HTML 생성 함수 (수정됨)
    function createItemCard(item) {
        // item.status가 'OPEN'이 아닐 경우 '경매종료' 오버레이를 생성
        const isSoldOut = item.status !== 'OPEN';
        const overlayHtml = isSoldOut ? `
            <div class="item-overlay">
                <span>경매종료</span>
            </div>` : '';

        return `
            <div class="col-md-3">
                <a href="${pageContext.request.contextPath}/item/\${item.id}" class="card-link" style="text-decoration: none; color: inherit;">
                    <div class="card h-100 shadow-sm">
                        <div class="item-image-wrapper">
                            <img src="${pageContext.request.contextPath}/\${item.imageUrl}" class="card-img-top" style="height: 150px; object-fit: cover;">
                            \${overlayHtml} </div>
                        <div class="card-body">
                            <h6 class="card-title text-truncate">\${item.title}</h6>
                            <p class="card-text fw-bold text-success">\${item.currentPrice.toLocaleString()}</p>
                        </div>
                    </div>
                </a>
            </div>
        `;
    }
    
    // 전체 상품 불러오기
    function loadAllItems(page) {
        $.ajax({
            url: `${pageContext.request.contextPath}/item/\${userId}/all`,
            type: "GET",
            data: { page: page },
            success: function(data) {
                if (data && data.length > 0) {
                    data.forEach(item => {
                        $allItems.append(createItemCard(item));
                    });
                } else {
                    $loadMoreBtn.hide();
                    if(page === 1) {
                        $allItems.html(`<p class="text-center text-muted col-12 mt-4">등록된 상품이 없습니다.</p>`);
                    }
                }
            },
            error: function(xhr, status, error) {
                console.error("전체 상품 불러오기 실패:", error);
            }
        });
    }

    // 판매중 상품 불러오기
    function loadSaleItems(page) {
        $.ajax({
            url: `${pageContext.request.contextPath}/item/\${userId}/sale`,
            type: "GET",
            data: { page: page },
            success: function(data) {
                if (data && data.length > 0) {
                    data.forEach(item => {
                        $saleItems.append(createItemCard(item));
                    });
                } else {
                    $loadMoreSaleBtn.hide();
                    if(page === 1) {
                        $saleItems.html(`<p class="text-center text-muted col-12 mt-4">판매중인 상품이 없습니다.</p>`);
                    }
                }
            },
            error: function(xhr, status, error) {
                console.error("판매중 상품 불러오기 실패:", error);
            }
        });
    }

    // 입찰중 상품 불러오기
    function loadBidItems(page) {
        $.ajax({
            url: `${pageContext.request.contextPath}/item/\${userId}/bid`,
            type: "GET",
            data: { page: page },
            success: function(data) {
                if (data && data.length > 0) {
                    data.forEach(item => {
                        $bidItems.append(createItemCard(item));
                    });
                } else {
                    $loadMoreBidBtn.hide();
                    if(page === 1) {
                        $bidItems.html(`<p class="text-center text-muted col-12 mt-4">입찰중인 상품이 없습니다.</p>`);
                    }
                }
            },
            error: function(xhr, status, error) {
                console.error("입찰중 상품 불러오기 실패:", error);
                $bidItems.html(`<p class="text-center text-danger col-12 mt-4">상품을 불러오는 중 오류가 발생했습니다.</p>`);
            }
        });
    }

    // 최초 페이지 로드 시 '전체' 탭 상품만 불러오기
    loadAllItems(currentPageAll);

    // '더보기' 버튼 클릭 이벤트 (전체)
    $loadMoreBtn.on("click", function() {
        currentPageAll++;
        loadAllItems(currentPageAll);
    });

    // '판매중' 탭이 보일 때 데이터 로드 (최초 한 번만)
    $('#pills-selling-tab').on('shown.bs.tab', function() {
        if(currentPageSale === 1 && $saleItems.children().length === 0) {
            loadSaleItems(currentPageSale);
        }
    });

    // '더보기' 버튼 클릭 이벤트 (판매중)
    $loadMoreSaleBtn.on("click", function() {
        currentPageSale++;
        loadSaleItems(currentPageSale);
    });

    // '입찰중' 탭이 보일 때 데이터 로드 (최초 한 번만)
    $('#pills-reserved-tab').on('shown.bs.tab', function() {
        if(currentPageBid === 1 && $bidItems.children().length === 0) {
            loadBidItems(currentPageBid);
        }
    });

    // '더보기' 버튼 클릭 이벤트 (입찰중)
    $loadMoreBidBtn.on("click", function() {
        currentPageBid++;
        loadBidItems(currentPageBid);
    });
});
</script>
<jsp:include page="../component/footer.jsp" />
</body>
</html>