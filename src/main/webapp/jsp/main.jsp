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

<!-- BootStrap JS (CSS는 header.jsp에서 넣었으면 그대로 두면 됨) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</head>

<body>
  <!-- header.jsp -->
  <jsp:include page="header.jsp" />

  <!-- maingrid.jsp -->
  <jsp:include page="maingrid.jsp" />

  <!-- 실시간 경매 상품 -->
  <div class="container mt-4">
    <h4 class="text-center my-4">🔥 실시간 경매 상품</h4>

    <div class="row justify-content-center">
      <div class="col-md-4">
        <a href="../jsp/item.jsp" class="text-decoration-none text-dark">
          <div class="card shadow-sm h-100 position-relative">
            <div class="item-status-label">
              <span class="status active">판매중</span> <!-- 또는 .closed -->
            </div>

            <img src="http://gd3.alicdn.com/imgextra/i3/54410696/TB2vkTrbrMlyKJjSZFlXXbMoFXa_!!54410696.jpg_640x640.jpg?Text=Image+1"
                 class="card-img-top" alt="상품 이미지">

            <div class="card-body">
              <h5 class="card-title">고급스러운 빈티지 기계식 키보드</h5>
              <p class="card-text text-danger fw-bold">현재가: 75,000원</p>
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
