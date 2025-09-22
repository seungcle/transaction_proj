<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기</title>
<link rel="icon" type="image/png" href="../images/watermelon_icon.ico">
<link rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet">
<link rel="stylesheet"
    href="${pageContext.request.contextPath}/resources/css/mypage-components.css">
<style>
/* 탭 관련 스타일 추가 */
.nav-tabs .nav-link.active {
    background-color: #fff;
    border-color: #dee2e6 #dee2e6 #fff;
    color: var(--bs-primary);
}

.review-item .badge {
    background-color: #e9ecef;
    color: #495057;
}

.review-item .review-stars i {
    color: #ffc107;
}

.offcanvas-title {
    font-weight: bold;
}
/* 수정 버튼과 날짜가 겹치지 않도록 flex를 사용 */
.written-review-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
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
    <div class="offcanvas offcanvas-end" tabindex="-1"
        id="myReviewOffcanvas" aria-labelledby="myReviewOffcanvasLabel"
        data-user-id="${sessionScope.user.id}">
        <div class="offcanvas-header">
            <button id="back-button" type="button"
                class="btn btn-link text-dark me-2 d-none">
                <i class="bi bi-arrow-left fs-4"></i>
            </button>
            <h5 class="offcanvas-title w-100 text-center" id="offcanvasLabel">거래
                후기</h5>
            <button type="button" class="btn-close" data-bs-dismiss="offcanvas"
                aria-label="Close"></button>
        </div>

        <div class="offcanvas-body" id="reviewsBody">
            <div id="review-list-view">
                <ul class="nav nav-tabs" id="reviewTabs" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button
                            class="nav-link active text-success" id="received-tab"
                            data-bs-toggle="tab" data-bs-target="#received-reviews"
                            type="button" role="tab" aria-controls="received-reviews"
                            aria-selected="true">받은 후기</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link text-success" id="written-tab"
                            data-bs-toggle="tab" data-bs-target="#written-reviews"
                            type="button" role="tab" aria-controls="written-reviews"
                            aria-selected="false">작성한 후기</button>
                    </li>
                </ul>

                <div class="tab-content pt-3" id="reviewTabsContent">
                    <div class="tab-pane fade show active" id="received-reviews"
                        role="tabpanel" aria-labelledby="received-tab">
                        <div class="empty-placeholder">
                            <div class="icon"><i class="bi bi-chat-quote"></i></div>
                            <p class="mt-3">받은 후기가 없습니다.</p>
                        </div>
                    </div>

                    <div class="tab-pane fade" id="written-reviews" role="tabpanel"
                        aria-labelledby="written-tab">
                        <div class="empty-placeholder">
                            <div class="icon"><i class="bi bi-pencil-square"></i></div>
                            <p class="mt-3">작성한 후기가 없습니다.</p>
                        </div>
                    </div>
                </div>
            </div>

            <div id="review-form-view" class="d-none">
                </div>
        </div>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        $(function() {
            const offcanvasEl = document.getElementById('myReviewOffcanvas');
            const userId = $(offcanvasEl).data('user-id');

            // 각 탭의 컨테이너와 데이터 로드 여부 플래그
            const receivedReviewsContainer = $('#received-reviews');
            const writtenReviewsContainer = $('#written-reviews');
            let receivedReviewsLoaded = false;
            let writtenReviewsLoaded = false;

            // =======================================================
            // 1. 받은 후기 관련 로직
            // =======================================================
            function loadReceivedReviews() {
                if (receivedReviewsLoaded) return; // 중복 로드 방지
                if (!userId) {
                    receivedReviewsContainer.html(createEmptyPlaceholder('유저 정보를 불러올 수 없습니다.', 'chat-quote'));
                    return;
                }
                
                receivedReviewsContainer.html('<p class="text-center p-5">후기를 불러오는 중...</p>');

                $.ajax({
                    url : '${pageContext.request.contextPath}/review/receive/' + userId,
                    type : 'GET',
                    dataType : 'json',
                    success : function(reviews) {
                        receivedReviewsContainer.empty();
                        if (reviews && reviews.length > 0) {
                            $.each(reviews, function(index, review) {
                                receivedReviewsContainer.append(createReceivedReviewHtml(review));
                            });
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
                        <div class="review-stars mb-2">\${renderStars(review.rating)}</div>
                        <div class="d-flex flex-wrap gap-2 mb-2">\${renderTags(review.label)}</div>
                        <p class="text-muted">\${reviewComment}</p>
                    </div>`;
            }

            // =======================================================
            // 2. 작성한 후기 관련 로직
            // =======================================================
            function loadWrittenReviews() {
                if (writtenReviewsLoaded) return; // 중복 로드 방지
                if (!userId) {
                    writtenReviewsContainer.html(createEmptyPlaceholder('유저 정보를 불러올 수 없습니다.', 'pencil-square'));
                    return;
                }

                writtenReviewsContainer.html('<p class="text-center p-5">후기를 불러오는 중...</p>');

                $.ajax({
                    url : '${pageContext.request.contextPath}/review/write/' + userId,
                    type : 'GET',
                    dataType : 'json',
                    success : function(reviews) {
                        writtenReviewsContainer.empty();
                        if (reviews && reviews.length > 0) {
                            $.each(reviews, function(index, review) {
                                writtenReviewsContainer.append(createWrittenReviewHtml(review));
                            });
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
            
            // [수정된 부분]
            function createWrittenReviewHtml(review) {
                const reviewComment = review.reviewComment || '';
                return `
                    <div class="review-item mb-4 pb-3 border-bottom">
                        <div class="written-review-header">
                            <h6 class="mb-0 fw-bold">\${review.nickname}님에게 남긴 후기</h6>
                            <small class="text-muted">\${review.createdAt}</small>
                        </div>
                        <small class="d-block text-muted mb-2">상품: \${review.title}</small>
                        <div class="review-stars mb-2">\${renderStars(review.rating)}</div>
                        <div class="d-flex flex-wrap gap-2 mb-2">\${renderTags(review.label)}</div>
                        <p class="text-muted">\${reviewComment}</p>
                    </div>`;
            }

            // =======================================================
            // 3. 공통 헬퍼 함수
            // =======================================================
            function createEmptyPlaceholder(message, icon) {
                return `
                    <div class="empty-placeholder">
                        <div class="icon"><i class="bi bi-\${icon}"></i></div>
                        <p class="mt-3">\${message}</p>
                    </div>`;
            }

            function renderStars(rating) {
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

            // =======================================================
            // 4. 이벤트 바인딩
            // =======================================================
            offcanvasEl.addEventListener('shown.bs.offcanvas', function() {
                // Offcanvas가 처음 열릴 때 활성화된 탭의 후기 목록을 로드
                loadReceivedReviews();
            });
            
            $('#received-tab').on('click', loadReceivedReviews);
            $('#written-tab').on('click', loadWrittenReviews);
        });
        
        // ===================================================================
        // 폼 보기/숨기기 관련 로직 (수정 기능이 없어져서 호출되지 않음)
        // ===================================================================
        const offcanvas = document.getElementById('myReviewOffcanvas');
        const views = {
            list : document.getElementById('review-list-view'),
            form : document.getElementById('review-form-view')
        };
        const offcanvasTitle = document.getElementById('offcanvasLabel');
        const backButton = document.getElementById('back-button');

        function showView(viewName) {
            for ( const key in views) {
                views[key].classList.add('d-none');
            }
            views[viewName].classList.remove('d-none');
            if (viewName === 'list') {
                backButton.classList.add('d-none');
                offcanvasTitle.textContent = '거래 후기';
                backButton.onclick = null;
            } else if (viewName === 'form') {
                backButton.classList.remove('d-none');
                backButton.onclick = () => showView('list');
            }
        }
    </script>
</body>
</html>