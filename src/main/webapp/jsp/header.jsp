<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 아이콘 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<!-- 전역/헤더 CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">

<%
    String currentCategory = request.getParameter("category");
%>

<!-- Header -->
<header class="header">
  <a class="logo" href="${pageContext.request.contextPath}/jsp/main.jsp">
    <img id="main-icon" src="${pageContext.request.contextPath}/images/watermelon_icon.png" alt="수박 아이콘">
    <span>수박나라</span>
  </a>
  <div class="header-right">
    <form class="search-box" method="get" action="/subak/jsp/search.jsp">
      <input type="text" class="search-txt" name="keyword" placeholder="원하는 상품을 검색하세요..." id="searchInput">
      <button type="submit" class="search-btn" id="searchBtn">
        <i class="fa-solid fa-magnifying-glass"></i>
      </button>
    </form>

    <div id="high-icon">
      <a href="/subak/jsp/sale.jsp" class="text-white"><i class="fas fa-shopping-cart"></i> 판매</a>
      <a href="#" class="text-white" data-bs-toggle="offcanvas" data-bs-target="#notificationOffcanvas" aria-controls="notificationOffcanvas"><i class="fas fa-bell"></i> 알림</a>
      <a href="${pageContext.request.contextPath}/jsp/login.jsp" class="text-white"><i class="fas fa-user"></i> 로그인</a> /
      <a href="/subak/jsp/mypage.jsp" class="text-white"><i class="fas fa-user"></i> 마이페이지</a>
    </div>
  </div>
</header>

<!-- 카테고리 -->
<nav class="category-nav">
  <div class="container">
    <ul class="nav d-flex justify-content-center">
      <li class="nav-item">
        <a class="nav-link <%= currentCategory == null ? "active" : "" %>" href="/subak/jsp/main.jsp" data-category="all">
          <img class="icon" src="${pageContext.request.contextPath}/images/fire.png" alt="인기 아이콘"> 인기
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link <%= "디지털".equals(currentCategory) ? "active" : "" %>" href="/subak/jsp/search.jsp?category=디지털" data-category="electronics">
          <img class="icon" src="${pageContext.request.contextPath}/images/phone.png" alt="핸드폰 아이콘"> 디지털
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link <%= "패션".equals(currentCategory) ? "active" : "" %>" href="/subak/jsp/search.jsp?category=패션" data-category="fashion">
          <img class="icon" src="${pageContext.request.contextPath}/images/cloth.png" alt="옷 아이콘"> 패션
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link <%= "뷰티".equals(currentCategory) ? "active" : "" %>" href="/subak/jsp/search.jsp?category=뷰티" data-category="beauty">
          <img class="icon" src="${pageContext.request.contextPath}/images/makeup.png" alt="뷰티 아이콘"> 뷰티
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link <%= "가구".equals(currentCategory) ? "active" : "" %>" href="/subak/jsp/search.jsp?category=가구" data-category="furniture">
          <img class="icon" src="${pageContext.request.contextPath}/images/sofar.png" alt="소파 아이콘"> 가구
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link <%= "도서".equals(currentCategory) ? "active" : "" %>" href="/subak/jsp/search.jsp?category=도서" data-category="books">
          <img class="icon" src="${pageContext.request.contextPath}/images/book.png" alt="책 아이콘"> 도서
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link <%= "스포츠".equals(currentCategory) ? "active" : "" %>" href="/subak/jsp/search.jsp?category=스포츠" data-category="sports">
          <img class="icon" src="${pageContext.request.contextPath}/images/ball.png" alt="공 아이콘"> 스포츠
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link <%= "생활".equals(currentCategory) ? "active" : "" %>" href="/subak/jsp/search.jsp?category=생활" data-category="auction">
          <img class="icon" src="${pageContext.request.contextPath}/images/living.png" alt="청소 아이콘"> 생활
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link <%= "관심".equals(currentCategory) ? "active" : "" %>" href="/subak/jsp/search.jsp?category=관심" data-category="interest">
          <img class="icon" src="${pageContext.request.contextPath}/images/heart.png" alt="관심 아이콘"> 관심
        </a>
      </li>
    </ul>
  </div>
  <hr>
</nav>

<!-- 숨겨진 동영상 영역 -->
<div id="easterVideo" style="display:none; position:fixed; top:120px; left:20px; width:400px; background:#fff; border:2px solid #ccc; padding:10px; z-index:9999; box-shadow:0 0 10px rgba(0,0,0,0.3);">
  <div style="display:flex; justify-content:space-between; align-items:center;">
    <h4 style="margin:0;">🎉 수박나라 이스터에그 발견!</h4>
    <button id="closeVideoBtn" style="background:none; border:none; font-size:20px; cursor:pointer;">&times;</button>
  </div>
  <video controls width="100%">
    <source src="${pageContext.request.contextPath}/videos/watermelon-dance.mp4" type="video/mp4">
    이 브라우저는 동영상 태그를 지원하지 않습니다.
  </video>
</div>


<!-- 알림 영역 -->
<jsp:include page="notification.jsp"/>

<!-- 이스터에그 스크립트 -->
<script>
const searchBtn = document.getElementById('searchBtn');
const searchInput = document.getElementById('searchInput');
const videoBox = document.getElementById('easterVideo');
const closeBtn = document.getElementById('closeVideoBtn');

searchBtn.addEventListener('click', () => {
  const input = searchInput.value.trim().toLowerCase();
  if (input.includes('이승찬')) {
    videoBox.style.display = 'block';
    searchInput.value = '';
  }
});

closeBtn.addEventListener('click', () => {
  videoBox.style.display = 'none';
});
</script>
