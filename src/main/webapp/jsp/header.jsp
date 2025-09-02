<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">

<%
String currentCategory = request.getParameter("category");
%>

<header class="header">
	<button class="hamburger-btn" id="hamburgerBtn">
		<i class="fas fa-bars"></i>
	</button>

	<a class="logo" href="${pageContext.request.contextPath}/jsp/main.jsp"> <img id="main-icon" src="${pageContext.request.contextPath}/images/watermelon_icon.png" alt="수박 아이콘"> <span id="title">수박나라</span>
	</a>

	<form class="search-box" method="get" action="${pageContext.request.contextPath}/jsp/search.jsp">
		<input type="text" class="search-txt" name="keyword" placeholder="원하는 상품을 검색하세요..." id="searchInput">
		<button type="submit" class="search-btn" id="searchBtn">
			<i class="fa-solid fa-magnifying-glass"></i>
		</button>
	</form>

	<div class="header-right">
		<div id="high-icon">
			<a href="${pageContext.request.contextPath}/jsp/sale.jsp"><img src="../images/cart.png" class="icon-images"><span class="fa-text">판매</span></a> <a href="#" data-bs-toggle="offcanvas" data-bs-target="#notificationOffcanvas" aria-controls="notificationOffcanvas"><img src="../images/bell.png" class="icon-images"> <span class="fa-text">알림</span></a>
			<%-- <a href="${pageContext.request.contextPath}/jsp/login.jsp" class="login-group"><img src="../images/human.png" class="icon-images"> <span class="fa-text">로그인</span></a> --%>
			/ <a href="${pageContext.request.contextPath}/jsp/mypage.jsp" class="login-group"><img src="../images/human.png" class="icon-images"> <span class="fa-text">마이페이지</span></a>
		</div>
	</div>
</header>

<nav class="category-nav" id="categoryNav">
	<button class="close-btn" id="closeNavBtn">&times;</button>
	<div class="container">
		<ul class="nav d-flex">
			<li class="nav-item"><a class="nav-link <%= currentCategory == null ? "active" : "" %>" href="${pageContext.request.contextPath}/jsp/main.jsp" data-category="all"> <img class="icon" src="${pageContext.request.contextPath}/images/fire.png" alt="인기 아이콘"> 인기
			</a></li>
			<li class="nav-item"><a class="nav-link <%= "디지털".equals(currentCategory) ? "active" : "" %>" href="${pageContext.request.contextPath}/jsp/search.jsp?category=디지털" data-category="electronics"> <img class="icon" src="${pageContext.request.contextPath}/images/phone.png" alt="핸드폰 아이콘"> 디지털
			</a></li>
			<li class="nav-item"><a class="nav-link <%= "패션".equals(currentCategory) ? "active" : "" %>" href="${pageContext.request.contextPath}/jsp/search.jsp?category=패션" data-category="fashion"> <img class="icon" src="${pageContext.request.contextPath}/images/cloth.png" alt="옷 아이콘"> 패션
			</a></li>
			<li class="nav-item"><a class="nav-link <%= "뷰티".equals(currentCategory) ? "active" : "" %>" href="${pageContext.request.contextPath}/jsp/search.jsp?category=뷰티" data-category="beauty"> <img class="icon" src="${pageContext.request.contextPath}/images/makeup.png" alt="뷰티 아이콘"> 뷰티
			</a></li>
			<li class="nav-item"><a class="nav-link <%= "가구".equals(currentCategory) ? "active" : "" %>" href="${pageContext.request.contextPath}/jsp/search.jsp?category=가구" data-category="furniture"> <img class="icon" src="${pageContext.request.contextPath}/images/sofar.png" alt="소파 아이콘"> 가구
			</a></li>
			<li class="nav-item"><a class="nav-link <%= "도서".equals(currentCategory) ? "active" : "" %>" href="${pageContext.request.contextPath}/jsp/search.jsp?category=도서" data-category="books"> <img class="icon" src="${pageContext.request.contextPath}/images/book.png" alt="책 아이콘"> 도서
			</a></li>
			<li class="nav-item"><a class="nav-link <%= "스포츠".equals(currentCategory) ? "active" : "" %>" href="${pageContext.request.contextPath}/jsp/search.jsp?category=스포츠" data-category="sports"> <img class="icon" src="${pageContext.request.contextPath}/images/ball.png" alt="공 아이콘"> 스포츠
			</a></li>
			<li class="nav-item"><a class="nav-link <%= "생활".equals(currentCategory) ? "active" : "" %>" href="${pageContext.request.contextPath}/jsp/search.jsp?category=생활" data-category="auction"> <img class="icon" src="${pageContext.request.contextPath}/images/living.png" alt="청소 아이콘"> 생활
			</a></li>
			<li class="nav-item"><a class="nav-link <%= "관심".equals(currentCategory) ? "active" : "" %>" href="${pageContext.request.contextPath}/jsp/search.jsp?category=관심" data-category="interest"> <img class="icon" src="${pageContext.request.contextPath}/images/heart.png" alt="관심 아이콘"> 관심
			</a></li>
		</ul>
	</div>
	<hr>
</nav>

<div class="overlay" id="overlay"></div>

<div id="easterVideo" style="display: none; position: fixed; top: 120px; left: 20px; width: 400px; background: #fff; border: 2px solid #ccc; padding: 10px; z-index: 9999; box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);">
	<div style="display: flex; justify-content: space-between; align-items: center;">
		<h4 style="margin: 0;">🎉 수박나라 이스터에그 발견!</h4>
		<button id="closeVideoBtn" style="background: none; border: none; font-size: 20px; cursor: pointer;">&times;</button>
	</div>
	<video controls width="100%">
		<source src="${pageContext.request.contextPath}/videos/watermelon-dance.mp4" type="video/mp4">
		이 브라우저는 동영상 태그를 지원하지 않습니다.
	</video>
</div>


<jsp:include page="notification.jsp" />

<script>
document.addEventListener('DOMContentLoaded', function() {
    // 이스터에그 스크립트
    const searchBtn = document.getElementById('searchBtn');
    const searchInput = document.getElementById('searchInput');
    const videoBox = document.getElementById('easterVideo');
    const closeVideoBtn = document.getElementById('closeVideoBtn');

    if (searchBtn) {
        searchBtn.addEventListener('mouseover', () => {
            const input = searchInput.value.trim().toLowerCase();
            if (input.includes('이승찬')) {
                videoBox.style.display = 'block';
                searchInput.value = '';
            }
        });
    }

    if (closeVideoBtn) {
        closeVideoBtn.addEventListener('click', () => {
            videoBox.style.display = 'none';
        });
    }

    // 반응형 햄버거 메뉴 스크립트
    const hamburgerBtn = document.getElementById('hamburgerBtn');
    const categoryNav = document.getElementById('categoryNav');
    const closeNavBtn = document.getElementById('closeNavBtn');
    const overlay = document.getElementById('overlay');

    const openNav = () => {
        categoryNav.classList.add('open');
        overlay.classList.add('show');
        document.body.style.overflow = 'hidden'; // 스크롤 방지
    };

    const closeNav = () => {
        categoryNav.classList.remove('open');
        overlay.classList.remove('show');
        document.body.style.overflow = ''; // 스크롤 복원
    };

    if (hamburgerBtn) {
        hamburgerBtn.addEventListener('click', openNav);
    }
    
    if (closeNavBtn) {
        closeNavBtn.addEventListener('click', closeNav);
    }

    if (overlay) {
        overlay.addEventListener('click', closeNav);
    }
});
</script>