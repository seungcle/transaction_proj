<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>

<!-- 아이콘 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<!-- 전역/헤더 CSS (부트스트랩 CSS보다 뒤에 오게 배치 권장) -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
</head>
<body>

<script>
/* 카테고리 버튼 active 유지 */
document.addEventListener('DOMContentLoaded', function() {
  const navLinks = document.querySelectorAll('.category-nav .nav-link');
  navLinks.forEach(link => {
    link.addEventListener('click', function(e) {
      e.preventDefault();
      navLinks.forEach(item => item.classList.remove('active'));
      this.classList.add('active');
    });
  });
});
</script>

<!-- Header -->
<header class="header">
  <a class="logo" href="${pageContext.request.contextPath}/jsp/main.jsp">
    <img id="main-icon" src="${pageContext.request.contextPath}/images/watermelon_icon.png" alt="수박 아이콘">
    <span>수박나라</span>
  </a>
  <div class="header-right">
    <form class="search-box">
      <input type="text" class="search-txt" placeholder="원하는 상품을 검색하세요..." id="searchInput">
      <button type="button" class="search-btn" id="searchBtn">
        <i class="fa-solid fa-magnifying-glass"></i>
      </button>
    </form>

    <div id="high-icon">
      <a href="#" class="text-white"><i class="fas fa-shopping-cart"></i> 판매</a>
      <a href="#" class="text-white"><i class="fas fa-bell"></i> 알림</a>
      <a href="${pageContext.request.contextPath}/jsp/login.jsp" class="text-white"><i class="fas fa-user"></i> 로그인</a>
    </div>
  </div>
</header>

<!-- 카테고리 -->
<nav class="category-nav">
  <div class="container">
    <ul class="nav d-flex justify-content-center">
      <li class="nav-item">
        <a class="nav-link active" href="#" data-category="all">
          <img class="icon" src="${pageContext.request.contextPath}/images/fire.png" alt="인기 아이콘"> 인기
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#" data-category="electronics">
          <img class="icon" src="${pageContext.request.contextPath}/images/phone.png" alt="핸드폰 아이콘"> 디지털
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#" data-category="fashion">
          <img class="icon" src="${pageContext.request.contextPath}/images/cloth.png" alt="옷 아이콘"> 패션
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#" data-category="beauty">
          <img class="icon" src="${pageContext.request.contextPath}/images/makeup.png" alt="뷰티 아이콘"> 뷰티
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#" data-category="furniture">
          <img class="icon" src="${pageContext.request.contextPath}/images/sofar.png" alt="소파 아이콘"> 가구
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#" data-category="books">
          <img class="icon" src="${pageContext.request.contextPath}/images/book.png" alt="책 아이콘"> 도서
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#" data-category="sports">
          <img class="icon" src="${pageContext.request.contextPath}/images/ball.png" alt="공 아이콘"> 스포츠
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#" data-category="auction">
          <img class="icon" src="${pageContext.request.contextPath}/images/living.png" alt="청소 아이콘"> 생활
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#" data-category="interest">
          <img class="icon" src="${pageContext.request.contextPath}/images/heart.png" alt="관심 아이콘"> 관심
        </a>
      </li>
    </ul>
  </div>
  <hr>
</nav>

</body>
</html>
