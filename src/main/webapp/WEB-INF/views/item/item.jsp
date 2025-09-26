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
		<c:choose>
			<%-- Case 1: 경매가 'OPEN' 상태일 경우 --%>
			<c:when test="${item.status == 'OPEN'}">
				<div class="row product-row">
					<div class="col-lg-6 mb-4 mb-lg-0">
						<div id="productImageCarousel" class="carousel slide"
							data-bs-ride="carousel">
							<div class="carousel-inner">
								<c:forEach var="img" items="${item.imageUrl}" varStatus="status">
									<div class="carousel-item ${status.index == 0 ? 'active' : ''}">
										<img src="${pageContext.request.contextPath}/${img}" class="d-block w-100" alt="상품 이미지">
									</div>
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
										<td>
											<span id="bidCount">총 ...회</span>
											<a href="#" class="ms-2 text-decoration-none"
											   data-bs-toggle="offcanvas"
											   data-bs-target="#bidHistoryOffcanvas"
											   aria-controls="bidHistoryOffcanvas">[기록 보기]</a>
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
									<button class="btn btn-sm btn-outline-secondary" data-increase="1000">+1천원</button>
									<button class="btn btn-sm btn-outline-secondary" data-increase="5000">+5천원</button>
									<button class="btn btn-sm btn-outline-secondary" data-increase="10000">+1만원</button>
									<button class="btn btn-sm btn-outline-secondary" data-increase="50000">+5만원</button>
								</div>

								<div class="d-flex gap-2">
									<button id="likeButton" type="button" class="btn btn-light btn-square">
										<i id="heartIcon" class="bi ${isFavorited ? 'bi-heart-fill' : 'bi-heart'} fs-5"></i>
									</button>
									<button id="bidButton" class="btn btn-bid-primary btn-lg flex-grow-1"
											type="button" data-item-id="${item.id}" data-seller-id="${item.userId}">
										<i class="bi bi-hammer"></i> 입찰하기
									</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:when>

			<%-- Case 2: 경매가 'OPEN'이 아닐 경우 (예: 종료, 취소 등) --%>
			<c:otherwise>
				<div class="row product-row">
					<div class="col-lg-6 mb-4 mb-lg-0">
						<div id="productImageCarousel" class="carousel slide auction-ended"
							data-bs-ride="carousel">
							<div class="carousel-inner">
								<c:forEach var="img" items="${item.imageUrl}" varStatus="status">
									<div class="carousel-item ${status.index == 0 ? 'active' : ''}">
										<img src="${pageContext.request.contextPath}/${img}" class="d-block w-100" alt="상품 이미지">
									</div>
								</c:forEach>
							</div>
						</div>
					</div>

					<div class="col-lg-6">
						<div class="card p-4 d-flex flex-column h-100">
							<h2 class="product-title">${item.title}</h2>
							
							<div class="alert alert-secondary text-center my-4" role="alert">
								<h4 class="alert-heading mb-0"><i class="bi bi-gavel"></i> 경매가 종료된 상품입니다.</h4>
							</div>
							<div id="bidSuccessMessage" class="alert alert-success text-center" role="alert" style="display: none;">
								<h4 class="alert-heading mb-0"><i class="bi bi-check-circle-fill"></i> 입찰 성공!</h4>
							</div>

							<table class="table product-info-table mb-4">
								<tbody>
									<tr>
										<th scope="row">시작가</th>
										<td>${item.startPrice}</td>
									</tr>
									<tr>
										<th scope="row">최종 낙찰가</th>
										<td class="price-final">${item.currentPrice}</td>
									</tr>
								</tbody>
							</table>
							
							<div class="mt-auto">
								<a href="${pageContext.request.contextPath}/review/enroll?itemId=${item.id}&sellerId=${item.userId}" id="reviewButton" class="btn btn-primary btn-lg w-100 mb-2" style="display: none;">
									<i class="bi bi-pencil-square"></i> 리뷰 남기기
								</a>
								<a href="${pageContext.request.contextPath}/main" class="btn btn-dark btn-lg w-100">
									<i class="bi bi-arrow-left-circle"></i> 다른 상품 보러가기
								</a>
							</div>
						</div>
					</div>
				</div>
			</c:otherwise>
		</c:choose>

		<%-- 공통 섹션: 상세 설명 및 판매자 정보 --%>
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
						<form id="chatForm" method="post" action="${pageContext.request.contextPath}/chat/${item.userId}/start">
							<input type="hidden" name="userId" value="${item.userId}">
							<input type="hidden" name="itemId" value="${item.id}">
						</form>
							<a href="${pageContext.request.contextPath}/userinfo/${item.userId}" class="btn btn-dark">
							    <i class="bi bi-person-plus-fill"></i> 판매자 정보
							</a>
							<button id="chatBtn" type="button" class="btn btn-outline-primary">
								<i class="bi bi-chat-text-fill"></i> 판매자와 1:1 채팅
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="groupChat.jsp" />
	<jsp:include page="bid.jsp" />

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>
	 	// 전역 함수로 선언
	 	function formatNumber(number) {
	 		return new Intl.NumberFormat('ko-KR').format(number);
	 	}
	 	
	 	function unformatNumber(string) {
	 		return parseInt(string.replace(/,/g, ''), 10) || 0;
	 	}
	 	
	 	$("#chatBtn").on("click", function() {
	 		$("#chatForm").submit();
	 	});

	 	$(document).ready(function() {
	 		const contextPath = "${pageContext.request.contextPath}";

	 		// --- 1. 남은 시간 카운트다운 스크립트 ---
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

	 		// --- 2. 좋아요 버튼 AJAX 처리 ---
	 		$('#likeButton').on('click', function() {
	 			const itemId = "${item.id}";
	 			const heartIcon = $('#heartIcon');

	 			$.ajax({
	 				type: 'POST',
	 				url: `${pageContext.request.contextPath}/favorite/\${itemId}`,
	 				success: function(response) {
	 					console.log('좋아요 요청 성공:', response);
	 					if (heartIcon.hasClass('bi-heart')) {
	 						heartIcon.removeClass('bi-heart').addClass('bi-heart-fill');
	 					} else {
	 						heartIcon.removeClass('bi-heart-fill').addClass('bi-heart');
	 					}
	 				},
	 				error: function(xhr, status, error) {
	 					console.error('좋아요 요청 실패:', error);
	 					alert('요청 처리 중 오류가 발생했습니다. 로그인 상태를 확인해주세요.');
	 				}
	 			});
	 		});

	 		// --- 3. 입찰가 관련 스크립트 ---
	 		const currentPriceText = $('.price-current').text();
	 		const currentPrice = unformatNumber(currentPriceText);
	 		const bidInput = $('#bidInput');
	 		
	 		if (bidInput.length > 0) {
				const nextBidPrice = currentPrice;
	
		 		bidInput.val(formatNumber(nextBidPrice));
		 		bidInput.on('input', function() {
		 			const numericValue = unformatNumber(this.value);
		 			this.value = !isNaN(numericValue) ? formatNumber(numericValue) : '';
		 		});
		 		$('[data-increase]').on('click', function() {
		 			let currentValue = unformatNumber(bidInput.val());
		 			let increment = parseInt($(this).data('increase'), 10);
		 			bidInput.val(formatNumber(currentValue + increment));
		 		});
		 		bidInput.on('blur', function() {
		 			let value = unformatNumber(this.value);
		 			if (isNaN(value) || value < nextBidPrice) {
		 				bidInput.val(formatNumber(nextBidPrice));
		 			}
		 		});
	 		}
	 		
	 		// --- 4. 입찰 버튼 AJAX 처리 ---
	 		$('#bidButton').on('click', function() {
			    const itemId = $(this).data('item-id');
			    const sellerId = $(this).data('seller-id');
			    const bidPrice = unformatNumber(bidInput.val());
			    const currentPriceForValidation = unformatNumber($('.price-current').text());
			
			    // 입찰 조건 검사
			    if (isNaN(bidPrice) || bidPrice <= currentPriceForValidation) {
			        alert('입찰 금액은 현재가보다 높아야 합니다.');
			        return;
			    }
			
			    // --- 입찰 확인 알림창 ---
			    const formattedBidPrice = formatNumber(bidPrice);
			    if (confirm(formattedBidPrice + '원에 입찰하시겠습니까?')) {
			    	const url = `${pageContext.request.contextPath}/item/bid_check?price=\${bidPrice}&itemId=\${itemId}&sellerId=\${sellerId}`;
			        $.ajax({
			            type: 'POST',
			            url: url,
			            success: function(response) {
					        window.open(
					                `${pageContext.request.contextPath}/payment/bid?price=\${bidPrice}&itemId=\${itemId}&sellerId=\${sellerId}`, // 열고 싶은 URL
					                '_blank',  // 새 탭/창으로 열기
					                'width=500,height=700,scrollbars=yes,resizable=yes' // 옵션: 크기, 스크롤, 크기 조절 가능
					            );     
			            },
			            error: function(xhr, status, error) {
			                console.error('입찰 요청 실패:', xhr.responseText);
			                
			                if (xhr.status === 403) {
			                    alert('자신의 상품은 입찰할 수 없습니다.');
			                } else {
			                    alert('로그인이 되어있을 때만 입찰할 수 있습니다.');
			                    window.location.href = '${pageContext.request.contextPath}/login';
			                }
			            }
			        });
			    }
			
			});

			// --- 5. 리뷰 작성 권한 확인 로직 ---
			if ($('.auction-ended').length > 0) {
				const itemId = "${item.id}";
				const sellerId = "${item.userId}";

				$.ajax({
					type: 'GET',
					url: `${pageContext.request.contextPath}/review/auth`,
					data: {
						itemId: itemId,
						sellerId: sellerId
					},
					success: function(hasAuth) {
						if (hasAuth === true) {
							$('#bidSuccessMessage').show();
							$('#reviewButton').show();
						}
					},
					error: function(xhr, status, error) {
						console.error('리뷰 권한을 확인하는 중 오류가 발생했습니다:', error);
					}
				});
			}

			// --- 6. 리뷰 남기기 버튼 클릭 시 중복 확인 ---
			$('#reviewButton').on('click', function(e) {
				e.preventDefault();
				
				const reviewPageUrl = $(this).attr('href');
				const itemId = "${item.id}";

				$.ajax({
					type: 'GET',
					url: `${pageContext.request.contextPath}/review/check`,
					data: {
						itemId: itemId
					},
					success: function(canWriteReview) {
						if (canWriteReview) {
							window.location.href = reviewPageUrl;
						} else {
							alert('이미 리뷰를 작성하셨습니다.');
						}
					},
					error: function() {
						alert('리뷰 중복 확인 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
					}
				});
			});

			if ($('#bidCount').length > 0) {
				$.ajax({
					type: 'GET',
					url: `${pageContext.request.contextPath}/bid/count/${item.id}`,
					success: function(count) {
						$('#bidCount').text(`총 \${count}회`);
					},
					error: function() {
						console.error('입찰 횟수를 가져오는 데 실패했습니다.');
						$('#bidCount').text('총 ?회');
					}
				});
			}
	 	});
	</script>
</body>
</html>