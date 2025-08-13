<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>수박나라 메인</title>
  <style>
  	#mainCarousel {
      width: 55%;
      margin: 2rem auto;
    }
    .carousel-item img {
      width: 100%;
      height: auto;
      display: block;
    }
  </style>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
  <div id="mainCarousel" class="carousel slide mb-5 rounded-4 overflow-hidden"
    data-bs-ride="carousel"
    data-bs-interval="3000"
    data-bs-pause="hover">
    <div class="carousel-inner">
      <div class="carousel-item active">
        <img src="../images/sell.png" class="d-block w-100" alt="판매 가이드">
      </div>
      <div class="carousel-item">
        <img src="../images/sale.png" class="d-block w-100" alt="구매 가이드">
      </div>
      <div class="carousel-item">
        <img src="../images/welcome.png" class="d-block w-100" alt="어서와">
      </div>
    </div>

    <!-- 이전 버튼 -->
    <button
      class="carousel-control-prev"
      type="button"
      data-bs-target="#mainCarousel"
      data-bs-slide="prev"
    >
      <span class="carousel-control-prev-icon"></span>
      <span class="visually-hidden">Previous</span>
    </button>

    <!-- 다음 버튼 -->
    <button
      class="carousel-control-next"
      type="button"
      data-bs-target="#mainCarousel"
      data-bs-slide="next"
    >
      <span class="carousel-control-next-icon"></span>
      <span class="visually-hidden">Next</span>
    </button>
  </div>

 
</body>
</html>
