<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel="icon" type="image/png"
	href="${pageContext.request.contextPath}/resources/images/watermelon_icon.ico">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/mypage.css">

</head>
<body>
	<jsp:include page="../component/header.jsp" />

	<div class="container py-5">
		<div class="row">
			<aside class="col-md-3">
				<h4 class="mb-4 ps-2">마이페이지</h4>
				<div class="sidebar">
					<div class="nav flex-column nav-pills">
						<span class="text-muted ps-2 mb-2 fw-bold">거래 정보</span> <a
							class="nav-link" href="#" data-bs-toggle="offcanvas"
							data-bs-target="#mySalesOffcanvas"
							aria-controls="mySalesOffcanvas"><i class="bi bi-receipt"></i>판매내역</a>
						<a class="nav-link" href="#" data-bs-toggle="offcanvas"
							data-bs-target="#myPurchasesOffcanvas"
							aria-controls="myPurchasesOffcanvas"><i class="bi bi-bag"></i>구매내역</a>
						<a class="nav-link" href="#" data-bs-toggle="offcanvas"
							data-bs-target="#myInterestsOffcanvas"
							aria-controls="myInterestsOffcanvas"><i class="bi bi-heart"></i>찜한
							상품</a>
						<hr>
						<span class="text-muted ps-2 mb-2 fw-bold">내 정보</span> <a
							class="nav-link" href="#" data-bs-toggle="offcanvas"
							data-bs-target="#myInfoOffcanvas" aria-controls="myInfoOffcanvas"><i
							class="bi bi-person-gear"></i>개인정보 수정</a> <a class="nav-link"
							href="#" data-bs-toggle="offcanvas"
							data-bs-target="#myAddressOffcanvas"
							aria-controls="myAddressOffcanvas"><i class="bi bi-geo-alt"></i>배송지
							관리</a> <a class="nav-link" href="#" data-bs-toggle="offcanvas"
							data-bs-target="#myReviewOffcanvas"
							aria-controls="myReviewOffcanvas"><i class="bi bi-star"></i>거래
							후기</a> <a class="nav-link text-danger" href="#"
							data-bs-toggle="offcanvas" data-bs-target="#withdrawOffcanvas"
							aria-controls="withdrawOffcanvas"><i
							class="bi bi-box-arrow-right"></i>탈퇴하기</a>
					</div>
				</div>
			</aside>

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
							<i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i> <i
								class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i> <i
								class="bi bi-star-half"></i>
						</div>
						<span class="fs-4 fw-bold">4.5</span> <span
							class="text-muted ms-2">/ 5.0</span>
					</div>
				</div>
			</div>

			<div class="card">
				<div class="card-body p-4">
					<h4 class="mb-4">내 상품</h4>

					<ul class="nav nav-pills product-tabs mb-4" id="pills-tab"
						role="tablist">
						<li class="nav-item" role="presentation">
							<button class="nav-link active" id="pills-all-tab"
								data-bs-toggle="pill" data-bs-target="#pills-all" type="button"
								role="tab" aria-controls="pills-all" aria-selected="true">전체</button>
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
								aria-selected="false">예약중</button>
						</li>
					</ul>

					<div class="tab-content" id="pills-tabContent">
						<div class="tab-pane fade show active" id="pills-all"
							role="tabpanel" aria-labelledby="pills-all-tab" tabindex="0">
							<div
								class="d-flex flex-column align-items-center justify-content-center py-5">
								<h5 class="mb-3">전체 상품 목록이 표시될 공간입니다.</h5>
								<img src="${pageContext.request.contextPath}/resources/images/404.png"
									class="img-fluid" style="max-width: 200px;">
							</div>
						</div>

						<div class="tab-pane fade" id="pills-selling" role="tabpanel"
							aria-labelledby="pills-selling-tab" tabindex="0">
							<div
								class="d-flex flex-column align-items-center justify-content-center py-5">
								<h5 class="mb-3">판매중인 상품이 없습니다.</h5>
								<img src="${pageContext.request.contextPath}/resources/images/404.png"
									class="img-fluid" style="max-width: 200px;">
							</div>
						</div>

						<div class="tab-pane fade" id="pills-reserved" role="tabpanel"
							aria-labelledby="pills-reserved-tab" tabindex="0">
							<div
								class="d-flex flex-column align-items-center justify-content-center py-5">
								<h5 class="mb-3">예약중인 상품이 없습니다.</h5>
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
	
	<div class="modal fade" id="reviewModal" tabindex="-1" aria-labelledby="reviewModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="reviewModalLabel">후기 작성</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form id="reviewForm">
						<p>
							<strong>상품명:</strong> <span id="productName"></span>
						</p>
						<div class="mb-3">
							<label class="form-label">별점</label>
							<div class="rating-stars-input d-flex gap-1" id="ratingStars">
								<i class="bi bi-star" data-rating="1"></i> <i class="bi bi-star" data-rating="2"></i> <i class="bi bi-star" data-rating="3"></i> <i class="bi bi-star" data-rating="4"></i> <i class="bi bi-star" data-rating="5"></i>
							</div>
							<input type="hidden" id="ratingInput" name="rating">
						</div>
						<div class="mb-3">
							<label class="form-label">후기 태그</label>
							<div id="reviewTags" class="d-flex flex-wrap gap-2">
								<input type="checkbox" class="btn-check" id="tag-same" name="tags" value="same" autocomplete="off"> <label class="btn btn-outline-secondary btn-sm" for="tag-same">#사진과 실물이 동일</label> <input type="checkbox" class="btn-check" id="tag-detail" name="tags" value="detail" autocomplete="off"> <label class="btn btn-outline-secondary btn-sm" for="tag-detail">#상세설명 정확</label> <input type="checkbox" class="btn-check" id="tag-good-state" name="tags" value="good-state" autocomplete="off"> <label class="btn btn-outline-secondary btn-sm" for="tag-good-state">#상품 상태 좋음</label> <input type="checkbox" class="btn-check" id="tag-quick-deal" name="tags" value="quick-deal" autocomplete="off"> <label class="btn btn-outline-secondary btn-sm" for="tag-quick-deal">#신속한 거래</label> <input type="checkbox" class="btn-check" id="tag-quick-reply" name="tags" value="quick-reply" autocomplete="off"> <label class="btn btn-outline-secondary btn-sm" for="tag-quick-reply">#빠른
									응대</label> <input type="checkbox" class="btn-check" id="tag-smooth-comm" name="tags" value="smooth-comm" autocomplete="off"> <label class="btn btn-outline-secondary btn-sm" for="tag-smooth-comm">#원활한 소통</label> <input type="checkbox" class="btn-check" id="tag-careful-pack" name="tags" value="careful-pack" autocomplete="off"> <label class="btn btn-outline-secondary btn-sm" for="tag-careful-pack">#꼼꼼한 포장</label> <input type="checkbox" class="btn-check" id="tag-on-time" name="tags" value="on-time" autocomplete="off"> <label class="btn btn-outline-secondary btn-sm" for="tag-on-time">#약속 준수</label> <input type="checkbox" class="btn-check" id="tag-again" name="tags" value="again" autocomplete="off"> <label class="btn btn-outline-secondary btn-sm" for="tag-again">#또 입찰하고 싶어요</label>
							</div>
						</div>
						<div class="mb-3">
							<label for="reviewTextarea" class="form-label">후기 내용</label>
							<textarea class="form-control" id="reviewTextarea" rows="4" required></textarea>
						</div>
						<input type="hidden" id="productIdInput" name="productId">
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
					<button type="submit" class="btn btn-success" id="submitReviewBtn">등록</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="viewReviewModal" tabindex="-1" aria-labelledby="viewReviewModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="viewReviewModalLabel">상품 후기</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p>
						<strong>상품명:</strong> <span id="reviewProductName"></span>
					</p>
					<div class="mb-3">
						<label class="form-label">평점</label>
						<div id="reviewRatingStars" class="d-flex gap-1"></div>
					</div>
					<div class="mb-3">
						<label class="form-label">선택된 태그</label>
						<div id="reviewTagsDisplay" class="d-flex flex-wrap gap-2"></div>
					</div>
					<div class="mb-3">
						<label class="form-label">후기 내용</label>
						<p id="reviewTextContent" class="p-3 border rounded bg-light"></p>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-success" id="editReviewBtn">수정</button>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="mySales.jsp" />
	<jsp:include page="myPurchases.jsp" />
	<jsp:include page="myInterests.jsp" />
	<jsp:include page="myAddress.jsp" />
	<jsp:include page="myReview.jsp" />
	<jsp:include page="withdraw.jsp" />
	<jsp:include page="myInfo.jsp" />
	
	<script>
    document.addEventListener('DOMContentLoaded', function() {
        // 후기 태그와 매핑된 한글 이름
        const tagMap = {
            'same': '사진과 실물이 동일',
            'detail': '상세설명 정확',
            'good-state': '상품 상태 좋음',
            'quick-deal': '신속한 거래',
            'quick-reply': '빠른 응대',
            'smooth-comm': '원활한 소통',
            'careful-pack': '꼼꼼한 포장',
            'on-time': '약속 준수',
            'again': '또 입찰하고 싶어요'
        };
        
        // 후기 작성 모달 관련 JavaScript
        const reviewModal = document.getElementById('reviewModal');
        const ratingStars = document.getElementById('ratingStars');
        const submitReviewBtn = document.getElementById('submitReviewBtn');
        let selectedRating = 0;

        reviewModal.addEventListener('show.bs.modal', function(event) {
            const button = event.relatedTarget;
            // 버튼을 클릭해서 모달이 열린 경우(신규 작성)에만 아래 로직 실행
            if (button) { 
                const productId = button.getAttribute('data-product-id');
                const productName = button.getAttribute('data-product-name');
                
                document.getElementById('productName').textContent = productName;
                document.getElementById('productIdInput').value = productId;
                
                // 폼 초기화
                selectedRating = 0;
                updateStars();
                document.getElementById('reviewTextarea').value = '';
                document.querySelectorAll('#reviewTags .btn-check').forEach(checkbox => checkbox.checked = false);
            }
        });

        ratingStars.addEventListener('click', function(event) {
            const target = event.target;
            if (target.tagName === 'I') {
                selectedRating = target.getAttribute('data-rating');
                updateStars();
            }
        });

        function updateStars() {
            const stars = ratingStars.querySelectorAll('i');
            stars.forEach(star => {
                if (star.getAttribute('data-rating') <= selectedRating) {
                    star.classList.replace('bi-star', 'bi-star-fill');
                } else {
                    star.classList.replace('bi-star-fill', 'bi-star');
                }
            });
            document.getElementById('ratingInput').value = selectedRating;
        }

        submitReviewBtn.addEventListener('click', function() {
            const productId = document.getElementById('productIdInput').value;
            const rating = document.getElementById('ratingInput').value;
            const reviewText = document.getElementById('reviewTextarea').value;
            const selectedTags = Array.from(document.querySelectorAll('#reviewTags .btn-check:checked')).map(tag => tag.value);

            if (rating === "0" || reviewText.trim() === "") {
                alert("별점과 후기 내용을 모두 입력해주세요.");
                return;
            }

            console.log(`상품 ID: ${productId}, 별점: ${rating}, 태그: ${selectedTags.join(', ')}, 후기: "${reviewText}"`);
            
            alert("후기가 성공적으로 등록되었습니다!");
            
            const reviewModalInstance = bootstrap.Modal.getInstance(reviewModal);
            reviewModalInstance.hide();
        });

        // 후기 보기 모달 관련 JavaScript
        const viewReviewModal = document.getElementById('viewReviewModal');
        const editReviewBtn = document.getElementById('editReviewBtn');
        
        let currentProductIdForEdit = null;

        viewReviewModal.addEventListener('show.bs.modal', function(event) {
            const button = event.relatedTarget;
            const productName = button.getAttribute('data-product-name');
            const productTags = button.getAttribute('data-product-tags') ? button.getAttribute('data-product-tags').split(',') : [];
            
            currentProductIdForEdit = button.getAttribute('data-product-id');

            // 예시 데이터 (서버에서 실제 데이터 가져오는 로직 필요)
            const reviewData = {
                rating: 4,
                reviewText: "거래가 매우 원활했고, 상품도 설명과 같아서 만족스러웠습니다. 좋은 거래 감사합니다!",
                tags: productTags.length > 0 ? productTags : ['same', 'quick-deal'] // 예시 태그 추가
            };

            document.getElementById('reviewProductName').textContent = productName;
            document.getElementById('reviewTextContent').textContent = reviewData.reviewText;

            const ratingContainer = document.getElementById('reviewRatingStars');
            ratingContainer.innerHTML = '';
            for (let i = 1; i <= 5; i++) {
                const iconClass = (i <= reviewData.rating) ? 'bi bi-star-fill' : 'bi bi-star';
                const icon = document.createElement('i');
                icon.className = iconClass;
                icon.style.color = (i <= reviewData.rating) ? 'gold' : '#ccc';
                ratingContainer.appendChild(icon);
            }
            
            const tagsDisplayContainer = document.getElementById('reviewTagsDisplay');
            tagsDisplayContainer.innerHTML = '';
            if (reviewData.tags.length > 0) {
                reviewData.tags.forEach(tagId => {
                    const tagLabel = tagMap[tagId.trim()] || tagId.trim();
                    const tagBadge = document.createElement('span');
                    tagBadge.className = 'badge rounded-pill text-bg-secondary';
                    tagBadge.textContent = tagLabel;
                    tagsDisplayContainer.appendChild(tagBadge);
                });
            } else {
                tagsDisplayContainer.innerHTML = '<span class="text-muted">선택된 태그가 없습니다.</span>';
            }

            const isFromMyPurchases = button.closest('#myPurchasesOffcanvas');
            if (editReviewBtn) {
                if (isFromMyPurchases) {
                    editReviewBtn.style.display = 'inline-block';
                    
                    editReviewBtn.onclick = function() {
                        const viewReviewModalInstance = bootstrap.Modal.getInstance(viewReviewModal);
                        viewReviewModalInstance.hide();
                        
                        // 'reviewModal'을 열기 전, 수정에 필요한 데이터를 직접 설정
                        document.getElementById('productName').textContent = productName;
                        document.getElementById('productIdInput').value = currentProductIdForEdit;
                        document.getElementById('reviewTextarea').value = reviewData.reviewText;
                        
                        selectedRating = reviewData.rating;
                        updateStars();
                        
                        document.querySelectorAll('#reviewTags .btn-check').forEach(checkbox => {
                            checkbox.checked = reviewData.tags.includes(checkbox.value);
                        });
                        
                        // 데이터 설정이 끝난 후 'reviewModal' 열기
                        const reviewModalInstance = new bootstrap.Modal(reviewModal);
                        reviewModalInstance.show();
                        
                        console.log("수정 모드로 전환 완료");
                    };
                } else {
                    editReviewBtn.style.display = 'none';
                }
            }
        });
    });
    </script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
