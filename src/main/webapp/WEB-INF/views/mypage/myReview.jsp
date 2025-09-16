<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%
    // 실제로는 DB에서 사용자의 후기 데이터를 가져와야 합니다.
    // 여기서는 동적 구현을 보여주기 위해 임시 데이터를 생성합니다.

    // 내가 받은 후기 (다른 사람이 나에게 남긴 후기)
    List<Map<String, Object>> receivedReviews = new ArrayList<>();
    Map<String, Object> receivedReview1 = new HashMap<>();
    receivedReview1.put("reviewer", "5성티원");
    receivedReview1.put("productName", "V3 PRO 페이커 에디션 새 상품");
    receivedReview1.put("rating", 4);
    receivedReview1.put("tags", Arrays.asList("#상세설명 정확", "#상품 상태 좋음"));
    receivedReview1.put("content", "상품 상태가 정말 좋고, 상세 설명과 일치해서 좋았습니다.");
    receivedReview1.put("date", "2025-08-28");
    receivedReviews.add(receivedReview1);
    
    Map<String, Object> receivedReview2 = new HashMap<>();
    receivedReview2.put("reviewer", "차분한오후화강암");
    receivedReview2.put("productName", "반려돌");
    receivedReview2.put("rating", 5);
    receivedReview2.put("tags", Arrays.asList("#신속한 거래", "#꼼꼼한 포장", "#약속 준수"));
    receivedReview2.put("content", "배송이 빠르고 포장이 꼼꼼해서 감동했습니다. 다음에도 거래하고 싶어요!");
    receivedReview2.put("date", "2025-08-20");
    receivedReviews.add(receivedReview2);

    // 내가 쓴 후기 (내가 다른 사람에게 남긴 후기)
    List<Map<String, Object>> writtenReviews = new ArrayList<>();
    Map<String, Object> writtenReview1 = new HashMap<>();
    writtenReview1.put("reviewId", 1); // 수정 기능을 위해 ID 추가
    writtenReview1.put("reviewee", "따뜻한오후라벤더");
    writtenReview1.put("productName", "빈티지 블루투스 스피커");
    writtenReview1.put("rating", 5);
    writtenReview1.put("tags", Arrays.asList("#원활한 소통", "#빠른 응대", "#약속 준수"));
    writtenReview1.put("content", "판매자님과 소통이 원활해서 기분 좋은 거래였습니다. 배송도 빠르고 약속도 잘 지켜주셨네요.");
    writtenReview1.put("date", "2025-08-25");
    writtenReviews.add(writtenReview1);
%>
<!DOCTYPE html>
<meta charset="UTF-8">
<title>후기</title>
<link rel="icon" type="image/png" href="../images/watermelon_icon.ico">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/mypage-components.css">
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
.review-item-buttons {
    position: absolute;
    top: 10px;
    right: 10px;
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
	<div class="offcanvas offcanvas-end" tabindex="-1"
		id="myReviewOffcanvas" aria-labelledby="myReviewOffcanvasLabel">
		<div class="offcanvas-header">
			<button id="back-button" type="button"
				class="btn btn-link text-dark me-2 d-none">
				<i class="bi bi-arrow-left fs-4"></i>
			</button>
			<h5 class="offcanvas-title w-100 text-center" id="offcanvasLabel">거래 후기</h5>
			<button type="button" class="btn-close" data-bs-dismiss="offcanvas"
				aria-label="Close"></button>
		</div>

		<div class="offcanvas-body" id="reviewsBody">
			<div id="review-list-view">
				<ul class="nav nav-tabs" id="reviewTabs" role="tablist">
					<li class="nav-item" role="presentation">
						<button class="nav-link active text-success" id="received-tab" data-bs-toggle="tab"
							data-bs-target="#received-reviews" type="button" role="tab"
							aria-controls="received-reviews" aria-selected="true">받은 후기</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link text-success" id="written-tab" data-bs-toggle="tab"
							data-bs-target="#written-reviews" type="button" role="tab"
							aria-controls="written-reviews" aria-selected="false">작성한 후기</button>
					</li>
				</ul>
	
				<div class="tab-content pt-3" id="reviewTabsContent">
					<div class="tab-pane fade show active" id="received-reviews" role="tabpanel" aria-labelledby="received-tab">
						<% if (receivedReviews.isEmpty()) { %>
							<div class="empty-placeholder">
								<div class="icon">
									<i class="bi bi-chat-quote"></i>
								</div>
								<p class="mt-3">받은 후기가 없습니다.</p>
							</div>
						<% } else { %>
							<% for (Map<String, Object> review : receivedReviews) { %>
								<div class="review-item mb-4">
									<div class="d-flex justify-content-between align-items-center mb-2">
										<h6 class="mb-0 fw-bold"><%= review.get("reviewer") %></h6>
										<small class="text-muted"><%= review.get("date") %></small>
									</div>
									<small class="d-block text-muted mb-2">상품: <%= review.get("productName") %></small>
									<div class="review-stars mb-2">
										<% int rating = (int) review.get("rating");
											for (int i = 0; i < 5; i++) { %>
											<i class="bi <%= (i < rating) ? "bi-star-fill" : "bi-star" %>"></i>
										<% } %>
									</div>
									<div class="d-flex flex-wrap gap-2 mb-2">
										<% for (String tag : (List<String>) review.get("tags")) { %>
											<span class="badge rounded-pill text-bg-secondary"><%= tag %></span>
										<% } %>
									</div>
									<p class="text-muted"><%= review.get("content") %></p>
								</div>
							<% } %>
						<% } %>
					</div>
	
					<div class="tab-pane fade" id="written-reviews" role="tabpanel" aria-labelledby="written-tab">
						<% if (writtenReviews.isEmpty()) { %>
							<div class="empty-placeholder">
								<div class="icon">
									<i class="bi bi-pencil-square"></i>
								</div>
								<p class="mt-3">작성한 후기가 없습니다.</p>
							</div>
						<% } else { %>
							<% for (Map<String, Object> review : writtenReviews) { %>
								<div class="review-item mb-4 pb-3 border-bottom position-relative" data-review-id="<%= review.get("reviewId") %>" data-review-content="<%= review.get("content") %>">
									<div class="d-flex justify-content-between align-items-center mb-2">
										<h6 class="mb-0 fw-bold"><%= review.get("reviewee") %>에게 남긴 후기</h6>
										<small class="text-muted"><%= review.get("date") %></small>
									</div>
									<small class="d-block text-muted mb-2">상품: <%= review.get("productName") %></small>
									<div class="review-stars mb-2">
										<% int rating = (int) review.get("rating");
											for (int i = 0; i < 5; i++) { %>
											<i class="bi <%= (i < rating) ? "bi-star-fill" : "bi-star" %>"></i>
										<% } %>
									</div>
									<div class="d-flex flex-wrap gap-2 mb-2">
										<% for (String tag : (List<String>) review.get("tags")) { %>
											<span class="badge rounded-pill text-bg-secondary"><%= tag %></span>
										<% } %>
									</div>
									<p class="text-muted"><%= review.get("content") %></p>
									<div class="review-item-buttons">
										<button class="btn btn-outline-secondary btn-sm" onclick="editWrittenReview(this)">수정</button>
									</div>
								</div>
							<% } %>
						<% } %>
					</div>
				</div>
			</div>

			<div id="review-form-view" class="d-none">
				<h5 class="form-title fw-bold">후기 작성</h5>
				<form id="review-form" onsubmit="return false;">
					<input type="hidden" id="form-review-id">
					<div class="mb-3">
						<label for="form-rating" class="form-label">별점</label>
						<div id="form-rating" class="d-flex gap-1 text-warning fs-4">
							<i class="bi bi-star" data-rating="1"></i>
							<i class="bi bi-star" data-rating="2"></i>
							<i class="bi bi-star" data-rating="3"></i>
							<i class="bi bi-star" data-rating="4"></i>
							<i class="bi bi-star" data-rating="5"></i>
						</div>
					</div>
					<div class="mb-3">
						<label for="form-content" class="form-label">후기 내용</label>
						<textarea class="form-control" id="form-content" rows="4" placeholder="자세한 후기를 남겨주세요."></textarea>
					</div>
					<div class="bottom-fixed-btn">
						<button type="submit" class="btn btn-dark w-100 btn-lg" id="form-submit-btn">완료</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<button type="button" class="btn btn-dark rounded-circle"
		id="scrollTopBtn">
		<i class="bi bi-arrow-up"></i>
	</button>

	<script>
	  const offcanvas = document.getElementById('myReviewOffcanvas');
	  const views = {
		list: document.getElementById('review-list-view'),
		form: document.getElementById('review-form-view')
	  };
	  const offcanvasTitle = document.getElementById('offcanvasLabel');
	  const backButton = document.getElementById('back-button');
	  const reviewsBody = document.getElementById('reviewsBody');
	  const scrollTopBtn = document.getElementById('scrollTopBtn');
	
	  // 폼 관련 요소
	  const formTitle = document.querySelector('#review-form-view .form-title');
	  const formReviewId = document.getElementById('form-review-id');
	  const formRatingStars = document.querySelectorAll('#form-rating i');
	  const formContent = document.getElementById('form-content');
	  const formSubmitBtn = document.getElementById('form-submit-btn');

	  let currentRating = 0;

	  function showView(viewName) {
		for (const key in views) { views[key].classList.add('d-none'); }
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

	  // 내가 쓴 후기 수정 함수
	  function editWrittenReview(buttonElement) {
		const reviewItem = buttonElement.closest('.review-item');
		const reviewId = reviewItem.dataset.reviewId;
		const content = reviewItem.querySelector('p.text-muted').textContent;
		const rating = reviewItem.querySelector('.review-stars').querySelectorAll('i.bi-star-fill').length;

		// 폼에 데이터 채우기
		formReviewId.value = reviewId;
		formContent.value = content;
		currentRating = rating;

		// 별점 업데이트
		updateStarRating(currentRating);

		// 폼 제목 및 버튼 텍스트 변경
		formTitle.textContent = '후기 수정';
		formSubmitBtn.textContent = '수정 완료';

		showView('form');
	  }

	  // 별점 클릭 이벤트 핸들러
	  formRatingStars.forEach(star => {
		star.addEventListener('click', (e) => {
			currentRating = parseInt(e.target.dataset.rating);
			updateStarRating(currentRating);
		});
	  });

	  // 별점 시각적 업데이트 함수
	  function updateStarRating(rating) {
		formRatingStars.forEach(star => {
			if (parseInt(star.dataset.rating) <= rating) {
				star.classList.replace('bi-star', 'bi-star-fill');
			} else {
				star.classList.replace('bi-star-fill', 'bi-star');
			}
		});
	  }

	  // 폼 제출 이벤트 처리
	  document.getElementById('review-form').addEventListener('submit', function() {
		const reviewId = formReviewId.value;
		const content = formContent.value;
		
		console.log('후기 ID: ' + reviewId + ' 수정 완료');
		console.log('변경 내용: ' + content);
		console.log('새 별점: ' + currentRating);

		alert('후기 수정이 완료되었습니다.');
		showView('list');
	  });

	  // 오프캔버스 열릴 때
	  offcanvas.addEventListener('shown.bs.offcanvas', () => {
		reviewsBody.addEventListener('scroll', () => {
			scrollTopBtn.style.display = reviewsBody.scrollTop > 100 ? 'block' : 'none';
		});
	  });
	
	  // 오프캔버스 닫힐 때
	  offcanvas.addEventListener('hidden.bs.offcanvas', () => {
		scrollTopBtn.style.display = 'none';
	  });
	
	  // 맨 위로 버튼 클릭 시
	  scrollTopBtn.addEventListener('click', () => {
		reviewsBody.scrollTo({ top: 0, behavior: 'smooth' });
	  });
	</script>
</body>
</html>