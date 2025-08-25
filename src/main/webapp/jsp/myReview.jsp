<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기</title>
<link rel="icon" type="image/png" href="../images/watermelon_icon.ico">

<!-- 전역/페이지 전용 CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/myreview.css">

<!-- Bootstrap Icons (필요 시 상위 페이지에서 중복 제거 가능) -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>
<div class="offcanvas offcanvas-end" tabindex="-1" id="myReviewOffcanvas" aria-labelledby="myReviewOffcanvasLabel">
  <div class="offcanvas-header">
    <h5 class="offcanvas-title w-100 text-center" id="offcanvasLabel">후기</h5>
    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
  </div>

  <div class="offcanvas-body" id="reviewsBody">
    <section class="mb-4">
      <h5 class="mb-3 fw-bold">이런점이 좋았어요</h5>
      <div class="empty-placeholder">
        <div class="icon"><i class="bi bi-chat-quote"></i></div>
        <p class="mt-3">받은 평가가 없습니다.</p>
      </div>
    </section>

    <hr class="my-2">

    <section class="mt-4">
      <h5 class="mb-3 fw-bold">상세한 후기도 있어요</h5>
      <div class="empty-placeholder">
        <div class="icon"><i class="bi bi-chat-quote"></i></div>
        <p class="mt-3">작성된 후기가 없습니다.</p>
      </div>
    </section>
  </div>
</div>

<button type="button" class="btn btn-dark rounded-circle" id="scrollTopBtn">
  <i class="bi bi-arrow-up"></i>
</button>

<script>
  const reviewsOffcanvas = document.getElementById('myReviewOffcanvas');
  const reviewsBody = document.getElementById('reviewsBody');
  const scrollTopBtn = document.getElementById('scrollTopBtn');

  // 오프캔버스 열릴 때
  reviewsOffcanvas.addEventListener('shown.bs.offcanvas', () => {
    reviewsBody.addEventListener('scroll', () => {
      scrollTopBtn.style.display = reviewsBody.scrollTop > 100 ? 'block' : 'none';
    });
  });

  // 오프캔버스 닫힐 때
  reviewsOffcanvas.addEventListener('hidden.bs.offcanvas', () => {
    scrollTopBtn.style.display = 'none';
  });

  // 맨 위로 버튼 클릭 시
  scrollTopBtn.addEventListener('click', () => {
    reviewsBody.scrollTo({ top: 0, behavior: 'smooth' });
  });
</script>
</body>
</html>
