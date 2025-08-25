<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중고 상품 경매 페이지</title>
<link rel="icon" type="image/png" href="../images/watermelon_icon.ico">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/css/item.css"> --%>

<%-- 개선된 디자인을 위한 스타일 추가 --%>
<style>
  body {
    background-color: #f8f9fa; /* 부드러운 배경색 */
  }
  .card {
    border: none;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
    transition: all 0.3s ease;
  }
  .card:hover {
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.12);
  }
  .product-title {
    font-weight: 700;
    font-size: 2.25rem;
    margin-bottom: 1.5rem;
  }
  .product-info-table th {
    font-weight: 600;
    width: 120px;
    border-top: none;
    color: #6c757d;
  }
  .product-info-table td {
    border-top: none;
    font-weight: 500;
  }
  .price-current {
    font-size: 2rem;
    font-weight: 700;
    color: #FF6B6B; /* 헤더와 어울리는 강조색 */
  }
  .time-left {
    font-size: 1.25rem;
    font-weight: 600;
    color: #343a40;
  }
  .btn-bid-primary {
    background: linear-gradient(45deg, #FF8E53, #FF6B6B);
    border: none;
    color: white;
    font-weight: bold;
    padding: 0.75rem 1.5rem;
    box-shadow: 0 4px 10px rgba(255, 107, 107, 0.4);
    transition: all 0.3s ease;
  }
  .btn-bid-primary:hover {
    transform: translateY(-3px);
    box-shadow: 0 6px 15px rgba(255, 107, 107, 0.5);
    color: white;
  }
  #likeButton {
    padding: 0.75rem;
    border: 1px solid #ced4da;
    transition: all 0.2s ease;
  }
  #likeButton:hover {
    background-color: #f1f3f5;
  }
  #heartIcon.bi-heart-fill {
    color: #e54747;
  }
  .details-card {
    padding: 2rem;
    background-color: #fff;
    border-radius: 0.5rem;
    margin-top: 2rem;
  }
  .seller-info .rating {
    color: #ffc107; /* 별점 색상 */
  }
  .carousel-inner img {
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
  }
  
  /* 3. 이미지와 정보 카드 높이 맞춤 */
  @media (min-width: 992px) {
    .product-row {
      align-items: stretch;
    }
    .product-row .col-lg-6 {
      display: flex;
      flex-direction: column;
    }
    .product-row .col-lg-6 .card,
    .product-row .col-lg-6 .carousel {
      flex-grow: 1;
    }
    .carousel, .carousel-inner, .carousel-item {
      height: 100%;
    }
    .carousel-item img {
      height: 100%;
      object-fit: cover;
    }
  }
</style>
</head>
<body>
  <jsp:include page="header.jsp" />

  <div class="container mt-5 mb-5">
    <div class="row product-row">
      <div class="col-lg-6 mb-4 mb-lg-0">
        <div id="productImageCarousel" class="carousel slide" data-bs-ride="carousel">
          <div class="carousel-inner">
            <div class="carousel-item active">
              <img src="http://gd3.alicdn.com/imgextra/i3/54410696/TB2vkTrbrMlyKJjSZFlXXbMoFXa_!!54410696.jpg_640x640.jpg?Text=Image+1" class="d-block w-100" alt="상품 이미지 1">
            </div>
            <div class="carousel-item">
              <img src="http://bitcdn.bit-play.com/fromchina/2018/05/18/18/e2c406415599c6eb327e3699c071ac15_457482_450.jpg?Text=Image+2" class="d-block w-100" alt="상품 이미지 2">
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

      <div class="col-lg-6">
        <div class="card p-4 d-flex flex-column">
          <h2 class="product-title">고급스러운 빈티지 기계식 키보드</h2>
          
          <table class="table product-info-table mb-4">
            <tbody>
              <tr>
                <th scope="row">시작가</th>
                <td>50,000원</td>
              </tr>
              <tr>
                <th scope="row">현재가</th>
                <td class="price-current">75,000원</td>
              </tr>
              <tr>
                <th scope="row">남은 시간</th>
                <td class="time-left">
                  <i class="bi bi-clock-history"></i> 2일 15시간 30분
                </td>
              </tr>
              <tr>
                <th scope="row">입찰 기록</th>
                <td>
                  총 8회
                  <a href="#" class="ms-2 text-decoration-none">[기록 보기]</a>
                </td>
              </tr>
            </tbody>
          </table>

          <div class="d-grid gap-2 mb-4">
              <button class="btn btn-outline-dark" type="button" data-bs-toggle="offcanvas" data-bs-target="#chatOffcanvas" aria-controls="chatOffcanvas">
                  <i class="bi bi-chat-dots"></i> 물품 채팅방 (단체)
              </button>
          </div>

          <div class="mt-auto"> <%-- 이 div는 flex-grow를 통해 위로 밀려난 컨텐츠를 아래에 고정시킵니다 --%>
              <div class="input-group mb-3">
                <span class="input-group-text">희망입찰가</span>
                <%-- 2. type="number" 제거 및 inputmode="numeric" 추가 --%>
                <input type="text" class="form-control form-control-lg text-end" id="bidInput" inputmode="numeric">
                <span class="input-group-text">원</span>
              </div>
    
              <div class="d-flex gap-2 mb-4 flex-wrap">
                <button class="btn btn-sm btn-outline-secondary" data-increase="1000">+1천원</button>
                <button class="btn btn-sm btn-outline-secondary" data-increase="5000">+5천원</button>
                <button class="btn btn-sm btn-outline-secondary" data-increase="10000">+1만원</button>
                <button class="btn btn-sm btn-outline-secondary" data-increase="50000">+5만원</button>
              </div>
    
              <div class="d-flex gap-2">
                <button id="likeButton" type="button" class="btn btn-light">
                  <i id="heartIcon" class="bi bi-heart fs-5"></i>
                </button>
                <button class="btn btn-bid-primary btn-lg flex-grow-1" type="button">
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
            <p>20세기 초반의 타자기 감성을 그대로 재현한 빈티지 기계식 키보드입니다.</p>
            <p>실사용 횟수 적어 상태 매우 깨끗하며, 모든 키 정상적으로 작동합니다.</p>
            <p>묵직한 타건감과 레트로한 디자인으로 인테리어 소품으로도 활용 가치가 높습니다.</p>
          </div>
          <hr class="my-3">
          <div class="seller-info d-flex justify-content-between align-items-center flex-wrap gap-3 p-3">
            <div>
              <span class="fw-bold fs-5">레트로마스터</span>
              <span class="ms-2 rating">
                <i class="bi bi-star-fill"></i>
                <i class="bi bi-star-fill"></i>
                <i class="bi bi-star-fill"></i>
                <i class="bi bi-star-fill"></i>
                <i class="bi bi-star-half"></i>
                <span class="text-dark">(4.5)</span>
              </span>
            </div>
            <div class="d-grid gap-2 d-md-block">
                <button type="button" class="btn btn-dark">
                  <i class="bi bi-person-plus-fill"></i> 판매자 팔로우
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

    // 가격 정보 가져오기
    const currentPriceText = document.querySelector('.price-current').innerText;
    const currentPrice = parseInt(currentPriceText.replace(/[^\d]/g, ''), 10);
    const bidInput = document.getElementById('bidInput');
    const nextBidPrice = currentPrice + 1000; // 최소 입찰가는 현재가 + 1000원

    // 2. 가격 입력 자동 포맷팅 스크립트
    function formatNumber(number) {
        return new Intl.NumberFormat('ko-KR').format(number);
    }

    function unformatNumber(string) {
        return parseInt(string.replace(/,/g, ''), 10) || 0;
    }

    // 페이지 로드 시 초기값 설정 및 포맷팅
    bidInput.value = formatNumber(nextBidPrice);

    // 입력 시마다 숫자 포맷팅
    bidInput.addEventListener('input', (e) => {
        const value = e.target.value;
        const numericValue = unformatNumber(value);
        
        if (!isNaN(numericValue)) {
            bidInput.value = formatNumber(numericValue);
        } else {
            bidInput.value = '';
        }
    });

    // 버튼으로 입찰가 증가
    document.querySelectorAll('[data-increase]').forEach(button => {
      button.addEventListener('click', () => {
        let currentValue = unformatNumber(bidInput.value);
        let increment = parseInt(button.getAttribute('data-increase'), 10);
        bidInput.value = formatNumber(currentValue + increment);
      });
    });

    // 입력창에서 포커스가 벗어날 때 최소 입찰가보다 낮으면 보정
    bidInput.addEventListener('blur', () => {
      let value = unformatNumber(bidInput.value);
      if (isNaN(value) || value < nextBidPrice) {
        bidInput.value = formatNumber(nextBidPrice);
      }
    });
  </script>
</body>
</html>