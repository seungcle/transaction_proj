<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중고 상품 경매 페이지</title>
<link rel="icon" type="image/png" href="../images/watermelon_icon.ico">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/global.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/item.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<jsp:include page="../component/header.jsp" />

	<div class="container mt-5 mb-5">
		<div class="row product-row">
			<div class="col-lg-6 mb-4 mb-lg-0">
				<div id="productImageCarousel" class="carousel slide"
					data-bs-ride="carousel">
					<div class="carousel-inner">
						<c:forEach var="img" items="${item.imageUrl}" varStatus="status">
							<c:choose>
								<c:when test="${status.index == 0}">
									<div class="carousel-item active">
										<img src="${pageContext.request.contextPath}/${img}" class="d-block w-100" alt="상품 이미지 ">
									</div>
								</c:when>
								<c:otherwise>
									<div class="carousel-item">
										<img src="${pageContext.request.contextPath}/${img}" class="d-block w-100" alt="상품 이미지 ">
									</div>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</div>
					<button class="carousel-control-prev" type="button"
						data-bs-target="#productImageCarousel" data-bs-slide="prev">
						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Previous</span>
					</button>
					<button class="carousel-control-next" type="button"
						data-bs-target="#productImageCarousel" data-bs-slide="next">
						<span class="carousel-control-next-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Next</span>
					</button>
				</div>
			</div>

			<div class="col-lg-6">
				<div class="card p-4 d-flex flex-column">
					<h2 class="product-title">${item.title}</h2>

					<table class="table product-info-table mb-4">
						<tbody>
							<tr>
								<th scope="row">시작가</th>
								<td>${item.startPrice}</td>
							</tr>
							<tr>
								<th scope="row">현재가</th>
								<td class="price-current">${item.currentPrice}</td>
							</tr>
							<tr>
								<th scope="row">남은 시간</th>
								<td class="time-left">
									<i class="bi bi-clock-history"></i>
									<span id="countdown-timer" data-remaining-seconds="${item.remainingTimeInSeconds}"></span>
								</td>
							</tr>
							<tr>
								<th scope="row">입찰 기록</th>
								<td>총 8회 <a href="#" class="ms-2 text-decoration-none">[기록
										보기]</a>
								</td>
							</tr>
						</tbody>
					</table>
					
					<div class="d-grid gap-2 mb-4">
						<button class="btn btn-outline-dark" type="button"
							data-bs-toggle="offcanvas" data-bs-target="#chatOffcanvas"
							aria-controls="chatOffcanvas">
							<i class="bi bi-chat-dots"></i> 물품 채팅방 (단체)
						</button>
					</div>

					<div class="mt-auto">
						<div class="input-group mb-3">
							<span class="input-group-text">희망입찰가</span>
							<input type="text" class="form-control form-control-lg text-end"
								id="bidInput" inputmode="numeric"> <span
								class="input-group-text">원</span>
						</div>

						<div class="d-flex gap-2 mb-4 flex-wrap">
							<button class="btn btn-sm btn-outline-secondary"
								data-increase="1000">+1천원</button>
							<button class="btn btn-sm btn-outline-secondary"
								data-increase="5000">+5천원</button>
							<button class="btn btn-sm btn-outline-secondary"
								data-increase="10000">+1만원</button>
							<button class="btn btn-sm btn-outline-secondary"
								data-increase="50000">+5만원</button>
						</div>

						<div class="d-flex gap-2">
							<button id="likeButton" type="button" class="btn btn-light" data-item-id="${item.id}">
								<i id="heartIcon" class="bi bi-heart fs-5"></i>
							</button>
							<button class="btn btn-bid-primary btn-lg flex-grow-1"
								type="button">
								<i class="bi bi-hammer"></i> 입찰하기
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="row mt-5">
			<div class="col-12">
				<div class="card details-card">
					<h3>상세 설명</h3>
					<hr class="my-3">
					<div class="p-3">
						${item.text}
					</div>
					<hr class="my-3">
					<div
						class="seller-info d-flex justify-content-between align-items-center flex-wrap gap-3 p-3">
						<div>
							<span class="fw-bold fs-5">${item.sellerNickname}</span> <span
								class="ms-2 rating"> <i class="bi bi-star-fill"></i> <i
								class="bi bi-star-fill"></i> <i class="bi bi-star-fill"></i> <i
								class="bi bi-star-fill"></i> <i class="bi bi-star-half"></i> <span
								class="text-dark">(4.5)</span>
							</span>
						</div>
						<div class="d-grid gap-2 d-md-block">
							<button type="button" class="btn btn-dark">
								<i class="bi bi-person-plus-fill"></i> 판매자 정보
							</button>
							<button type="button" class="btn btn-outline-primary">
								<i class="bi bi-chat-text-fill"></i> 판매자와 1:1 채팅
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="groupChat.jsp" />

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>
    // [추가] 페이지가 로드되면 즉시 실행되도록 이벤트 리스너 추가
    $(document).ready(function() {
    // JSP의 contextPath를 JavaScript 변수로 저장하여 AJAX URL에 사용합니다.
    const contextPath = "${pageContext.request.contextPath}";

    // --- 1. 남은 시간 카운트다운 스크립트 (기존과 동일) ---
    const timerElement = document.getElementById('countdown-timer');
    if (timerElement) {
        let remainingSeconds = parseInt(timerElement.getAttribute('data-remaining-seconds'), 10) || 0;
        
        function formatTime(seconds) {
            if (seconds <= 0) return "00:00:00";
            const h = Math.floor(seconds / 3600);
            const m = Math.floor((seconds % 3600) / 60);
            const s = seconds % 60;
            return [h, m, s].map(v => String(v).padStart(2, '0')).join(':');
        }
        
        timerElement.textContent = formatTime(remainingSeconds);
        const timerInterval = setInterval(() => {
            remainingSeconds--;
            timerElement.textContent = formatTime(remainingSeconds);
            if (remainingSeconds <= 0) {
                clearInterval(timerInterval);
                timerElement.textContent = "경매 종료";
            }
        }, 1000);
    }

    // --- 2. 좋아요 버튼 AJAX 처리 (jQuery로 변경) ---
    $('#likeButton').on('click', function() {
        // 버튼에 저장해둔 item id를 가져옵니다.
        const itemId = $(this).data('item-id');
        const heartIcon = $('#heartIcon');

        $.ajax({
            type: 'POST',
            url: "${pageContext.request.contextPath}/favorite/${itemId}",
            
            success: function(response) {
                // 서버 요청이 성공했을 때 실행됩니다.
                console.log('요청 성공:', response);
                
                // 아이콘의 클래스를 변경하여 상태를 시각적으로 업데이트합니다.
                if (heartIcon.hasClass('bi-heart')) {
                    heartIcon.removeClass('bi-heart').addClass('bi-heart-fill');
                } else {
                    heartIcon.removeClass('bi-heart-fill').addClass('bi-heart');
                }
                
                // (선택) 서버로부터 받은 좋아요 총 개수를 화면에 업데이트 할 수 있습니다.
                // 예: $('#favorite-count').text(response.favoriteCount);
            },
            error: function(xhr, status, error) {
                // 서버 요청이 실패했을 때 실행됩니다.
                console.error('요청 실패:', error);
                alert('요청 처리 중 오류가 발생했습니다. 로그인 상태를 확인해주세요.');
            }
        });
    });

    // --- 3. 입찰가 관련 스크립트 (기존과 동일) ---
    const currentPriceText = document.querySelector('.price-current').innerText;
    const currentPrice = parseInt(currentPriceText.replace(/[^\d]/g, ''), 10);
    const bidInput = document.getElementById('bidInput');
    const nextBidPrice = currentPrice + 1000;

    function formatNumber(number) {
        return new Intl.NumberFormat('ko-KR').format(number);
    }
    function unformatNumber(string) {
        return parseInt(string.replace(/,/g, ''), 10) || 0;
    }

    bidInput.value = formatNumber(nextBidPrice);
    bidInput.addEventListener('input', (e) => {
        const numericValue = unformatNumber(e.target.value);
        bidInput.value = !isNaN(numericValue) ? formatNumber(numericValue) : '';
    });
    document.querySelectorAll('[data-increase]').forEach(button => {
        button.addEventListener('click', () => {
            let currentValue = unformatNumber(bidInput.value);
            let increment = parseInt(button.getAttribute('data-increase'), 10);
            bidInput.value = formatNumber(currentValue + increment);
        });
    });
    bidInput.addEventListener('blur', () => {
        let value = unformatNumber(bidInput.value);
        if (isNaN(value) || value < nextBidPrice) {
            bidInput.value = formatNumber(nextBidPrice);
        }
    });
});
  </script>
</body>
</html>
