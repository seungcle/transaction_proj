<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>리뷰 작성</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
       /* 별점 시스템을 위한 커스텀 CSS (개선안) */
    .star-rating {
        display: inline-flex;
    }

    .star-rating .star {
        font-size: 2.5rem;
        cursor: pointer;
        transition: color 0.2s ease-in-out;
    }
    
    /* 빈 별 (bi-star)은 부드러운 연한 노란색으로 설정 */
    .star-rating .bi-star {
        color: #ffe082; /* 연한 노-란색 */
    }

    /* 반 별(bi-star-half)과 꽉 찬 별(bi-star-fill)은 뚜렷한 노란색으로 설정 */
    .star-rating .bi-star-half,
    .star-rating .bi-star-fill {
        color: #ffc107; /* 진한 노란색 */
    }
    </style>
</head>
<body class="bg-light">
    <jsp:include page="../component/header.jsp" />

    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-7">
                <div class="card shadow-sm border-0">
                    <div class="card-body p-lg-5 p-4">
                        <h1 class="card-title text-center mb-5 h2 fw-bold">리뷰를 남겨주세요</h1>
                        <form action="${pageContext.request.contextPath}/review/submit" method="post">
                            <input type="hidden" name="userId2" value="${param.sellerId}">
                            <input type="hidden" name="itemId" value="${param.itemId}">

                            <div class="mb-4 text-center">
                                <label class="form-label fw-semibold fs-5 mb-3 d-block">⭐ 만족도</label>
                                <div id="star-rating-container" class="star-rating" data-rating="0">
                                    <i class="star bi bi-star" data-value="1"></i>
                                    <i class="star bi bi-star" data-value="2"></i>
                                    <i class="star bi bi-star" data-value="3"></i>
                                    <i class="star bi bi-star" data-value="4"></i>
                                    <i class="star bi bi-star" data-value="5"></i>
                                </div>
                                <input type="hidden" name="rating" id="rating-value" value="0" required>
                            </div>

                            <div class="mb-4">
                                <label class="form-label fw-semibold fs-5 mb-3">👍 어떤 점이 좋았나요?</label>
                                <div class="d-flex flex-wrap gap-3">
                                    <c:forEach var="tag" items="${allTags}" varStatus="status">
                                        <input type="checkbox" class="btn-check" name="tagIds" id="tag-${status.index}" value="${tag.id}" autocomplete="off">
                                        <label class="btn btn-outline-primary rounded-pill" for="tag-${status.index}">${tag.label}</label>
                                    </c:forEach>
                                </div>
                            </div>

                            <div class="mb-5">
                                <label for="reviewComment" class="form-label fw-semibold fs-5 mb-3">✍️ 리뷰 내용</label>
                                <textarea class="form-control" id="reviewComment" name="reviewComment" rows="5" placeholder="자세한 리뷰를 남겨주시면 다른 사람에게 큰 도움이 됩니다."></textarea>
                            </div>

                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary btn-lg fw-bold">리뷰 등록하기</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="../component/footer.jsp" />
    
    <script>
        // DOM이 모두 로드된 후 스크립트 실행
        document.addEventListener('DOMContentLoaded', function () {
            const starRatingContainer = document.getElementById('star-rating-container');
            const stars = starRatingContainer.querySelectorAll('.star');
            const ratingInput = document.getElementById('rating-value');

            // 별의 현재 상태(빈별, 반별, 꽉찬별)를 업데이트하는 함수
            function updateStars(rating) {
                stars.forEach(star => {
                    const starValue = parseFloat(star.dataset.value);
                    star.classList.remove('bi-star-fill', 'bi-star-half', 'bi-star'); // 기존 클래스 초기화

                    if (rating >= starValue) {
                        star.classList.add('bi-star-fill'); // 꽉 찬 별
                    } else if (rating >= starValue - 0.5) {
                        star.classList.add('bi-star-half'); // 반 별
                    } else {
                        star.classList.add('bi-star'); // 빈 별
                    }
                });
            }
            
            // 마우스가 별 위에서 움직일 때 실시간으로 상태 변경 (호버 효과)
            starRatingContainer.addEventListener('mousemove', function (e) {
                const rect = e.currentTarget.getBoundingClientRect();
                const mouseX = e.clientX - rect.left;
                const totalWidth = rect.width;
                const hoverRating = (mouseX / totalWidth) * 5;
                const snappedRating = Math.round(hoverRating * 2) / 2; // 0.5 단위로 맞춤
                
                updateStars(snappedRating);
            });

            // 마우스가 별 영역을 벗어났을 때, 마지막으로 클릭된 상태로 복원
            starRatingContainer.addEventListener('mouseleave', function () {
                const currentRating = parseFloat(ratingInput.value);
                updateStars(currentRating);
            });
            
            // 별을 클릭했을 때 최종 평점 확정
            starRatingContainer.addEventListener('click', function (e) {
                const rect = e.currentTarget.getBoundingClientRect();
                const mouseX = e.clientX - rect.left;
                const totalWidth = rect.width;
                const finalRating = Math.round((mouseX / totalWidth) * 5 * 2) / 2;
                
                ratingInput.value = finalRating; // 숨겨진 input에 최종 값 저장
                starRatingContainer.dataset.rating = finalRating; // 컨테이너에도 저장
                updateStars(finalRating);
            });

            // 페이지 로드 시 초기 별점 상태 설정
            updateStars(parseFloat(ratingInput.value));
        });
    </script>
</body>
</html>