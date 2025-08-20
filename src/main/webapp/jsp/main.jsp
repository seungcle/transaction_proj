<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="subag_errorPage.jsp" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>수박처럼 시원한 중고 가격</title>

  <!-- 공통 CSS -->
  <link rel="stylesheet" href="/subak/css/global.css">
  <link rel="stylesheet" href="/subak/css/layout.css">
  <link rel="stylesheet" href="/subak/css/card.css">
</head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<body>
  <!-- header.jsp -->
  <jsp:include page="header.jsp" />

  <!-- maingrid.jsp -->
  <jsp:include page="maingrid.jsp" />

  <!-- 실시간 경매 상품 -->
  <div class="container mt-4">
    <h4 class="text-center my-4">🔥 실시간 경매 상품</h4>
    <hr>

    <div class="row justify-content-center">
      <!-- 빈티지 키보드 -->
      <div class="col-md-4 mb-4">
        <a href="../jsp/item.jsp?itemId=101" class="text-decoration-none text-dark">
          <div class="card shadow-sm h-100 position-relative">
            <div class="item-status-label"><span class="status active">판매중</span></div>
            <img src="http://gd3.alicdn.com/imgextra/i3/54410696/TB2vkTrbrMlyKJjSZFlXXbMoFXa_!!54410696.jpg_640x640.jpg?Text=Image+1"
                 class="card-img-top" alt="빈티지 키보드">
            <div class="card-body">
              <h5 class="card-title">빈티지 기계식 키보드</h5>
              <p class="card-text text-danger fw-bold">현재가: 75,000원</p>
            </div>
          </div>
        </a>
      </div>

      <!-- 캠핑용 랜턴 -->
      <div class="col-md-4 mb-4">
        <a href="../jsp/item.jsp?itemId=102" class="text-decoration-none text-dark">
          <div class="card shadow-sm h-100 position-relative">
            <div class="item-status-label"><span class="status active">판매중</span></div>
            <img src="https://image.ohousecdn.com/i/bucketplace-v2-development/uploads/productions/163773272252100026.jpg?w=256&h=256&c=c&q=50"
                 class="card-img-top" alt="캠핑 랜턴">
            <div class="card-body">
              <h5 class="card-title">빈티지 캠핑용 랜턴</h5>
              <p class="card-text text-danger fw-bold">현재가: 32,000원</p>
            </div>
          </div>
        </a>
      </div>

      <!-- 클래식 시계 -->
      <div class="col-md-4 mb-4">
        <a href="../jsp/item.jsp?itemId=103" class="text-decoration-none text-dark">
          <div class="card shadow-sm h-100 position-relative">
            <div class="item-status-label"><span class="status active">판매중</span></div>
            <img src="https://img.gqkorea.co.kr/gq/2024/07/style_66823d69d3b4d.jpg"
                 class="card-img-top" alt="클래식 시계">
            <div class="card-body">
              <h5 class="card-title">클래식 손목 시계</h5>
              <p class="card-text text-danger fw-bold">현재가: 4,380,000,000원</p>
            </div>
          </div>
        </a>
      </div>
    </div>
  </div>

  <!-- footer.jsp -->
  <jsp:include page="footer.jsp" />
</body>
</html>
