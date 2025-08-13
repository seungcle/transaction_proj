<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	/* 커스텀 스타일 */
    .offcanvas-header {
        border-bottom: 1px solid #dee2e6;
    }
    .offcanvas-header .btn-close {
        display: none;
    }

    /* '내용 없음' 플레이스홀더 */
    .empty-placeholder {
        padding: 4rem 1rem;
        text-align: center;
        color: #6c757d;
    }
    .empty-placeholder .icon {
        font-size: 3rem;
        color: #ced4da;
    }
    
    /* 맨 위로 가기 버튼 */
    #scrollTopBtn {
        position: fixed; /* 화면에 고정 */
        bottom: 20px;
        right: 20px;
        display: none; /* 기본적으로 숨김 */
        z-index: 1100; /* Offcanvas 위에 표시되도록 z-index 설정 */
    }
</style>
</head>
<body>
	<div class="offcanvas offcanvas-end" tabindex="-1" id="myReviewOffcanvas" aria-labelledby="myReviewOffcanvasLabel">
    
    <div class="offcanvas-header">
        <button type="button" class="btn btn-link text-dark" data-bs-dismiss="offcanvas" aria-label="Close">
            <i class="bi bi-arrow-left fs-4"></i>
        </button>
        <h5 class="offcanvas-title w-100 text-center" id="offcanvasLabel">후기</h5>
        <div style="width: 40px;"></div>
    </div>
    
    <div class="offcanvas-body" id="reviewsBody">
        <section class="mb-4">
            <h5 class="mb-3 fw-bold">이런점이 좋았어요</h5>
            
            <div class="empty-placeholder">
                <div class="icon"><i class="bi bi-chat-quote"></i></div>
                <br><br>
                <p class="mt-3">받은 평가가 없습니다.</p>
            </div>
            
            </section>

        <hr class="my-2">

        <section class="mt-4">
             <h5 class="mb-3 fw-bold">상세한 후기도 있어요</h5>

             <div class="empty-placeholder">
                <div class="icon"><i class="bi bi-chat-quote"></i></div>
                <br><br>
                <p class="mt-3">작성된 후기가 없습니다.</p>
            </div>
            
             </section>
    </div>
</div>

<button type="button" class="btn btn-dark rounded-circle" id="scrollTopBtn">
    <i class="bi bi-arrow-up"></i>
</button>

<script>
    // 필요한 DOM 요소들을 가져옵니다.
    const reviewsOffcanvas = document.getElementById('reviewsOffcanvas');
    const reviewsBody = document.getElementById('reviewsBody'); // Offcanvas의 body
    const scrollTopBtn = document.getElementById('scrollTopBtn');

    // Offcanvas가 보여질 때 이벤트 리스너 추가
    reviewsOffcanvas.addEventListener('shown.bs.offcanvas', () => {
        // Offcanvas 내부의 스크롤에 따라 버튼을 보여주거나 숨깁니다.
        reviewsBody.addEventListener('scroll', () => {
            if (reviewsBody.scrollTop > 100) { // 100px 이상 스크롤되면
                scrollTopBtn.style.display = 'block'; // 버튼 보이기
            } else {
                scrollTopBtn.style.display = 'none'; // 버튼 숨기기
            }
        });
    });

    // Offcanvas가 숨겨질 때 버튼도 숨깁니다.
    reviewsOffcanvas.addEventListener('hidden.bs.offcanvas', () => {
        scrollTopBtn.style.display = 'none';
    });
    
    // '맨 위로' 버튼 클릭 시 부드럽게 스크롤
    scrollTopBtn.addEventListener('click', () => {
        reviewsBody.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    });
</script>
</body>
</html>