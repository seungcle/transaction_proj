<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="subag_errorPage.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>수박나라 - 국내 최대 중고거래 경매사이트</title>
<style>
	body{
		background-color: #f7fff7 !important;
	}
	.item-left{
		margin: 10px 30px;
		margin-left:200px;
		width: 20%;
	}
	.item-explan{
		backgroun-color: #ffffff;
	}
</style>

<!-- BootStrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<style>
	@font-face {
    	font-family: 'MaplestoryOTFBold';
    	src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_20-04@2.1/MaplestoryOTFBold.woff') format('woff');
    	font-weight: normal;
    	font-style: normal;
    	}
		body {
            background-color: var(--melon-bg);
            color: #333;
            }
	</style>
</head>
<body>
<!-- header.jsp -->
 <jsp:include page="header.jsp" />
 <!-- maingrid.jsp -->
  <jsp:include page="maingrid.jsp" />
  
<!-- 실시간 경매 상품 -->
<div class="container mt-4">
  <h4 class="mb-4">🔥 실시간 경매 상품</h4>

  <div class="row justify-content-center">
    <div class="col-md-4">
      <div class="card shadow-sm">
        <a href="../jsp/item.jsp">
          <img src="http://gd3.alicdn.com/imgextra/i3/54410696/TB2vkTrbrMlyKJjSZFlXXbMoFXa_!!54410696.jpg_640x640.jpg?Text=Image+1"
               class="card-img-top" alt="상품 이미지">
        </a>
        <div class="card-body">
          <h5 class="card-title">고급스러운 빈티지 기계식 키보드</h5>
          <p class="card-text text-danger fw-bold">현재가: 75,000원</p>
        </div>
      </div>
    </div>
  </div>
</div>

  <!-- footer.jsp -->
   <jsp:include page="footer.jsp" />
</body>
</html>