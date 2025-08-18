<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중고 상품 경매 페이지</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<!-- 전역/페이지 전용 CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/item.css">
</head>
<body>
  <jsp:include page="header.jsp" />

  <div class="container mt-5 mb-5">
    <div class="row">
      <div class="col-md-6">
        <div id="productImageCarousel" class="carousel slide" data-bs-ride="carousel">
          <div class="carousel-inner">
            <div class="carousel-item active">
              <img src="http://gd3.alicdn.com/imgextra/i3/54410696/TB2vkTrbrMlyKJjSZFlXXbMoFXa_!!54410696.jpg_640x640.jpg?Text=Image+1" class="d-block w-100 rounded" alt="상품 이미지 1">
            </div>
            <div class="carousel-item">
              <img src="http://bitcdn.bit-play.com/fromchina/2018/05/18/18/e2c406415599c6eb327e3699c071ac15_457482_450.jpg?Text=Image+2" class="d-block w-100 rounded" alt="상품 이미지 2">
            </div>
          </div>
          <button class="carousel-control-prev" type="button" data-bs-target="#productImageCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
          </button>
          <button class="carousel-control-next" type="button" data-bs-target="#productImageCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
          </button>
        </div>
      </div>

      <div class="col-md-6">
        <h2>고급스러운 빈티지 기계식 키보드</h2>
        <hr>

        <table class="table table-bordered product-info-table">
          <tbody>
            <tr>
              <th scope="row" class="bg-light w-25">시작가</th>
              <td>50,000원</td>
            </tr>
            <tr>
              <th scope="row" class="bg-light">현재가</th>
              <td class="price-current">75,000원</td>
            </tr>
            <tr>
              <th scope="row" class="bg-light">남은 시간</th>
              <td class="time-left">
                <i class="bi bi-clock"></i> 2일 15시간 30분
              </td>
            </tr>
            <tr>
              <th scope="row" class="bg-light">입찰 기록</th>
              <td>
                총 8회
                <a href="#" class="ms-2">[기록 보기]</a>
              </td>
            </tr>
          </tbody>
        </table>

        <div class="d-grid gap-2 mb-3">
          <button class="btn btn-outline-dark" type="button" data-bs-toggle="offcanvas" data-bs-target="#chatOffcanvas" aria-controls="chatOffcanvas">
            <i class="bi bi-chat-dots"></i> 물품 채팅방 (단체)
          </button>
        </div>

        <div class="input-group mb-3">
  			<span class="input-group-text">희망입찰가</span>
 			<input type="number" class="form-control" id="bidInput" step="1000" min="75000" value="75000">
  			<span class="input-group-text">원</span>
		</div>

		<div class="d-flex gap-2 mb-3 flex-wrap">
  			<button class="btn btn-outline-secondary" data-increase="1000">+1,000원</button>
  			<button class="btn btn-outline-secondary" data-increase="10000">+10,000원</button>
  			<button class="btn btn-outline-secondary" data-increase="100000">+100,000원</button>
  			<button class="btn btn-outline-secondary" data-increase="1000000">+1,000,000원</button>
		</div>


        <div class="d-flex gap-2">
          <button id="likeButton" type="button" class="btn btn-outline-basic">
            <i id="heartIcon" class="bi bi-heart"></i>
          </button>
          <button class="btn btn-dark btn-lg flex-grow-1" type="button">
            <i class="bi bi-hammer"></i> 입찰하기
          </button>
        </div>
      </div>
    </div>

    <hr class="my-5">

    <div class="row">
      <div class="col-12">
        <h3>상세 설명</h3>
        <div class="p-3 border bg-light rounded mb-4">
          <p>20세기 초반의 타자기 감성을 그대로 재현한 빈티지 기계식 키보드입니다.</p>
          <p>실사용 횟수 적어 상태 매우 깨끗하며, 모든 키 정상적으로 작동합니다.</p>
          <p>묵직한 타건감과 레트로한 디자인으로 인테리어 소품으로도 활용 가치가 높습니다.</p>
        </div>

        <div class="seller-info d-flex justify-content-between align-items-center">
          <div>
            <span class="fw-bold fs-5">레트로마스터</span>
            <span class="ms-2 rating">
              <i class="bi bi-star-fill"></i>
              <i class="bi bi-star-fill"></i>
              <i class="bi bi-star-fill"></i>
              <i class="bi bi-star-fill"></i>
              <i class="bi bi-star-half"></i>
              (4.5)
            </span>
          </div>
          <button type="button" class="btn btn-dark">
            <i class="bi bi-chat-text-fill"></i> 판매자와 채팅하기
          </button>
        </div>
      </div>
    </div>
  </div>

  <jsp:include page="groupChat.jsp"/>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    // 좋아요 토글
    const likeButton = document.getElementById('likeButton');
    const heartIcon = document.getElementById('heartIcon');
    likeButton.addEventListener("click", function() {
      const isNotLiked = heartIcon.classList.contains('bi-heart');
      if (isNotLiked) {
        heartIcon.classList.remove('bi-heart');
        heartIcon.classList.add('bi-heart-fill');
      } else {
        heartIcon.classList.remove('bi-heart-fill');
        heartIcon.classList.add('bi-heart');
      }
    });
    // 가격 수정
    const currentPriceText = document.querySelector('.price-current').innerText;
    const currentPrice = parseInt(currentPriceText.replace(/[^\d]/g, ''), 10);

    const bidInput = document.getElementById('bidInput');
    bidInput.value = currentPrice;

    // 버튼들에 이벤트 연결
    document.querySelectorAll('[data-increase]').forEach(button => {
      button.addEventListener('click', () => {
        let value = parseInt(bidInput.value, 10) || currentPrice;
        let increment = parseInt(button.getAttribute('data-increase'), 10);
        bidInput.value = value + increment;
      });
    });

    // 입력값이 현재가보다 낮으면 자동 보정
    bidInput.addEventListener('blur', () => {
      let value = parseInt(bidInput.value, 10);
      if (isNaN(value) || value < currentPrice) {
        bidInput.value = currentPrice;
      }
    });

  </script>
</body>
</html>
